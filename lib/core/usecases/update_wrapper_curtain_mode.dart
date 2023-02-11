import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';

class UpdateWrapperCurtainMode implements Usecase<void, NoParams> {
  final AppBloc bloc;

  const UpdateWrapperCurtainMode({
    required this.bloc,
  });

  @override
  Future<void> call(
    NoParams params, {
    bool isTopCurtainEnabled = false,
    bool isBottomCurtainEnabled = false,
  }) async {
    logDebug('UpdateWrapperCurtainMode usecase -> call($isTopCurtainEnabled, $isBottomCurtainEnabled)');
    if (bloc.state.isTopCurtainEnabled == isTopCurtainEnabled &&
        bloc.state.isBottomCurtainEnabled == isBottomCurtainEnabled) {
      return;
    }

    bloc.add(AppUpdateWrapperCurtainMode(
      isTopCurtainEnabled: isTopCurtainEnabled,
      isBottomCurtainEnabled: isBottomCurtainEnabled,
    ));
  }
}
