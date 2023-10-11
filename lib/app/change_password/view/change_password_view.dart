import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:mohamed_mekhemar/app/change_password/view_model/change_password_view_model.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';

import '../../../base_screen.dart';
import '../../../comman_widgets/inputField.dart';
import '../../../comman_widgets/main_button.dart';
import '../../../utils/colors.dart';
import '../../../utils/spaces.dart';
import '../../../utils/texts.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePasswordViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: true,
            child: Form(
              key: viewModel.changePasswordKey,
              child: Scaffold(
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: mainColor,
                  centerTitle: true,
                  title: appBarTitle(tr('change_pass')),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ListView(
                    children: [
                      heightSpace(30),
                      InputField(
                        isPassword: true,
                        hint: tr('old_password'),
                        inputType: TextInputType.text,
                        controller: viewModel.oldPasswordController,
                        icon: Icons.person,
                        validator: viewModel.passwordValidator(),
                      ),
                      heightSpace(30),
                      InputField(
                        isPassword: true,
                        hint: tr('enter_password'),
                        inputType: TextInputType.text,
                        controller: viewModel.newPasswordController,
                        icon: Icons.person,
                        validator: viewModel.passwordValidator(),
                      ),
                      heightSpace(30),
                      InputField(
                        isPassword: true,
                        hint: tr('enter_confirm_password'),
                        inputType: TextInputType.text,
                        controller: viewModel.confirmPasswordController,
                        icon: Icons.person,
                        validator: viewModel.confirmPasswordValidator(),
                      ),
                      heightSpace(60),
                      // mainButton(tr('edit')).onTap(() {
                      //   viewModel.changePassword(
                      //     context,
                      //   );
                      // }),
                      RoundedLoadingButton(
                        width: MediaQuery.of(context).size.width,
                        color: mainColor,
                        successColor: successfulColor,
                        errorColor: errorColor,
                        height: 50,
                        controller: viewModel.btnController,
                        onPressed: () {
                          viewModel.changePassword(
                            context,
                          );
                        },
                        child: roundedButtonText(
                          tr('change_pass'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
