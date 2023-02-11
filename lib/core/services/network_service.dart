import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/core/usecases/update_network_connection_mode.dart';

class NetworkService {
  final UpdateNetworkConnectionMode updateNetworkConnectionMode;

  NetworkService({required this.updateNetworkConnectionMode});

  final Connectivity _connectivity = Connectivity();

  void listenNetworkChanges() {
    logDebug('NetworkService -> listenNetworkChanges()');
    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        updateNetworkConnectionMode.call(false);
      } else {
        updateNetworkConnectionMode.call(true);
      }
    });
  }

  Future<bool> checkNetworkConnection() async {
    logDebug('NetworkService -> checkNetworkConnection()');
    return (await _connectivity.checkConnectivity()) != ConnectivityResult.none;
  }
}