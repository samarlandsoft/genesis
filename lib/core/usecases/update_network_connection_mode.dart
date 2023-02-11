import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/models/usecase.dart';
import 'package:genesis/core/services/logger_service.dart';

class UpdateNetworkConnectionMode implements Usecase<void, bool> {
  final AppBloc bloc;

  const UpdateNetworkConnectionMode({
    required this.bloc,
  });

  @override
  Future<void> call(bool isNetworkEnabled) async {
    logDebug('UpdateNetworkConnectionMode usecase -> call($isNetworkEnabled)');
    if (bloc.state.isNetworkEnabled == isNetworkEnabled) return;
    bloc.add(AppUpdateNetworkConnectionMode(isNetworkEnabled: isNetworkEnabled));
  }
}
