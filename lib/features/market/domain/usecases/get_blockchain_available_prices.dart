import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/core/services/network_service.dart';
import 'package:genesis/features/market/domain/datasources/blockchain_mock_database.dart';
import 'package:genesis/features/market/domain/models/blockchain_nfc_response.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';
import 'package:genesis/features/market/domain/services/blockchain_service.dart';

class GetBlockchainAvailablePrices implements Usecase<BlockchainNFCResponse?, CryptoCurrency> {
  final BlockchainService blockchainService;
  final NetworkService networkService;

  const GetBlockchainAvailablePrices({
    required this.blockchainService,
    required this.networkService,
  });

  @override
  Future<BlockchainNFCResponse?> call(CryptoCurrency currency, {bool isMarketInit = false}) async {
    logDebug('GetBlockchainPrices usecase -> call($currency, $isMarketInit)');
    if (!await networkService.checkNetworkConnection()) {
      return null;
    }

    final currentPrice = await blockchainService.getCurrentPrice(currency);
    final amountSoldSweaters =
        blockchainService.getAmountSoldSweaters(currentPrice);
    final currentNumber = isMarketInit ? amountSoldSweaters + 1 : amountSoldSweaters;
    final sweaterData = BlockchainMockDatabase.getSweaterByNumber(currentNumber, currency == CryptoCurrency.btc);

    if (currentNumber > 20) {
      return null;
    }

    return BlockchainNFCResponse(
      tokenID: sweaterData.tokenID,
      number: currentNumber,
      currency: currency,
      chipSrc: sweaterData.chipUrl,
      price: double.parse(currentPrice.toStringAsFixed(2)),
      amount: 20,
    );
  }
}
