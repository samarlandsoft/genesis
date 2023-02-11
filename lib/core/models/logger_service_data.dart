class LoggerServiceData {
  final String appName;
  final String appVersion;
  final String environmentId;
  final String? environmentName;
  final String? deviceName;
  final String deviceType;
  final String? deviceSdkInt;

  const LoggerServiceData({
    required this.appName,
    required this.appVersion,
    required this.environmentId,
    this.environmentName,
    this.deviceName,
    required this.deviceType,
    this.deviceSdkInt,
  });

  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'appVersion': appVersion,
      'environmentId': environmentId,
      'environmentName': environmentName,
      'deviceName': deviceName,
      'deviceType': deviceType,
      'deviceSdkInt': deviceSdkInt,
    };
  }

  @override
  String toString() {
    return 'App name: $appName\nApp version: $appVersion\nEnvironment id: $environmentId\nEnvironment name: $environmentName\nDevice name: $deviceName\nDevice type: $deviceType\nDevice SDK int: $deviceSdkInt';
  }
}
