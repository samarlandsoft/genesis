import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/widgets/navigation/nav_core.dart';
import 'package:genesis/core/widgets/salt_animated_loader.dart';
import 'package:genesis/core/widgets/wrappers/content_wrapper.dart';
import 'package:genesis/features/market/domain/bloc/market_bloc.dart';
import 'package:genesis/features/market/widgets/sweater_card_extended.dart';

class MarketDetailsScreen extends StatelessWidget {
  static const screenIndex = 3;

  const MarketDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenCenter = (mq.size.height - mq.viewPadding.top) * 0.5;
    final wrapperVerticalPadding = mq.viewPadding.top +
        StyleConstants.kDefaultPadding +
        NavigationCore.getLabelSize(context);
    final loaderSize = mq.size.width * 0.5;

    return BlocBuilder<MarketBloc, MarketBlocState>(
      builder: (context, state) {
        return ContentWrapper(
          widget: state.activeSweater != null
              ? SweaterCardExtended(
                  sweater: state.activeSweater!,
                )
              : Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: screenCenter -
                          wrapperVerticalPadding -
                          loaderSize * 0.5,
                      child: SaltAnimatedLoader(size: loaderSize),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
