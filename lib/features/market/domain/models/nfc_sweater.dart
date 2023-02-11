import 'package:genesis/features/market/domain/models/nfc_sweater_ownership.dart';

enum CryptoCurrency {
  none,
  btc,
  eth,
}

class NFCSweater {
  final int? tokenID, number;
  final String title, edition, description;
  final CryptoCurrency currency;
  final List<NFCSweaterOwnership> ownership;
  final String? imageSrc, chipSrc, qrSrc;
  final double? price;
  final int? amount;

  const NFCSweater({
    this.tokenID,
    this.number,
    required this.title,
    required this.edition,
    required this.description,
    required this.currency,
    this.ownership = const [],
    this.imageSrc,
    this.chipSrc,
    this.qrSrc,
    this.price,
    this.amount,
  });

  NFCSweater copyWith({
    int? tokenID,
    int? number,
    String? title,
    String? edition,
    String? description,
    CryptoCurrency? currency,
    List<NFCSweaterOwnership>? ownership,
    String? imageSrc,
    String? chipSrc,
    String? qrSrc,
    double? price,
    int? amount,
  }) {
    return NFCSweater(
      tokenID: tokenID ?? this.tokenID,
      number: number ?? this.number,
      title: title ?? this.title,
      edition: edition ?? this.edition,
      description: description ?? this.description,
      currency: currency ?? this.currency,
      ownership: ownership ?? this.ownership,
      imageSrc: imageSrc ?? this.imageSrc,
      chipSrc: chipSrc ?? this.chipSrc,
      qrSrc: qrSrc ?? this.qrSrc,
      price: price ?? this.price,
      amount: amount ?? this.amount,
    );
  }
}
