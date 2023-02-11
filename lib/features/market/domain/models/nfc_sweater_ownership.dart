import 'package:web3dart/web3dart.dart';

class NFCSweaterOwnership {
  final EthereumAddress payer;
  final EthereumAddress nft;
  final BigInt tokenID;
  final int blockNum;

  const NFCSweaterOwnership({
    required this.payer,
    required this.nft,
    required this.tokenID,
    required this.blockNum,
  });
}
