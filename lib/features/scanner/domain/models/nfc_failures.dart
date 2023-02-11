enum NFCFailureType {
  notValidChip,
  notValidJWT,
  notValidNDEF,
  emptyPayload,
  insufficientMemory,
  serviceBusy,
}

class NFCFailures {
  static const Map<NFCFailureType, String> failuresMessages = {
    NFCFailureType.notValidChip: 'This chip is not valid',
    NFCFailureType.notValidJWT: 'This jwt is not valid',
    NFCFailureType.notValidNDEF: 'This chip doesn\'t support the NDEF',
    NFCFailureType.emptyPayload: 'Not payload in this chip',
    NFCFailureType.insufficientMemory: 'Not enough memory in this chip',
    NFCFailureType.serviceBusy: 'NFCService is busy',
  };
}