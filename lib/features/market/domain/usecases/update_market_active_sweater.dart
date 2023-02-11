import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';

class UpdateMarketActiveSweater implements Usecase<void, NFCSweater?> {
  final MarketBloc bloc;

  const UpdateMarketActiveSweater({required this.bloc});

  @override
  Future<void> call(NFCSweater? sweater) async {
    logDebug('UpdateMarketActiveSweater usecase -> call(${sweater?.tokenID})');
    if (bloc.state.activeSweater == sweater) return;
    bloc.add(MarketUpdateActiveSweater(activeSweater: sweater));
  }
}
