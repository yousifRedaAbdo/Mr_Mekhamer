import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mohamed_mekhemar/app/home_drawer/view_model/home_drawer_view_model.dart';
import '../../../base_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/texts.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeDrawerViewModel>(
      onModelReady: (viewModel) {
        viewModel.getAboutUs();
      },
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: true,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: mainColor,
                centerTitle: true,
                title: appBarTitle(tr('about')),
              ),
              body: viewModel.aboutUs == ''
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 10),
                      child: SingleChildScrollView(
                          child: HtmlWidget(
                        viewModel.aboutUs,
                      )),
                    ),
            ),
          ),
        );
      },
    );
  }
}
