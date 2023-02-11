import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';

class UpdateMarketSweaters implements Usecase<void, List<NFCSweater>> {
  final MarketBloc bloc;

  const UpdateMarketSweaters({required this.bloc});

  @override
  Future<void> call(List<NFCSweater> sweaters) async {
    logDebug('UpdateMarketSweaters usecase -> call(${sweaters.length})');
    if (bloc.state.sweaters == sweaters) return;
    bloc.add(MarketUpdateSweaters(sweaters: sweaters));
  }
}