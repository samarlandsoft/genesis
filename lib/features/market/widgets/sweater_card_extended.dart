import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';
import 'package:genesis/core/services/web_view_service.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater_ownership.dart';
import 'package:genesis/features/market/widgets/sweater_counter.dart';
import 'package:genesis/features/market/widgets/sweater_description.dart';
import 'package:genesis/features/market/widgets/sweater_image_wrapper.dart';
import 'package:genesis/locator.dart';

class SweaterCardExtended extends StatefulWidget {
  final NFCSweater sweater;

  const SweaterCardExtended({
    Key? key,
    required this.sweater,
  }) : super(key: key);

  @override
  State<SweaterCardExtended> createState() => _SweaterCardExtendedState();
}

class _SweaterCardExtendedState extends State<SweaterCardExtended> {
  final _controller = PageController();
  var _activePage = 0;

  List<Widget> _getSweaterPage(double size, bool isLargeScreen) {
    return [
      SweaterImageWrapper(
        size: size,
        imageSrc: widget.sweater.imageSrc,
        chipSrc: widget.sweater.chipSrc,
        padding: isLargeScreen
            ? StyleConstants.kDefaultPadding
            : StyleConstants.kDefaultPadding * 0.5,
      ),
      _SweaterOwnershipHistory(
        ownership: widget.sweater.ownership,
        size: size,
      ),
      _SweaterQRCode(
        qrSrc: widget.sweater.qrSrc!,
        size: size,
      ),
    ];
  }

  void _onPageChanged(int index) {
    setState(() {
      _activePage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);
    final bool isEnableToBuy = widget.sweater.number! < widget.sweater.amount!;

    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.sweater.edition,
            style: TextStyle(
              fontSize: StyleConstants.kGetLargeTextSize(context),
            ),
          ),
        ),
        const SizedBox(
          height: StyleConstants.kDefaultPadding * 0.5,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              SweaterCounter(
                number: widget.sweater.number!,
                amount: widget.sweater.amount!,
              ),
              SizedBox(
                width: isLargeScreen
                    ? StyleConstants.kDefaultPadding * 1.5
                    : StyleConstants.kDefaultPadding * 1.0,
              ),
              Text(
                widget.sweater.title,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: isLargeScreen
              ? StyleConstants.kDefaultPadding
              : StyleConstants.kDefaultPadding * 0.5,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return PageView(
                controller: _controller,
                physics: isEnableToBuy ? null : const NeverScrollableScrollPhysics(),
                onPageChanged: _onPageChanged,
                children: _getSweaterPage(constraints.maxHeight, isLargeScreen),
              );
            },
          ),
        ),
        SizedBox(
          height: isLargeScreen
              ? StyleConstants.kDefaultPadding
              : StyleConstants.kDefaultPadding * 0.5,
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return SweaterDescription(
              description: widget.sweater.description,
              price: widget.sweater.price,
              size: constraints.maxWidth,
            );
          },
        ),
        SizedBox(
          height: isLargeScreen
              ? StyleConstants.kDefaultPadding * 2.0
              : StyleConstants.kDefaultPadding,
        ),
        _SweaterPagePanel(
          controller: _controller,
          activePage: _activePage,
          isEnableToBuy: isEnableToBuy,
        ),
        SizedBox(
          height: isLargeScreen
              ? StyleConstants.kDefaultPadding
              : StyleConstants.kDefaultPadding * 0.5,
        ),
      ],
    );
  }
}

class _SweaterPagePanel extends StatefulWidget {
  final PageController controller;
  final int activePage;
  final bool isEnableToBuy;

  const _SweaterPagePanel({
    Key? key,
    required this.controller,
    this.activePage = 0,
    this.isEnableToBuy = true,
  }) : super(key: key);

  static double getPanelSize(BuildContext context) {
    return StyleConstants.kGetScreenRatio(context)
        ? StyleConstants.kDefaultButtonSize
        : StyleConstants.kDefaultButtonSize * 0.75;
  }

  @override
  State<_SweaterPagePanel> createState() => _SweaterPagePanelState();
}

class _SweaterPagePanelState extends State<_SweaterPagePanel> {
  List<_SweaterPanelButton> _buttons() {
    return [
      _SweaterPanelButton(
        index: 0,
        label: 'WEAR',
        iconSrc: 'assets/icons/wear.png',
        callback: _onSwapPageHandler,
        isActive: widget.activePage == 0,
      ),
      _SweaterPanelButton(
        index: 1,
        label: 'HISTORY',
        iconSrc: 'assets/icons/history.png',
        callback: _onSwapPageHandler,
        isActive: widget.activePage == 1,
      ),
      _SweaterPanelButton(
        index: 2,
        label: 'QR CODE',
        iconSrc: 'assets/icons/qr.png',
        callback: _onSwapPageHandler,
        isActive: widget.activePage == 2,
      ),
      _SweaterPanelButton(
        index: 3,
        label: 'GO TO NFT',
        iconSrc: 'assets/icons/redirect.png',
        callback: _onSwapPageHandler,
        isActive: false,
      ),
    ];
  }

  void _onSwapPageHandler(int index) {
    if (index == 3) {
      locator<WebViewService>().openInWebView('https://www.saltandsatoshi.com');
    } else {
      widget.controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: _buttons().map((button) {
            final bool isDisabled = !widget.isEnableToBuy &&
                (button.index == 1 || button.index == 2);

            return SizedBox(
              height: _SweaterPagePanel.getPanelSize(context),
              width: constraints.maxWidth / _buttons().length,
              child: AbsorbPointer(
                absorbing: isDisabled,
                child: Opacity(
                  opacity: isDisabled ? 0.5 : 1.0,
                  child: button,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _SweaterPanelButton extends StatelessWidget {
  final int index;
  final String label;
  final String iconSrc;
  final Function(int) callback;
  final bool isActive;

  const _SweaterPanelButton({
    Key? key,
    required this.index,
    required this.label,
    required this.iconSrc,
    required this.callback,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return GestureDetector(
      onTap: () => callback(index),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isActive ? StyleConstants.kSelectedColor : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              iconSrc,
              height: isLargeScreen ? 30.0 : 20.0,
              width: isLargeScreen ? 30.0 : 20.0,
            ),
            const SizedBox(
              height: StyleConstants.kDefaultPadding * 0.2,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: isLargeScreen ? 12.0 : 11.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SweaterOwnershipHistory extends StatelessWidget {
  final List<NFCSweaterOwnership> ownership;
  final double size;

  const _SweaterOwnershipHistory({
    Key? key,
    required this.ownership,
    required this.size,
  }) : super(key: key);

  static const _initialAddress = '0x0000000000000000000000000000000000000000';
  static const _senderAddress = '0xd362db73b59a824558ffebdfc83073f9e364dbc6';

  void _onEtherscanOpenHandler(String address) {
    final url = 'https://etherscan.io/address/$address';
    locator<WebViewService>().openInWebView(url);
  }

  Widget _buildHistoryText(NFCSweaterOwnership history, bool isLargeScreen) {
    if (history.payer.toString() == _initialAddress) {
      return Text(
        'TOKEN CREATED',
        style: TextStyle(
          fontSize: isLargeScreen ? 18.0 : 15.0,
        ),
      );
    }

    return Row(
      children: <Widget>[
        Text(
          'NEW OWNER ',
          style: TextStyle(
            fontSize: isLargeScreen ? 18.0 : 15.0,
          ),
        ),
        GestureDetector(
          onTap: () => _onEtherscanOpenHandler(history.payer.toString()),
          child: Text(
            history.payer.toString().substring(0, 7),
            style: TextStyle(
              color: StyleConstants.kHyperLinkColor,
              fontSize: isLargeScreen ? 18.0 : 15.0,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    if (ownership.isNotEmpty) {
      ownership.sort((a, b) => a.blockNum.compareTo(b.blockNum));
    }

    return SizedBox(
      height: size,
      child: ListView.separated(
        itemCount: ownership.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          bottom: isLargeScreen
              ? StyleConstants.kDefaultPadding * 2.0
              : StyleConstants.kDefaultPadding,
        ),
        separatorBuilder: (context, index) {
          return const Divider(
            height: 10.0,
            thickness: 1.0,
            color: StyleConstants.kInactiveColor,
          );
        },
        itemBuilder: (context, index) {
          return SizedBox(
            height: isLargeScreen ? 40.0 : 28.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _buildHistoryText(ownership[index], isLargeScreen),
                Text(
                  ownership[index].blockNum.toString(),
                  style: TextStyle(
                    fontSize: isLargeScreen ? 18.0 : 15.0,
                    color: StyleConstants.kInactiveColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SweaterQRCode extends StatelessWidget {
  final String qrSrc;
  final double size;

  const _SweaterQRCode({
    Key? key,
    required this.qrSrc,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(size * 0.1),
      child: Image.asset(qrSrc),
    );
  }
}
