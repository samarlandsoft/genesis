import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/core/services/network_service.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater_ownership.dart';
import 'package:genesis/features/market/domain/services/blockchain_service.dart';

class GetBlockchainOwnership implements Usecase<List<NFCSweaterOwnership>?, CryptoCurrency> {
  final BlockchainService blockchainService;
  final NetworkService networkService;

  const GetBlockchainOwnership({
    required this.blockchainService,
    required this.networkService,
  });

  @override
  Future<List<NFCSweaterOwnership>?> call(CryptoCurrency currency) async {
    logDebug('GetBlockchainOwnerships usecase -> call($currency)');
    if (!await networkService.checkNetworkConnection()) {
      return null;
    }
    return await blockchainService.getOwnershipHistory(currency);
  }
}
