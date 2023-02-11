import 'package:flutter/material.dart';
import 'package:genesis/core/constants.dart';

class SweaterDescription extends StatelessWidget {
  final String description;
  final double? price;
  final double size;

  const SweaterDescription({
    Key? key,
    required this.description,
    this.price,
    required this.size,
  }) : super(key: key);

  static double getDescriptionSize(
      BuildContext context, String description, double? price) {
    final mq = MediaQuery.of(context);
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    final descriptionSize = TextPainter(
      text: TextSpan(
        text: description,
        style: StyleConstants.kGetDefaultTextStyle(context).copyWith(
          fontSize: 12.0,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    final priceSize = TextPainter(
      text: TextSpan(
        text: 'Ξ ${price.toString()}',
        style: StyleConstants.kGetDefaultTextStyle(context).copyWith(
          fontSize: isLargeScreen ? 30.0 : 26.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: mq.size.width);

    return descriptionSize.height > priceSize.height
        ? descriptionSize.height
        : priceSize.height;
  }

  @override
  Widget build(BuildContext context) {
    final bool isLargeScreen = StyleConstants.kGetScreenRatio(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isLargeScreen
            ? StyleConstants.kDefaultPadding * 1.5
            : StyleConstants.kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: size * 0.55,
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
          Text(
            'Ξ ${price ?? 'N/A'}',
            style: TextStyle(
              fontSize: isLargeScreen ? 30.0 : 26.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
