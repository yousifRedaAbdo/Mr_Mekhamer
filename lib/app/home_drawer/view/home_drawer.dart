import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/teacher_profile/view/teacher_profile_view.dart';
import 'package:mohamed_mekhemar/enums/screen_state.dart';
import 'package:mohamed_mekhemar/routs/routs_names.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';

import '../../../base_screen.dart';
import '../../../comman_widgets/drawer_card.dart';
import '../../../utils/texts.dart';
import '../../profile_page/view/student_profile_page_view.dart';
import '../view_model/home_drawer_view_model.dart';

class HomeDrawerView extends StatelessWidget {
  const HomeDrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeDrawerViewModel>(
      onModelReady: (viewModel) {
        viewModel.getHomeDrawerData();
      },
      builder: (context, viewModel, child) {
        var deviceSize = MediaQuery.of(context).size;

        return viewModel.state == ViewState.Busy
            ? const Center(
                child: CircularProgressIndicator(
                  color: whiteColor,
                ),
              )
            : Drawer(
                backgroundColor: mainColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        heightSpace(25),
                        Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: viewModel.userImage,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: whiteColor,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            widthSpace(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                mediumText(
                                  viewModel.firstName,
                                  color: whiteColor,
                                ),
                                heightSpace(5),
                                SizedBox(
                                  width: 150,
                                  child: smallText(
                                    viewModel.email,
                                    color: whiteColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ).onTap(() {
                          viewModel.role == 'teacher'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TeacherProfileView(),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const StudentProfileView(),
                                  ),
                                );
                        }),
                        heightSpace(25),
                        drawerCard(
                          text: tr('edit_profile'),
                        ).onTap(() {
                          viewModel.navigation.navigateTo(
                            RouteName.editProfileView,
                          );
                        }),
                        heightSpace(10),
                        drawerCard(
                          text: tr('change_pass'),
                        ).onTap(() {
                          viewModel.navigation
                              .navigateTo(RouteName.changePasswordView);
                        }),
                        heightSpace(10),
                        drawerCard(
                          text: tr('contact'),
                        ).onTap(() {
                          viewModel.navigation
                              .navigateTo(RouteName.contactUsView);
                        }),
                        heightSpace(10),
                        drawerCard(
                          text: tr('about'),
                        ).onTap(() {
                          viewModel.navigation
                              .navigateTo(RouteName.aboutUsView);
                        }),
                        heightSpace(deviceSize.height < 700
                            ? deviceSize.height * (25 / 100)
                            : deviceSize.height * (35 / 100)),
                        Card(
                          child: Container(
                            height: 55,
                            color: mainColorWithOpacity,
                            width: double.infinity,
                            child: Center(
                              child: title(tr('log_out'), color: whiteColor),
                            ),
                          ).onTap(() {
                            viewModel.logOut();
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
