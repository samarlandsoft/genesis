part of 'market_bloc.dart';

class MarketBlocState {
  final List<NFCSweater> sweaters;
  final Map<CryptoCurrency, List<NFCSweaterOwnership>> ownerships;
  final NFCSweater? activeSweater;
  final bool isMarketInit;

  const MarketBlocState({
    required this.sweaters,
    this.ownerships = const {},
    this.activeSweater,
    this.isMarketInit = false,
  });

  factory MarketBlocState.initial() {
    return const MarketBlocState(
      sweaters: [
        NFCSweater(
          title: 'Season 1 Can\'t Be Stopped',
          edition: 'Bitcoin Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          currency: CryptoCurrency.btc,
          imageSrc: 'assets/images/bitcoin_sweater.gif',
          qrSrc: 'assets/images/qr_code.png',
        ),
        NFCSweater(
          title: 'Season 1 Can\'t Be Stopped',
          edition: 'Ethereum Edition',
          description:
              'NFC-enabled Apparel + Artwork NFT + Digital Wearable + \$SALTY',
          currency: CryptoCurrency.eth,
          imageSrc: 'assets/images/ethereum_sweater.gif',
          qrSrc: 'assets/images/qr_code.png',
        ),
      ],
      isMarketInit: false,
    );
  }

  MarketBlocState update({
    List<NFCSweater>? sweaters,
    Map<CryptoCurrency, List<NFCSweaterOwnership>>? ownerships,
    NFCSweater? activeSweater,
    bool? isMarketInit,
  }) {
    return MarketBlocState(
      sweaters: sweaters ?? this.sweaters,
      ownerships: ownerships ?? this.ownerships,
      activeSweater: activeSweater ?? this.activeSweater,
      isMarketInit: isMarketInit ?? this.isMarketInit,
    );
  }
}
