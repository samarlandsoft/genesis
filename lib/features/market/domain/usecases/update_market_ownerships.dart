import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater_ownership.dart';

class UpdateMarketOwnerships implements Usecase<void, Map<CryptoCurrency, List<NFCSweaterOwnership>>> {
  final MarketBloc bloc;

  const UpdateMarketOwnerships({required this.bloc});

  @override
  Future<void> call(Map<CryptoCurrency, List<NFCSweaterOwnership>> ownerships) async {
    logDebug('UpdateMarketOwnerships usecase -> call(${ownerships.length})');
    if (bloc.state.ownerships == ownerships) return;
    bloc.add(MarketUpdateOwnerships(ownerships: ownerships));
  }
}
