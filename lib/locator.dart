import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/services/license_service.dart';
import 'package:genesis/core/services/network_service.dart';
import 'package:genesis/core/services/web_view_service.dart';
import 'package:genesis/core/usecases/pop_current_screen.dart';
import 'package:genesis/core/usecases/push_next_screen.dart';
import 'package:genesis/core/usecases/update_network_connection_mode.dart';
import 'package:genesis/core/usecases/update_wrapper_curtain_mode.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';
import 'package:genesis/features/market/domain/services/blockchain_service.dart';
import 'package:genesis/features/market/domain/usecases/get_blockchain_available_prices.dart';
import 'package:genesis/features/market/domain/usecases/get_blockchain_nfc_data.dart';
import 'package:genesis/features/market/domain/usecases/get_blockchain_ownership.dart';
import 'package:genesis/features/market/domain/usecases/init_market.dart';
import 'package:genesis/features/market/domain/usecases/update_market_active_sweater.dart';
import 'package:genesis/features/market/domain/usecases/update_market_mode.dart';
import 'package:genesis/features/market/domain/usecases/update_market_ownerships.dart';
import 'package:genesis/features/market/domain/usecases/update_market_sweaters.dart';
import 'package:genesis/features/scanner/domain/services/encryptor_service.dart';
import 'package:genesis/features/scanner/domain/services/nfc_service.dart';
import 'package:genesis/features/scanner/domain/usecases/read_nfc_chip.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void initLocator() {
  _initCore();
  _initScanner();
  _initMarket();
}

void _initCore() {
  /// Blocs
  locator.registerLazySingleton(() => AppBloc(AppBlocState.initial()));

  /// Services
  locator.registerLazySingleton(() => LicenseService());
  locator.registerLazySingleton(
    () => WebViewService(
      networkService: locator<NetworkService>(),
    ),
  );
  locator.registerLazySingleton(
    () => NetworkService(
      updateNetworkConnectionMode: locator<UpdateNetworkConnectionMode>(),
    ),
  );

  /// Usecases
  locator.registerLazySingleton(
    () => UpdateWrapperCurtainMode(
      bloc: locator<AppBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateNetworkConnectionMode(
      bloc: locator<AppBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => PushNextScreen(
      bloc: locator<AppBloc>(),
      updateWrapperCurtainMode: locator<UpdateWrapperCurtainMode>(),
    ),
  );
  locator.registerLazySingleton(
    () => PopCurrentScreen(
      bloc: locator<AppBloc>(),
      updateWrapperCurtainMode: locator<UpdateWrapperCurtainMode>(),
    ),
  );
}

void _initScanner() {
  /// Services
  locator.registerLazySingleton(() => NFCService());
  locator.registerLazySingleton(() => EncryptorService());

  /// Usecases
  locator.registerLazySingleton(
    () => ReadNFCChip(
      nfcService: locator<NFCService>(),
      encryptorService: locator<EncryptorService>(),
    ),
  );
}

void _initMarket() {
  /// Blocs
  locator.registerLazySingleton(() => MarketBloc(MarketBlocState.initial()));

  /// Services
  locator.registerLazySingleton(() => BlockchainService());

  /// Usecases
  locator.registerLazySingleton(
    () => InitMarket(
      bloc: locator<MarketBloc>(),
      networkService: locator<NetworkService>(),
      getBlockchainPrices: locator<GetBlockchainAvailablePrices>(),
      getBlockchainOwnership: locator<GetBlockchainOwnership>(),
      updateMarketSweaters: locator<UpdateMarketSweaters>(),
      updateMarketOwnerships: locator<UpdateMarketOwnerships>(),
      updateMarketMode: locator<UpdateMarketMode>(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateMarketSweaters(
      bloc: locator<MarketBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateMarketOwnerships(
      bloc: locator<MarketBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateMarketActiveSweater(
      bloc: locator<MarketBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => UpdateMarketMode(
      bloc: locator<MarketBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => GetBlockchainAvailablePrices(
      blockchainService: locator<BlockchainService>(),
      networkService: locator<NetworkService>(),
    ),
  );
  locator.registerLazySingleton(
    () => GetBlockchainNFCData(
      bloc: locator<MarketBloc>(),
      blockchainService: locator<BlockchainService>(),
      networkService: locator<NetworkService>(),
      updateMarketActiveSweater: locator<UpdateMarketActiveSweater>(),
    ),
  );
  locator.registerLazySingleton(
    () => GetBlockchainOwnership(
      blockchainService: locator<BlockchainService>(),
      networkService: locator<NetworkService>(),
    ),
  );
}
