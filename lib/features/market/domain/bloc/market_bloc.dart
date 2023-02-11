import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater_ownership.dart';

part 'market_events.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketBlocEvent, MarketBlocState> {
  MarketBloc(MarketBlocState initialState) : super(initialState) {
    on<MarketUpdateSweaters>((event, emit) {
      emit(state.update(sweaters: event.sweaters));
    });

    on<MarketUpdateOwnerships>((event, emit) {
      emit(state.update(ownerships: event.ownerships));
    });

    on<MarketUpdateActiveSweater>((event, emit) {
      emit(state.update(activeSweater: event.activeSweater));
    });

    on<MarketUpdateMode>((event, emit) {
      emit(state.update(isMarketInit: event.isInit));
    });
  }

  @override
  void onEvent(MarketBlocEvent event) {
    super.onEvent(event);
    logDebug('MarketBloc -> onEvent(): ${event.runtimeType}');
  }
}
