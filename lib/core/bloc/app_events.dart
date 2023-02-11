part of 'app_bloc.dart';

abstract class AppBlocEvent {
  const AppBlocEvent([List props = const []]) : super();
}

class AppUpdateWrapperCurtainMode extends AppBlocEvent {
  final bool isTopCurtainEnabled;
  final bool isBottomCurtainEnabled;

  AppUpdateWrapperCurtainMode({
    required this.isTopCurtainEnabled,
    required this.isBottomCurtainEnabled,
  }) : super([isTopCurtainEnabled, isBottomCurtainEnabled]);
}

class AppUpdateNetworkConnectionMode extends AppBlocEvent {
  final bool isNetworkEnabled;

  AppUpdateNetworkConnectionMode({required this.isNetworkEnabled})
      : super([isNetworkEnabled]);
}

class AppPushScreen extends AppBlocEvent {
  final int screenIndex;

  AppPushScreen({required this.screenIndex}) : super([screenIndex]);
}

class AppPopScreen extends AppBlocEvent {
  AppPopScreen() : super([]);
}

class AppUpdateRouteToRemove extends AppBlocEvent {
  final int? screenIndex;

  AppUpdateRouteToRemove({required this.screenIndex}) : super([screenIndex]);
}