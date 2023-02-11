import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/home/screens/home_screen.dart';

part 'app_events.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  AppBloc(AppBlocState initialState) : super(initialState) {
    on<AppUpdateWrapperCurtainMode>((event, emit) {
      emit(state.update(
        isTopCurtainEnabled: event.isTopCurtainEnabled,
        isBottomCurtainEnabled: event.isBottomCurtainEnabled,
      ));
    });

    on<AppUpdateNetworkConnectionMode>((event, emit) {
      emit(state.update(isNetworkEnabled: event.isNetworkEnabled));
    });

    on<AppPushScreen>((event, emit) {
      final List<int> updatedRoutes = [...state.routes];
      if (!updatedRoutes.contains(event.screenIndex)) {
        updatedRoutes.add(event.screenIndex);
      }

      emit(state.update(routes: updatedRoutes));
    });

    on<AppPopScreen>((event, emit) {
      final List<int> updatedRoutes = [...state.routes];
      if (updatedRoutes.length != 1) {
        updatedRoutes.removeLast();
      }

      emit(state.update(routes: updatedRoutes));
    });

    on<AppUpdateRouteToRemove>((event, emit) {
      emit(state.update(routeToRemove: event.screenIndex));
    });
  }

  @override
  void onEvent(AppBlocEvent event) {
    super.onEvent(event);
    logDebug('AppBloc -> onEvent(): ${event.runtimeType}');
  }
}