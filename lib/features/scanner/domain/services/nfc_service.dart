import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:genesis/core/models/failures.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/scanner/domain/models/nfc_failures.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCService {
  final NfcManager _nfcManager = NfcManager.instance;
  bool _isBusy = false;

  Future<Either<Failure, Ndef>> readTag() async {
    logDebug('NFCService -> readTag()');

    if (await _checkAvailabilityNfcManager()) {
      return Left(CommonFailure(
          NFCFailures.failuresMessages[NFCFailureType.serviceBusy]!));
    }

    Ndef? ndef;
    var isScanned = false;

    _nfcManager.startSession(onDiscovered: (NfcTag tag) async {
      ndef = Ndef.from(tag);
      isScanned = true;
      await _nfcManager.stopSession();
    });

    while (!isScanned) {
      await Future.delayed(const Duration(seconds: 1));
    }

    _isBusy = false;
    return ndef != null
        ? Right(ndef!)
        : Left(CommonFailure(
            NFCFailures.failuresMessages[NFCFailureType.notValidNDEF]!));
  }

  Future<bool> _checkAvailabilityNfcManager() async {
    if (_isBusy) {
      logDebug('Error: NFCService is busy right now');
      _isBusy = false;
      await _nfcManager.stopSession();
      return true;
    } else {
      _isBusy = true;
      return false;
    }
  }

  Future<bool> checkNFCAvailable() async {
    try {
      var isAvailable = await _nfcManager.isAvailable();
      if (!isAvailable) {
        logDebug('Error: NFCService isn\'t available');
      }
      return isAvailable;
    } on Exception catch (e) {
      logDebug('Exception: NFCService isn\'t available');
      return false;
    }
  }

  String getChipID(Uint8List bytes) {
    logDebug('NFCService -> getChipID()');
    var chipID = bytes.fold<String>('', (previousValue, element) {
      var converted = element.toRadixString(16);
      if (converted.length == 1) {
        converted = '0' + converted;
      }

      return previousValue += ':' + converted.toUpperCase();
    });

    return chipID.substring(1);
  }

  Future<void> cancelScanning() async {
    logDebug('NFCService -> cancelScanning()');
    _isBusy = false;
    await _nfcManager.stopSession();
  }
}
