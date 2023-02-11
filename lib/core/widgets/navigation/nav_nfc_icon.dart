import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/core/bloc/app_bloc.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/widgets/animations/animation_fade_transition.dart';
import 'package:genesis/core/widgets/navigation/nav_core.dart';
import 'package:genesis/features/scanner/screens/scanner_screen.dart';
import 'package:genesis/features/scanner/widgets/nfc_icon.dart';

class NavNFCIcon extends StatelessWidget {
  final Curve curve;

  const NavNFCIcon({
    Key? key,
    this.curve = StyleConstants.kEaseInOutBackCustom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final horizontalPadding = mq.size.width * 0.03;

    return BlocBuilder<AppBloc, AppBlocState>(
      buildWhen: (prev, current) {
        return prev.routes.last != current.routes.last ||
            prev.routeToRemove != current.routeToRemove;
      },
      builder: (context, state) {
        if (state.routes.last != ScannerScreen.screenIndex) {
          return Container();
        }

        return Positioned(
          bottom: NavigationCore.getBottomCurtainSize(context) + (StyleConstants.kDefaultPadding * 2.0),
          right: StyleConstants.kDefaultPadding + horizontalPadding,
          child: AnimationFadeTransition(
            curve: curve,
            opacity: 1.0,
            isActive: state.routeToRemove != ScannerScreen.screenIndex,
            child: const NFCIcon(),
          ),
        );
      },
    );
  }
}