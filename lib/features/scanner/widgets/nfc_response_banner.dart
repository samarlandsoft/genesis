import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/widgets/buttons/salt_icon_button.dart';

class NFCResponseBanner extends StatelessWidget {
  final double height, width;
  final bool isError;
  final VoidCallback callback;

  const NFCResponseBanner({
    Key? key,
    required this.height,
    required this.width,
    required this.isError,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: isError
          ? StyleConstants.kSelectedColor
          : StyleConstants.kMarketColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: StyleConstants.kDefaultPadding),
              child: Text(
                isError
                    ? 'WRONG NFC TAG. TRY AGAIN.'
                    : 'NFC TAG DETECTED! REDIRECTING...',
                style: const TextStyle(fontSize: 16.0),
                maxLines: 2,
              ),
            ),
          ),
          VerticalDivider(
            width: 2.0,
            thickness: 2.0,
            color: StyleConstants.kBackgroundColor.withOpacity(0.5),
          ),
          SizedBox(
            height: height,
            width: height,
            child: Center(
              child: SaltIconButton(
                iconSrc: isError
                    ? 'assets/icons/close.png'
                    : 'assets/icons/redirect.png',
                callback: callback,
                size: height * 0.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
