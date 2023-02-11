class ChipPayload {
  final String tokenID;
  final String chipID;

  const ChipPayload({
    required this.tokenID,
    required this.chipID,
  });

  static ChipPayload fromJson(Map<String, dynamic> json) {
    return ChipPayload(
      tokenID: json['tokenID'] ?? 'null',
      chipID: json['chipID'] ?? 'null',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tokenID': tokenID,
      'chipID': chipID,
    };
  }

  @override
  String toString() {
    return tokenID + chipID;
  }
}
