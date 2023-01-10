import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

import '../../database/app_user/auth_method.dart';
import '../auth/welcome_screen.dart';
import '../main_screen/main_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  final asset = 'assets/video/boloodo.mp4';
  VideoPlayerController? videoPlayerController;
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.asset(asset)
      ..addListener(() {
        setState(() {
          
          if (videoPlayerController != null &&
              (videoPlayerController!.value.duration ==
                  videoPlayerController!.value.position)) {
            //checking the duration and position every time
             Navigator.push(
        context,
        // ignore: always_specify_types
        MaterialPageRoute(
          builder: (BuildContext context) => (AuthMethods.uid.isEmpty)
              ? const WelcomeScreen()
              : const MainScreen(),
        ),
      );
          }
        });
      })
      //..setLooping(true)
      ..setVolume(0)
      ..initialize().then((value) => videoPlayerController!.play());
  }

  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController != null
        ? AspectRatio(
            aspectRatio: videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(videoPlayerController!))
        : CircularProgressIndicator();
  }
}
