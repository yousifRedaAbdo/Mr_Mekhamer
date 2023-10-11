import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_mekhemar/app/contact_us/view/contact_us_view.dart';
import 'package:mohamed_mekhemar/app/home_vistore/cubit_vistore.dart';
import 'package:mohamed_mekhemar/app/home_vistore/states_vistore.dart';
import 'package:mohamed_mekhemar/app/home_vistore/vistore_model.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize().catchError((error) {
      print('Failed to initialize video player: $error');
    });
    _controller.addListener(() {
      if (_controller.value.hasError) {
        print(
            'Video player encountered an error: ${_controller.value.errorDescription}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: FlickVideoPlayer(
              flickManager: FlickManager(
                videoPlayerController: _controller,
                autoPlay: false,
              ),
              flickVideoWithControls: FlickVideoWithControls(
                controls: FlickPortraitControls(),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class VideoCarousel extends StatelessWidget {
  VistorModel? model;

  VideoCarousel({required this.model});

  static final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => VistorCubit(),
      child: BlocConsumer<VistorCubit, VistorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 300.0,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: model?.data?.map((videoUrl) {
              return VideoPlayerWidget(videoUrl: "${videoUrl.videourl}");
            }).toList(),
          );
        },
      ),
    );
  }
}

class VideoCarouselScreennn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => VistorCubit()..getVistoreData(),
      child: BlocConsumer<VistorCubit, VistorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: VistorCubit.get(context).vistorModel != null,
              builder: (context) => Scaffold(
                    appBar: AppBar(
                      backgroundColor: mainColor,
                      title: Center(child: Text(tr('visitors'))),
                    ),
                    body: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            child: VideoCarousel(
                                model: VistorCubit.get(context).vistorModel),
                          ),
                        ),
                        if (VistorCubit.get(context).vistorModel!.data!.length >
                            1)
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios),
                                  onPressed: () {
                                    VideoCarousel._controller.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear,
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () {
                                    VideoCarousel._controller.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.linear,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: contactWithUs(
                            context: context,
                            teacherNumber: teacherContactNumber,
                            techNumber: tecContactNumber,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
              fallback: (context) => Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator())));
        },
      ),
    );
  }
}
