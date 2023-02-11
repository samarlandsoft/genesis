import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:genesis/features/home/screens/home_screen.dart';
import 'package:genesis/features/market/screens/market_details_screen.dart';
import 'package:genesis/features/market/screens/market_screen.dart';
import 'package:genesis/features/scanner/screens/scanner_screen.dart';

class PopCurrentScreen implements Usecase<void, NoParams> {
  final AppBloc bloc;
  final UpdateWrapperCurtainMode updateWrapperCurtainMode;

  const PopCurrentScreen({
    required this.bloc,
    required this.updateWrapperCurtainMode,
  });

  @override
  Future<void> call(NoParams params) async {
    logDebug('PopCurrentScreen usecase -> call()');

    final int lastIndex = bloc.state.routes.indexOf(bloc.state.routes.last);
    final int lastScreenIndex = bloc.state.routes[lastIndex];
    final int previousScreenIndex = bloc.state.routes[lastIndex - 1];

    final withDelay = (lastScreenIndex == MarketDetailsScreen.screenIndex && previousScreenIndex == MarketScreen.screenIndex) || (lastScreenIndex == ScannerScreen.screenIndex);

    switch (previousScreenIndex) {
      case HomeScreen.screenIndex: {
        updateWrapperCurtainMode.call(
          NoParams(),
          isTopCurtainEnabled: false,
          isBottomCurtainEnabled: false,
        );
        break;
      }

      case ScannerScreen.screenIndex: {
        updateWrapperCurtainMode.call(
          NoParams(),
          isTopCurtainEnabled: true,
          isBottomCurtainEnabled: true,
        );
        break;
      }

      case MarketScreen.screenIndex: {
        updateWrapperCurtainMode.call(
          NoParams(),
          isTopCurtainEnabled: false,
          isBottomCurtainEnabled: true,
        );
        break;
      }

      case MarketDetailsScreen.screenIndex: {
        updateWrapperCurtainMode.call(
          NoParams(),
          isTopCurtainEnabled: true,
          isBottomCurtainEnabled: true,
        );
        break;
      }
    }

    if (withDelay) {
      var delay = StyleConstants.kDefaultTransitionDuration + 50;

      bloc.add(AppUpdateRouteToRemove(screenIndex: bloc.state.routes[lastIndex]));
      await Future.delayed(Duration(milliseconds: delay)).then((_) {
        bloc.add(AppPopScreen());
        bloc.add(AppUpdateRouteToRemove(screenIndex: null));
      });
    } else {
      bloc.add(AppPopScreen());
    }
  }
}
