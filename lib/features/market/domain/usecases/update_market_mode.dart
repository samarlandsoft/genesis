import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';

class UpdateMarketMode implements Usecase<void, bool> {
  final MarketBloc bloc;

  const UpdateMarketMode({required this.bloc});

  @override
  Future<void> call(bool isInit) async {
    logDebug('UpdateMarketMode usecase -> call($isInit)');
    if (bloc.state.isMarketInit == isInit) return;
    bloc.add(MarketUpdateMode(isInit: isInit));
  }
}