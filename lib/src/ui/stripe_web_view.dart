
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebView extends StatefulWidget {
  const StripeWebView({Key? key, required this.uri, required this.returnUri})
      : super(key: key);

  final String uri;
  final Uri returnUri;

  @override
  State<StripeWebView> createState() => _StripeWebViewState();
}

class _StripeWebViewState extends State<StripeWebView> {
 late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..loadRequest(Uri.parse(widget.uri))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
          onNavigationRequest: (NavigationRequest navigation) {
        final uri = Uri.parse(navigation.url);
        if (uri.scheme == widget.returnUri.scheme &&
            uri.host == widget.returnUri.host &&
            uri.queryParameters['requestId'] ==
                widget.returnUri.queryParameters['requestId']) {
          Navigator.pop(context, true);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      }));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController,
    );
  }
}
