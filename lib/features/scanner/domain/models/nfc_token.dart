import 'package:nfc_manager/nfc_manager.dart';

class NFCToken {
  final String tokenID;
  final Ndef ndef;

  const NFCToken({
    required this.tokenID,
    required this.ndef,
  });
}
