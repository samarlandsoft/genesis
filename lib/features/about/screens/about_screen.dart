import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/widgets/wrappers/content_wrapper.dart';
import 'package:genesis/features/about/widgets/salt_link_icon.dart';

class AboutScreen extends StatelessWidget {
  static const screenIndex = 4;

  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return ContentWrapper(
      widget: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'JOIN SALTDAO',
              style: TextStyle(
                fontSize: StyleConstants.kGetLargeTextSize(context),
              ),
            ),
          ),
          SizedBox(
            height: isLargeScreen
                ? StyleConstants.kDefaultPadding * 1.5
                : StyleConstants.kDefaultPadding * 0.5,
          ),
          const Text(
              'We\'re a growing community dedicated to providing the most fulfilling NFT community experience available.'),
          SizedBox(
            height: isLargeScreen
                ? StyleConstants.kDefaultPadding * 1.5
                : StyleConstants.kDefaultPadding,
          ),
          const Text(
              'Joining SaltDAO is free but holding \$SALTY will allow you to progress the ranks, vote on governance proposals and obtain access to exclusive rewards and more!'),
          SizedBox(
            height: isLargeScreen
                ? StyleConstants.kDefaultPadding * 2.0
                : StyleConstants.kDefaultPadding,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SaltLinkIcon(
                      label: 'DISCORD',
                      iconSrc: 'assets/images/discord.png',
                      url: 'https://discord.com/invite/Zj7PnT5EEw',
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * 0.46,
                    ),
                    SaltLinkIcon(
                      label: 'SNAPSHOT',
                      iconSrc: 'assets/images/storm.png',
                      url: 'https://snapshot.org/#/saltdao.eth',
                      height: constraints.maxHeight,
                      width: constraints.maxWidth * 0.46,
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: isLargeScreen
                ? StyleConstants.kDefaultPadding * 2.0
                : StyleConstants.kDefaultPadding,
          ),
        ],
      ),
    );
  }
}
