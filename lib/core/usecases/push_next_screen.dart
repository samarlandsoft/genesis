import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:genesis/features/about/screens/about_screen.dart';
import 'package:genesis/features/market/screens/market_details_screen.dart';
import 'package:genesis/features/market/screens/market_screen.dart';
import 'package:genesis/features/scanner/screens/scanner_screen.dart';

class PushNextScreen implements Usecase<void, int> {
  final AppBloc bloc;
  final UpdateWrapperCurtainMode updateWrapperCurtainMode;

  const PushNextScreen({
    required this.bloc,
    required this.updateWrapperCurtainMode,
  });

  @override
  Future<void> call(int index) async {
    logDebug('PushNextScreen usecase -> call($index)');
    if (bloc.state.routes.contains(index)) return;
    bloc.add(AppPushScreen(screenIndex: index));

    switch (index) {
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

      case AboutScreen.screenIndex: {
        updateWrapperCurtainMode.call(
          NoParams(),
          isTopCurtainEnabled: true,
          isBottomCurtainEnabled: true,
        );
        break;
      }
    }
  }
}
