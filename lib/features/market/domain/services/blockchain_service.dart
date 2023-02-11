import 'package:http/http.dart';
import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater.dart';
import 'package:genesis/features/market/domain/models/nfc_sweater_ownership.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainService {
  static const _infuraRpcUrl =
      'https://mainnet.infura.io/v3/cf0b58d90da3413a8bd02e75a6d79e89';
  static const _infuraJWT =
      'qheWk2th7PypXhPtJGw5TtfKjcmTH3BqKbm7cVu4726WaEMe38NUCGXuRZCLFhjpFkDa2CtekgrVHCSvx9fQ6HPHvzjKaWrsYFS2KtZ9uXGGYd8FyrKrgTCFSvjSPE5PRxq29f2bq8HaP8eR4MekDGNbUDEPxkxgs9cdKqFkYyDGECQ39vUw3UfreAam4QttTpvgvMn2zrU8QVBL7JKYSxHEF3WLMn6NZ8kGsUGzc2rRgqWfhVBzmJUYmYUg4Qg2';

  static const _saltandsatoshiSellerContractABI =
      '[{"inputs":[{"internalType":"uint256","name":"_initialPrice","type":"uint256"},{"internalType":"uint256","name":"_priceStep","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[],"name":"Pause","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"payee","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"balance","type":"uint256"}],"name":"Sent","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"payer","type":"address"},{"indexed":true,"internalType":"address","name":"nftAddress","type":"address"},{"indexed":true,"internalType":"uint256","name":"tokenId","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"TokenPurchase","type":"event"},{"anonymous":false,"inputs":[],"name":"Unpause","type":"event"},{"inputs":[],"name":"currentPrice","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"destroy","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address payable","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"pause","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"paused","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"priceStep","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_nftAddress","type":"address"},{"internalType":"uint256","name":"_tokenId","type":"uint256"}],"name":"purchaseToken","outputs":[],"stateMutability":"payable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_payee","type":"address"},{"internalType":"uint256","name":"_amount","type":"uint256"}],"name":"sendTo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address payable","name":"_newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"unpause","outputs":[],"stateMutability":"nonpayable","type":"function"}]';
  static const _erc721ABI =
      '[{"constant":true,"inputs":[{"name":"interfaceId","type":"bytes4"}],"name":"supportsInterface","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"tokenId","type":"uint256"}],"name":"getApproved","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"tokenId","type":"uint256"}],"name":"approve","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"giver","type":"address"},{"name":"recipients","type":"address[]"},{"name":"values","type":"uint256[]"}],"name":"batchTransfer","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"from","type":"address"},{"name":"to","type":"address"},{"name":"tokenId","type":"uint256"}],"name":"transferFrom","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"owner","type":"address"},{"name":"index","type":"uint256"}],"name":"tokenOfOwnerByIndex","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"from","type":"address"},{"name":"to","type":"address"},{"name":"tokenId","type":"uint256"}],"name":"safeTransferFrom","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"tokenId","type":"uint256"}],"name":"burn","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"destroyAndSend","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"index","type":"uint256"}],"name":"tokenByIndex","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"maker","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"tokenId","type":"uint256"},{"name":"tokenURI","type":"string"}],"name":"mintWithTokenURI","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"tokenId","type":"uint256"}],"name":"ownerOf","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"renounceOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_tokenId","type":"uint256"}],"name":"buyThing","outputs":[{"name":"","type":"bool"}],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"owner","type":"address"}],"name":"tokensOfOwner","outputs":[{"name":"","type":"uint256[]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"isOwner","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"account","type":"address"}],"name":"addMinter","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"amountToMint","type":"uint256"},{"name":"metaId","type":"string"},{"name":"setPrice","type":"uint256"},{"name":"isForSale","type":"bool"}],"name":"batchMint","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"renounceMinter","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"baseUri","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"to","type":"address"},{"name":"approved","type":"bool"}],"name":"setApprovalForAll","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"account","type":"address"}],"name":"isMinter","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"id","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"from","type":"address"},{"name":"to","type":"address"},{"name":"tokenId","type":"uint256"},{"name":"_data","type":"bytes"}],"name":"safeTransferFrom","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"uint256"}],"name":"items","outputs":[{"name":"tokenId","type":"uint256"},{"name":"price","type":"uint256"},{"name":"metaId","type":"string"},{"name":"state","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"_tokenId","type":"uint256"}],"name":"tokenURI","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"ids","type":"uint256[]"},{"name":"isEnabled","type":"bool"}],"name":"setTokenState","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"tokenIds","type":"uint256[]"}],"name":"batchBurn","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"ids","type":"uint256[]"},{"name":"setPrice","type":"uint256"}],"name":"setTokenPrice","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"owner","type":"address"},{"name":"operator","type":"address"}],"name":"isApprovedForAll","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"name","type":"string"},{"name":"symbol","type":"string"},{"name":"uri","type":"string"},{"name":"fee","type":"address"},{"name":"creator","type":"address"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"error","type":"string"},{"indexed":false,"name":"tokenId","type":"uint256"}],"name":"ErrorOut","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"metaId","type":"string"},{"indexed":false,"name":"recipients","type":"address[]"},{"indexed":false,"name":"ids","type":"uint256[]"}],"name":"BatchTransfered","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"id","type":"uint256"},{"indexed":false,"name":"metaId","type":"string"}],"name":"Minted","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"metaId","type":"string"},{"indexed":false,"name":"ids","type":"uint256[]"}],"name":"BatchBurned","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"ids","type":"uint256[]"},{"indexed":false,"name":"metaId","type":"string"}],"name":"BatchForSale","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"tokenId","type":"uint256"},{"indexed":false,"name":"metaId","type":"string"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Bought","type":"event"},{"anonymous":false,"inputs":[],"name":"Destroy","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"previousOwner","type":"address"},{"indexed":true,"name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"account","type":"address"}],"name":"MinterAdded","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"account","type":"address"}],"name":"MinterRemoved","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":true,"name":"tokenId","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"},{"indexed":true,"name":"approved","type":"address"},{"indexed":true,"name":"tokenId","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"},{"indexed":true,"name":"operator","type":"address"},{"indexed":false,"name":"approved","type":"bool"}],"name":"ApprovalForAll","type":"event"}]';

  static const _saltandsatoshiSellerContractBTC =
      '0xf6aA869d2A727565cC85eC90D8497aE72B3E0a4f';
  static const _saltandsatoshiSellerContractETH =
      '0x400a31ba7e9d428040b20eabdb329e54124f4013';
  static const _saltandsatoshiGenesisNFTContract =
      '0xc31A599012Bc168c758cbeCf85d95D41eF3370a4';

  static const Map<CryptoCurrency, String> _contracts = {
    CryptoCurrency.btc: _saltandsatoshiSellerContractBTC,
    CryptoCurrency.eth: _saltandsatoshiSellerContractETH,
  };

  static const priceStep = 0.2815789473685;
  static const _initialPrice = 1.55;
  static const _ethereumAvgBlocksPerDay = 6400;

  final _httpClient = HttpClientWithCustomHeaders(headers: {});

  Future<double> getCurrentPrice(CryptoCurrency currency) async {
    logDebug('BlockchainService -> getBalance($currency)');

    // INIT WEB3
    // var web3 = new WEB3_DART.Web3Client(INFURA_RPC_URL, new HttpClientWithCustomHeaders({
    //   "Authorization": "Bearer ${INFURA_JWT}",
    // }));

    // GET MY ETH BALANCE
    // var myAddress = WEB3_DART.EthereumAddress.fromHex("0xC5Ddcb2812dd0D6a61a94310E4AA57c5122438Ca");
    // var balance = await web3.getBalance(myAddress);
    // print(balance.getValueInUnit(WEB3_DART.EtherUnit.ether));

    final web3 = Web3Client(_infuraRpcUrl, _httpClient);
    final sellerContractAddress =
        EthereumAddress.fromHex(_contracts[currency]!);
    final sellerContract = DeployedContract(
      ContractAbi.fromJson(_saltandsatoshiSellerContractABI, 'Seller'),
      sellerContractAddress,
    );

    final getCurrentPriceFunction = sellerContract.function('currentPrice');
    final currentPriceResult = await web3.call(
        contract: sellerContract,
        function: getCurrentPriceFunction,
        params: []);

    BigInt currentPriceAsBigInt = currentPriceResult[0];
    EtherAmount currentPrice = EtherAmount.inWei(currentPriceAsBigInt);

    logDebug(
        'Current price [$currency]: ${currentPrice.getValueInUnit(EtherUnit.ether)}');
    var formattedPrice =
        currentPrice.getValueInUnit(EtherUnit.ether).toDouble();

    await web3.dispose();
    return formattedPrice;
  }

  Future<List<NFCSweaterOwnership>> getOwnershipHistory(CryptoCurrency currency) async {
    logDebug('BlockchainService -> getOwnershipHistory($currency)');

    final web3 = Web3Client(_infuraRpcUrl, _httpClient);
    final sellerContractAddress =
        EthereumAddress.fromHex(_contracts[currency]!);
    final sellerContract = DeployedContract(
      ContractAbi.fromJson(_saltandsatoshiSellerContractABI, 'Seller'),
      sellerContractAddress,
    );

    final genesisNFTContractAddress =
        EthereumAddress.fromHex(_saltandsatoshiGenesisNFTContract);
    final genesisNFTContract = DeployedContract(
      ContractAbi.fromJson(_erc721ABI, 'Thing'),
      genesisNFTContractAddress,
    );

    /// Listen for the Transfer event when it's emitted by the contract above
    final tokenPurchaseEvent = sellerContract.event('TokenPurchase');
    final transferEvent = genesisNFTContract.event('Transfer');

    final fromBlockNumber =
        (await web3.getBlockNumber()) - 365 * _ethereumAvgBlocksPerDay;
    final fromBlock = BlockNum.exact(fromBlockNumber);

    final List<NFCSweaterOwnership> histories = [];

    // Strategy A
    // final subscription = web3
    //     .events(WEB3_DART.FilterOptions.events(contract: sellerContract, event: tokenPurchaseEvent, fromBlock: fromBlock))
    //     .take(1)
    //     .listen((event) {
    //       // final decoded = transferEvent.decodeResults(event.topics, event.data);
    //       // final from = decoded[0] as EthereumAddress;
    //       // final to = decoded[1] as EthereumAddress;
    //       // final value = decoded[2] as BigInt;
    //       print('EVENT topics = ${event.topics} data = ${event.data}');
    //     });
    // await subscription.asFuture();
    // await subscription.cancel();

    // Strategy B
    // final eventLogs = await web3.getLogs(FilterOptions.events(
    //   contract: sellerContract,
    //   event: tokenPurchaseEvent,
    //   fromBlock: fromBlock,
    // ));

    // Strategy C
    final transferEventLogs = await web3.getLogs(FilterOptions.events(
      contract: genesisNFTContract,
      event: transferEvent,
      fromBlock: fromBlock,
    ));

    for (var event in transferEventLogs) {
      final decoded = transferEvent.decodeResults(event.topics!, event.data!);
      final history = NFCSweaterOwnership(
        payer: decoded[0] as EthereumAddress,
        nft: decoded[1] as EthereumAddress,
        tokenID: decoded[2] as BigInt,
        blockNum: event.blockNum!,
      );
      histories.add(history);
    }

    return histories;
  }

  double getSweaterPrice(int sweaterNumber) {
    logDebug('BlockchainService -> getSweaterPrice($sweaterNumber)');
    final double price = _initialPrice + (priceStep * sweaterNumber);
    return double.parse(price.toStringAsFixed(2));
  }

  int getAmountSoldSweaters(double currentPrice) {
    logDebug('BlockchainService -> getAmountSoldSweaters($currentPrice)');
    return (currentPrice - _initialPrice) ~/ priceStep;
  }
}

class HttpClientWithCustomHeaders extends BaseClient {
  final _httpClient = Client();
  final Map<String, String> headers;

  HttpClientWithCustomHeaders({required this.headers});

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    request.headers.addAll(headers);
    return _httpClient.send(request);
  }
}
