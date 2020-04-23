import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../widgets/player_controls.dart';

class Watch extends StatefulWidget {
  final String videoUrl;
  Watch(this.videoUrl, {Key key}) : super(key: key);

  @override
  WatchState createState() => WatchState();
}


class WatchState extends State<Watch> {
  VideoPlayerController vcontroller;
  bool controlVisible;
  Timer timer;

  @override
  void initState() {
    controlVisible = true;

    vcontroller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        // even before the play button has been pressed.
        setState(() {});
      })
      ..setLooping(false)
      ..play();

    vcontroller.addListener(() {
      if (vcontroller.value.hasError) {
        print(vcontroller.value.errorDescription);
      }
    });

    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    autoHide();
  }

  @override
  void dispose() {
    vcontroller?.dispose();
    timer?.cancel();

    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void handlerGesture() {
    setState(() {
      controlVisible = !controlVisible;
    });
    autoHide();
  }

  void autoHide() {
    if (controlVisible) {
      timer = Timer(
          Duration(seconds: 5), () => setState(() => controlVisible = false));
    } else {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Center(
            child: vcontroller.value.initialized
                ? AspectRatio(
                    aspectRatio: vcontroller.value.aspectRatio,
                    child: VideoPlayer(vcontroller),
                  )
                : Container(),
          ),
          GestureDetector(
            child: PlayerControl(
              vcontroller,
              visible: controlVisible,
              title: widget.videoUrl,
            ),
            onTap: handlerGesture,
          ),
        ],
      ),
    );
  }
}
