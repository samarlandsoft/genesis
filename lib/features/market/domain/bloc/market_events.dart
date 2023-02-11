part of 'market_bloc.dart';

abstract class MarketBlocEvent {
  const MarketBlocEvent([List props = const []]) : super();
}

class MarketUpdateSweaters extends MarketBlocEvent {
  final List<NFCSweater> sweaters;

  MarketUpdateSweaters({required this.sweaters}) : super([sweaters]);
}

class MarketUpdateOwnerships extends MarketBlocEvent {
  final Map<CryptoCurrency, List<NFCSweaterOwnership>> ownerships;

  MarketUpdateOwnerships({required this.ownerships}) : super([ownerships]);
}

class MarketUpdateActiveSweater extends MarketBlocEvent {
  final NFCSweater? activeSweater;

  MarketUpdateActiveSweater({required this.activeSweater})
      : super([activeSweater]);
}

class MarketUpdateMode extends MarketBlocEvent {
  final bool isInit;

  MarketUpdateMode({required this.isInit}) : super([isInit]);
}
