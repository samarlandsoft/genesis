import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/widgets/animations/animation_fade_transition.dart';
import 'package:genesis/core/widgets/animations/animation_position_transition.dart';
import 'package:genesis/core/widgets/navigation/nav_core.dart';
import 'package:genesis/features/about/screens/about_screen.dart';
import 'package:genesis/features/market/screens/market_details_screen.dart';
import 'package:genesis/features/market/screens/market_screen.dart';
import 'package:genesis/features/scanner/screens/scanner_screen.dart';

class NavCurtainTop extends StatefulWidget {
  final Curve curve;
  final double lowerBoundValue;
  final double upperBoundValue;

  const NavCurtainTop({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
    required this.lowerBoundValue,
    required this.upperBoundValue,
  }) : super(key: key);

  @override
  State<NavCurtainTop> createState() => _NavCurtainTopState();
}

class _NavCurtainTopState extends State<NavCurtainTop> {
  double _getContentSize() {
    final mq = MediaQuery.of(context);
    return widget.upperBoundValue - widget.lowerBoundValue + mq.viewPadding.top;
  }

  double _getTopBoundValue(AppBlocState state) {
    final double labelHeight = NavigationCore.getLabelSize(context);
    final double topPadding = NavigationCore.getVerticalPadding(context);

    return state.isTopCurtainEnabled
        ? labelHeight + topPadding + StyleConstants.kDefaultPadding
        : -_getContentSize();
  }

  double _getBottomBoundValue(AppBlocState state) {
    return state.isTopCurtainEnabled
        ? 0.0
        : widget.lowerBoundValue +
            NavigationCore.getCurtainOverflowSize(context);
  }

  Widget _buildAboutBranch(AppBlocState state) {
    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildAboutBranch'),
      curve: widget.curve,
      upperBoundValue: _getTopBoundValue(state),
      lowerBoundValue: _getBottomBoundValue(state),
      child: AnimationFadeTransition(
        curve: StyleConstants.kEaseInOutCubicCustom,
        opacity: 1.0,
        isActive: state.isTopCurtainEnabled,
        child: const AboutScreen(),
      ),
    );
  }

  Widget _switchCurrentScreen(int screen) {
    final double topPadding = NavigationCore.getVerticalPadding(context) +
        NavigationCore.getLabelSize(context) +
        StyleConstants.kDefaultPadding;

    if (screen == ScannerScreen.screenIndex) {
      return const ScannerScreen();
    }

    if (screen == MarketDetailsScreen.screenIndex) {
      return Padding(
        key: const ValueKey('_buildScannerBranch_MarketDetailsScreen'),
        padding: EdgeInsets.only(top: topPadding),
        child: const MarketDetailsScreen(),
      );
    }

    return Padding(
      key: const ValueKey('_buildScannerBranch_AboutScreen'),
      padding: EdgeInsets.only(top: topPadding),
      child: const AboutScreen(),
    );
  }

  Widget _buildScannerBranch(AppBlocState state) {
    final double topHeight = state.isTopCurtainEnabled
        ? (_getContentSize() + widget.lowerBoundValue)
        : 0.0;

    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildScannerBranch'),
      curve: widget.curve,
      upperBoundValue: 0.0,
      height: topHeight,
      child: AnimatedSwitcher(
        duration: Duration(
            milliseconds:
                (StyleConstants.kDefaultTransitionDuration * 0.5).toInt()),
        switchOutCurve: Curves.ease,
        switchInCurve: Curves.ease,
        child: _switchCurrentScreen(state.routes.last),
      ),
    );
  }

  Widget _buildMarketBranch(AppBlocState state) {
    return AnimationPositionTransition(
      key: const ValueKey('_NavCurtainTop_buildAboutBranch'),
      curve: widget.curve,
      upperBoundValue: _getTopBoundValue(state),
      lowerBoundValue: _getBottomBoundValue(state),
      child: AnimationFadeTransition(
        curve: widget.curve,
        opacity: 1.0,
        isActive: state.isTopCurtainEnabled,
        child: _buildMarketDetailsBranch(state),
      ),
    );
  }

  Widget _buildMarketDetailsBranch(AppBlocState state) {
    final int previousScreen = state.routes.length != 1
        ? state.routes[state.routes.indexOf(state.routes.last) - 1]
        : state.routes.last;
    final double topPadding =
        (widget.lowerBoundValue + StyleConstants.kDefaultPadding * 2.0);

    return AnimationFadeTransition(
      curve: widget.curve,
      opacity: 1.0,
      isActive: state.isTopCurtainEnabled,
      child: AnimatedSwitcher(
        duration: Duration(
            milliseconds:
                (StyleConstants.kDefaultTransitionDuration * 0.5).toInt()),
        switchOutCurve: Curves.ease,
        switchInCurve: Curves.ease,
        child: state.routes.last == MarketDetailsScreen.screenIndex
            ? const MarketDetailsScreen()
            : Padding(
                padding: EdgeInsets.only(
                  top: state.routes[previousScreen] == MarketScreen.screenIndex
                      ? topPadding
                      : 0.0,
                ),
                child: const AboutScreen(),
              ),
      ),
    );
  }

  Widget _buildCurrentScreen(AppBlocState state) {
    if (state.routes.contains(ScannerScreen.screenIndex)) {
      return _buildScannerBranch(state);
    }

    if (state.routes.contains(MarketScreen.screenIndex)) {
      return _buildMarketBranch(state);
    }

    return _buildAboutBranch(state);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.isTopCurtainEnabled != current.isTopCurtainEnabled ||
            prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        return AnimationPositionTransition(
          key: const ValueKey('_NavCurtainTop'),
          curve: widget.curve,
          upperBoundValue: 0.0,
          lowerBoundValue: state.isTopCurtainEnabled
              ? widget.lowerBoundValue
              : widget.upperBoundValue,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: StyleConstants.kDefaultBlur,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ),
              _buildCurrentScreen(state),
            ],
          ),
        );
      },
    );
  }
}
