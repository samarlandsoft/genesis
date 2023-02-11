import 'package:genesis/core/services/logger_service.dart';
import 'package:genesis/core/services/network_service.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewService {
  final NetworkService networkService;

  const WebViewService({required this.networkService});

  Future<void> openInWebView(String url) async {
    logDebug('WebViewService -> openInWebView($url)');
    if (!await networkService.checkNetworkConnection()) return;

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        launchUrl(Uri.parse(url));
      } else {
        logDebug('WebViewService exception: could not launch $url');
      }
    } on Exception catch (e) {
      logDebug('WebViewService exception: ${e.runtimeType}');
      throw 'WebViewService exception: could not launch $url';
    }
  }
}
