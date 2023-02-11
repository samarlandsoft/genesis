import 'dart:typed_data';

import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/scanner/domain/models/chip_payload.dart';
import 'package:genesis/features/scanner/domain/models/nfc_failures.dart';
import 'package:genesis/features/scanner/domain/models/nfc_response_data.dart';
import 'package:genesis/features/scanner/domain/services/encryptor_service.dart';
import 'package:genesis/features/scanner/domain/services/nfc_service.dart';

class ReadNFCChip implements Usecase<NFCResponseData, NoParams> {
  final NFCService nfcService;
  final EncryptorService encryptorService;

  const ReadNFCChip({
    required this.nfcService,
    required this.encryptorService,
  });

  @override
  Future<NFCResponseData> call(NoParams params) async {
    logDebug('ReadNFCChip usecase -> call()');

    var isSuccess = false;
    String? errorMessage;
    int? tokenData;
    var nfcResult = await nfcService.readTag();

    nfcResult.fold(
      (failure) {
        errorMessage = failure.error;
      },
      (token) {
        if (token.cachedMessage != null &&
            token.cachedMessage!.records.isNotEmpty) {
          var chipData = token.cachedMessage!.records[0].payload;
          var chipRecord = String.fromCharCodes(chipData).substring(3);

          logDebug('Data in chip: $chipData');
          logDebug('Record in chip: $chipRecord');

          var payload = ChipPayload(
            tokenID: chipRecord.split('.').first,
            chipID: nfcService
                .getChipID(token.additionalData['identifier'] as Uint8List),
          );

          var cryptoResult = encryptorService.verifyToken(chipRecord, payload);
          if (cryptoResult) {
            isSuccess = true;
            tokenData = int.parse(payload.tokenID);
          } else {
            errorMessage = NFCFailures.failuresMessages[NFCFailureType.notValidChip];
          }
        }
      },
    );

    return NFCResponseData(
      isSuccess: isSuccess,
      tokenID: tokenData,
      error: errorMessage,
    );
  }
}
