import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wee_made/layouts/provider_layout/provider_layout.dart';
import 'package:wee_made/layouts/user_layout/user_layout.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/shared/images/images.dart';
import 'modules/intro/intro_screen.dart';
import 'modules/intro/join_us_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.asset(Images.splashLogo)
      ..initialize().then((_) {
        setState(() {
          if (_controller.value.isInitialized) {
            _controller.play();
          }
        });
      });
    _controller.play();
    _controller.addListener(() {
      setState(() {
        if (!_controller.value.isPlaying) {
          if (intro != null) {
            if(token!=null){
              if(userType == 'user'){
                navigateAndFinish(context, UserLayout());
              }else{
              navigateAndFinish(context, ProviderLayout());
              }
            }
          } else {
            navigateAndFinish(context, IntroScreen());
          }
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller)
        ),
      ),
    );
  }
}