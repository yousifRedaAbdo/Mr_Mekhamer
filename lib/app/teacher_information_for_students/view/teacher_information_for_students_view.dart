import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mohamed_mekhemar/app/teacher_information_for_students/view/add_feedback_view.dart';
import 'package:mohamed_mekhemar/app/teacher_information_for_students/view_model/teacher_information_for_students_view_model.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

class TeacherInformationForStudentsView extends StatefulWidget {
  String courseId;

  TeacherInformationForStudentsView(this.courseId);

  @override
  State<TeacherInformationForStudentsView> createState() =>
      _TeacherInformationForStudentsViewState();
}

class _TeacherInformationForStudentsViewState
    extends State<TeacherInformationForStudentsView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<TeacherInformationForStudentsViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        await viewModel.getToken();
        if (!mounted) return;
        await viewModel.getTeacherData(context, viewModel.token);
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
                centerTitle: true,
                elevation: 0,
                backgroundColor: mainColor,
                title: appBarTitle(
                  tr('mr_name'),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    heightSpace(20),
                    Stack(
                      children: [
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: CircleAvatar(
                              backgroundColor: backgroundColor,
                              radius: 70,
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/icon.jpg',
                                  width: 135,
                                  height: 135,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    heightSpace(10),
                    title(tr('mr_name')),
                    heightSpace(20),
                    RatingBar.builder(
                      initialRating: viewModel.rate,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {
                        viewModel.addRating(
                          token: viewModel.token,
                          rating: value.toString(),
                        );
                      },
                    ),
                    heightSpace(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            viewModel.launchWhatsApp(teacherContactNumber);
                          },
                          icon: Image.asset(
                            'assets/images/whats_app.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        widthSpace(10),
                        IconButton(
                          onPressed: () {
                            viewModel.launchTeacherUrl(
                                Uri.parse(teacherFaceBookLink));
                          },
                          icon: Image.asset(
                            'assets/images/fb.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        widthSpace(10),
                        IconButton(
                          onPressed: () {
                            viewModel.launchTeacherUrl(
                                Uri.parse(teacherYoutubeLink));
                          },
                          icon: Image.asset(
                            'assets/images/youtube.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        widthSpace(10),
                        IconButton(
                          onPressed: () {
                            viewModel.launchTeacherUrl(
                                Uri.parse(teacherInstagramLink));
                          },
                          icon: Image.asset(
                            'assets/images/instagram.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                        widthSpace(10),
                        IconButton(
                          onPressed: () {

                            viewModel.launchTelegram();
                          },
                          icon: Image.asset(
                            'assets/images/telegram.png',
                            height: 120,
                            width: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    viewModel.bio == ''
                        ? Container()
                        : Column(
                            children: [
                              Row(),
                              heightSpace(20),
                              titleWidget(tr('bio')),
                              heightSpace(20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: mediumText(viewModel.bio),
                              )
                            ],
                          ),
                    heightSpace(20),
                    titleWidget(tr('courses')),
                    viewModel.dataState == false
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                          )
                        : SizedBox(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: viewModel.coursesList.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SizedBox(
                                      width: 250,
                                      child: Card(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              '${e.overviewfiles[0].fileurl}?token=${viewModel.token}',
                                              height: 180,
                                              // width: 240,
                                              fit: BoxFit.fill,
                                            ),
                                            heightSpace(10),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  title(e.fullname),
                                                  heightSpace(10),
                                                  mediumText(
                                                    tr('mr_name'),
                                                    color: mainColor,
                                                  ),
                                                  heightSpace(10),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                    heightSpace(20),
                    titleWidget(tr('photos')),
                    viewModel.dataState == false
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                          )
                        : viewModel.photosList.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: mediumText(
                                    tr('no_data'),
                                  ),
                                ),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height * 0.30,
                                  enableInfiniteScroll: false,
                                  aspectRatio: 16 / 9,
                                  initialPage: 0,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                ),
                                items: viewModel.photosList.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 8.0),
                                        child: Image.network(
                                          i.photos,
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                    heightSpace(10),
                    titleWidget(tr('feedback')),
                    viewModel.dataState == false
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(
                                color: mainColor,
                              ),
                            ),
                          )
                        : viewModel.feedbacksList.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: mediumText(
                                    tr('no_data'),
                                  ),
                                ),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  height:
                                      MediaQuery.of(context).size.height * 0.10,
                                  enableInfiniteScroll: false,
                                  aspectRatio: 16 / 9,
                                  initialPage: 0,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 5),
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 1000),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                ),
                                items: viewModel.feedbacksList.map(
                                  (i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: mediumText(
                                            i.feedback,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddRateView(widget.courseId),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                      ),
                      child: mediumText(
                        tr('add_feed_back'),
                        color: whiteColor,
                      ),
                    ),
                    heightSpace(25)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget titleWidget(String text) {
  return Container(
    width: double.infinity,
    color: mainColor,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    child: mediumText(text, color: whiteColor),
  );
}
