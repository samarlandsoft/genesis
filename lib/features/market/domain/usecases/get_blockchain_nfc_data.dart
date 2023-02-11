import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/core/services/network_service.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';
import 'package:genesis/features/market/domain/datasources/blockchain_mock_database.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';
import 'package:genesis/features/market/domain/services/blockchain_service.dart';
import 'package:genesis/features/market/domain/usecases/update_market_active_sweater.dart';

class GetBlockchainNFCData implements Usecase<void, int> {
  final MarketBloc bloc;
  final BlockchainService blockchainService;
  final NetworkService networkService;
  final UpdateMarketActiveSweater updateMarketActiveSweater;

  const GetBlockchainNFCData({
    required this.bloc,
    required this.blockchainService,
    required this.networkService,
    required this.updateMarketActiveSweater,
  });

  @override
  Future<void> call(int tokenID) async {
    logDebug('GetBlockchainNFCData usecase -> call($tokenID)');
    if (!await networkService.checkNetworkConnection()) {
      return;
    }

    final currency = tokenID > 22 ? CryptoCurrency.btc : CryptoCurrency.eth;
    final sweaterData = BlockchainMockDatabase.sweaterTokenURLs[tokenID];
    final price = blockchainService.getSweaterPrice(sweaterData!.number);

    updateMarketActiveSweater.call(NFCSweater(
      tokenID: tokenID,
      number: sweaterData.number,
      title: 'Season 1 Can\'t Be Stopped',
      edition: currency == CryptoCurrency.btc
          ? 'Bitcoin Edition'
          : 'Ethereum Edition',
      description:
          'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
      currency: currency,
      ownership: bloc.state.ownerships[currency] != null
          ? bloc.state.ownerships[currency]!
              .where((history) => history.tokenID.toInt() == tokenID)
              .toList()
          : [],
      chipSrc: sweaterData.chipUrl,
      qrSrc: 'assets/images/qr_code.png',
      price: price,
      amount: 20,
    ));
  }
}
