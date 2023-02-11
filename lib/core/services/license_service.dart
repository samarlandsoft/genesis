import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:genesis/core/services/logger_service.dart';

class LicenseService {
  void init() {
    logDebug('LicenseService -> init()');
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['fonts'], license);
    });
  }
}