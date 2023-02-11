class NFCResponseData {
  final bool isSuccess;
  final int? tokenID;
  final String? error;

  const NFCResponseData({
    required this.isSuccess,
    this.tokenID,
    this.error,
  });
}
