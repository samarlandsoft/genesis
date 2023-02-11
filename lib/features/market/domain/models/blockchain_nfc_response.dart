import 'package:genesis/features/market/domain/models/nfc_sweater.dart';

class BlockchainNFCResponse {
  final int? tokenID;
  final int? number;
  final CryptoCurrency currency;
  final String? chipSrc;
  final double? price;
  final int amount;

  const BlockchainNFCResponse({
    required this.tokenID,
    required this.number,
    required this.currency,
    required this.chipSrc,
    required this.price,
    required this.amount,
  });
}
