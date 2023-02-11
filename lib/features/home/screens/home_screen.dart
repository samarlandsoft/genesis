import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/usecases/push_next_screen.dart';
import 'package:genesis/core/widgets/buttons/salt_text_button.dart';
import 'package:genesis/core/widgets/wrappers/content_wrapper.dart';
import 'package:genesis/features/home/widgets/salt_circular_text.dart';
import 'package:genesis/features/home/widgets/salt_logo.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';
import 'package:genesis/features/market/screens/market_screen.dart';
import 'package:genesis/features/scanner/screens/scanner_screen.dart';
import 'package:genesis/locator.dart';

class HomeScreen extends StatelessWidget {
  static const screenIndex = 0;

  const HomeScreen({Key? key}) : super(key: key);

  void _onScanTappedHandler() {
    locator<PushNextScreen>().call(ScannerScreen.screenIndex);
  }

  void _onMarketTappedHandler() {
    locator<PushNextScreen>().call(MarketScreen.screenIndex);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenCenter = (mq.size.height - mq.viewPadding.top) * 0.5;
    final gestureSize = mq.size.width * 0.75;

    return BlocBuilder<MarketBloc, MarketBlocState>(
      buildWhen: (prev, current) {
        return prev.isMarketInit != current.isMarketInit;
      },
      builder: (context, marketState) {
        return ContentWrapper(
          widget: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: screenCenter - SaltLogo.getLogoSize(context) * 0.5,
                child: const SaltLogo(),
              ),
              Positioned(
                bottom: screenCenter -
                    SaltAnimatedCircularText.getTextRadius(context),
                child: const SaltAnimatedCircularText(),
              ),
              Positioned(
                bottom: screenCenter - gestureSize * 0.5,
                child: SizedBox(
                  height: gestureSize,
                  width: gestureSize,
                  child: GestureDetector(
                    onTap: _onScanTappedHandler,
                  ),
                ),
              ),
              Positioned(
                bottom: StyleConstants.kDefaultPadding * 2.0,
                child: BlocBuilder<AppBloc, AppBlocState>(
                  buildWhen: (prev, current) {
                    return prev.routeToRemove != current.routeToRemove;
                  },
                  builder: (context, appState) {
                    return AbsorbPointer(
                      absorbing: !marketState.isMarketInit ||
                          appState.routeToRemove == ScannerScreen.screenIndex,
                      child: SaltTextButton(
                        label: 'VIEW COLLECTION',
                        callback: _onMarketTappedHandler,
                        isLoading: !marketState.isMarketInit,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
