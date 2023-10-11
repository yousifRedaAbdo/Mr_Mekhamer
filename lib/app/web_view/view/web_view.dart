import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../base_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/texts.dart';
import '../view_model/web_view_view_model.dart';

class AppWebView extends StatelessWidget {
  String? url;
  String? title;

  AppWebView(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return BaseView<AppWebViewViewModel>(
      onModelReady: (viewModel) async {},
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: mainColor,
            title: appBarTitle(title!),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, true);
              return true;
            },
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: Uri.parse(url!)),
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                  onLoadStop: (controller, url) async {
                    await controller.evaluateJavascript(
                        source: viewModel.getJavaScriptInjection());
                    await controller.injectCSSFileFromUrl(
                        urlFile: Uri.parse(viewModel.cssInjectionUrl));
                  },
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                        allowUniversalAccessFromFileURLs: true,
                        allowFileAccessFromFileURLs: true,
                        useOnDownloadStart: true),
                    android: AndroidInAppWebViewOptions(
                      domStorageEnabled: true,
                      databaseEnabled: true,
                      clearSessionCache: true,
                      thirdPartyCookiesEnabled: true,
                      allowFileAccess: true,
                      allowContentAccess: true,
                    ),
                  ),
                  onProgressChanged: (controller, progress) {
                    viewModel.progress = progress / 100;
                    viewModel.updateState();
                  },
                  onWebViewCreated: (InAppWebViewController controller) {
                    viewModel.webViewController = controller;
                  },
                  onDownloadStartRequest: (controller, url) async {
                    await launchUrl(Uri.parse(url.toString()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
