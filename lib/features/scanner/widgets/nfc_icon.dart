import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/features/scanner/domain/services/nfc_service.dart';
import 'package:genesis/locator.dart';

class NFCIcon extends StatefulWidget {
  const NFCIcon({Key? key}) : super(key: key);

  @override
  State<NFCIcon> createState() => _NFCIconState();
}

class _NFCIconState extends State<NFCIcon> {
  bool _isInit = false;
  bool _isNFCAvailable = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      locator<NFCService>().checkNFCAvailable().then((isAvailable) {
        setState(() {
          _isInit = true;
          _isNFCAvailable = isAvailable;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30.0,
          width: 30.0,
          child: Image.asset(
            'assets/icons/nfc.png',
            fit: BoxFit.fill,
            color: _isNFCAvailable
                ? StyleConstants.kHyperLinkColor
                : StyleConstants.kInactiveColor,
          ),
        ),
        const SizedBox(
          height: StyleConstants.kDefaultPadding * 0.4,
        ),
        Text(
          _isNFCAvailable ? 'NFC ONSITE' : 'NFC UNABLE',
          style: StyleConstants.kGetBoldTextStyle(context).copyWith(
            fontSize: 12.0,
            color: _isNFCAvailable
                ? StyleConstants.kHyperLinkColor
                : StyleConstants.kInactiveColor,
          ),
        ),
      ],
    );
  }
}
