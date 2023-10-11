import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/MyApplication.dart';
import 'package:mohamed_mekhemar/app/home_vistore/vistor_screen.dart';
import 'package:mohamed_mekhemar/routs/routs_names.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../base_screen.dart';
import '../../../comman_widgets/inputField.dart';
import '../../../comman_widgets/main_button.dart';
import '../../../utils/colors.dart';
import '../../../utils/strings.dart';
import '../../contact_us/view/contact_us_view.dart';
import '../view_model/auth_view_model.dart';


class LogInView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BaseView<AuthenticationViewModel>(
      onModelReady: (viewModel) {
        viewModel.checkSignUp();
      },
      builder: (context, viewModel, child) {
        var deviceSize = MediaQuery.of(context).size;
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: true,
            child: Form(
              key: viewModel.logInFormKey,
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          heightSpace(50),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: backgroundColor,
                              radius: 70,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/icon.jpg',
                                  width: 135,
                                  height: 135,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          heightSpace(20),
                          Center(child: mainColorTitle(tr('mr_name'))),
                          heightSpace(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(tr('email'),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                          heightSpace(10),
                          InputField(
                            inputType: TextInputType.emailAddress,
                            controller: viewModel.email,
                            validator: viewModel.emailValidator(),
                            icon: Icons.email,
                            hint: tr('email'),
                          ),
                          heightSpace(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(tr('password'),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          ),
                          heightSpace(10),
                          InputField(
                            inputType: TextInputType.text,
                            controller: viewModel.password,
                            icon: Icons.lock,
                            validator: viewModel.passwordValidator(),
                            isPassword: true,
                            hint: tr('password'),
                          ),
                          heightSpace(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              smallBoldTitle(
                                tr('forget_password'),
                              )
                            ],
                          ).onTap(() {
                            viewModel.navigation
                                .navigateTo(RouteName.resetPassword);
                          }),
                          heightSpace(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.qr_code,
                                size: 30,
                                color: Colors.red.shade900,
                              )
                            ],
                          ).onTap(() {
                            viewModel.navigation.navigateTo(RouteName.qrCode);
                          }),
                          heightSpace(25),
                          RoundedLoadingButton(
                            width: deviceSize.width,
                            color: mainColor,
                            successColor: successfulColor,
                            errorColor: errorColor,
                            height: 50,
                            controller: viewModel.btnController,
                            onPressed: () {
                              viewModel.login(context);
                            },
                            child: roundedButtonText(
                              tr('log_in'),
                            ),
                          ),
                          heightSpace(20),
                          InkWell(
                            onTap: (){
                              myApplication().navigateTo(VideoCarouselScreennn(), context);
                            },
                            child: Container(
                              width: deviceSize.width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(30)
                              ),

                              child: Center(
                                child: roundedButtonText(
                                  tr('Login_as_a_visitor'),
                                ),
                              ),
                            ),
                          ),
                          heightSpace(20),

                          ///register button
                          viewModel.signUpState == true
                              ? mainButton(tr('register')).onTap(() {
                                  viewModel.navigation
                                      .navigateTo(RouteName.signUp);
                                })
                              : contactWithUs(
                                  context: context,
                                  teacherNumber: teacherContactNumber,
                                  techNumber: tecContactNumber,
                                ),

                          viewModel.signUpState == true
                              ? heightSpace(100)
                              : heightSpace(50),
                          smallText('All rights reserved to N.I.T © 2022_2023'),
                          heightSpace(10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      onFinish: (viewModel) {
        viewModel.email.dispose();
        viewModel.password.dispose();
      },
    );
  }
}
