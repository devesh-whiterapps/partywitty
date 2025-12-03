import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:partywitty/core/global_state.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/screens/reel/view.dart';

class VideoReel extends StatefulWidget {
  // VideoPlayerController controller;
   VideoReel({super.key});

  @override
  State<VideoReel> createState() => _VideoReelState();
}

class _VideoReelState extends State<VideoReel> {
  // late CachedVideoPlayerPlus _player;
  // late VideoPlayerController _controller;

   // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    print("1245 ${GlobalState.instance.videoUrl}");

     
     super.initState();

  
    player.open(Media(GlobalState.instance.videoUrl));

    // controller.player.pause();
    controller.player.platform?.isVideoControllerAttached = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    // widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
try{
    // 1. Get arguments safely, checking for null
    final args1 = ModalRoute.of(context)?.settings.arguments;

    // 2. Safely cast to the expected type (Map<String, dynamic> or null)
    final Map<String, dynamic>? args = args1 is Map<String, dynamic>
        ? args1
        : null;

    final String title = args?['title'];
    final String subTitle = args?['subTitle'];
    final String leadImg = args?['leadImg'];
    final String since = args?['since'];
    final int disc = args?['disc'];
    final int itemId = args?['id'];

    return Scaffold(
      body: Stack(
        alignment: .center,
        children: [
          
          Video(controller: controller..player.setAudioDevice(AudioDevice.auto())..player.pause(),fit: .fill,),

          //Play button
          !controller.player.state.playing? Positioned(
                  child: InkWell(
                    onTap: () {
                      controller.player.play();
                    },
                    child: Assets.homePlayIc.image(),
                  ),
                )
              : Container(),
          Positioned.fill(
            child: ReelPage(
              title: title,
              subTitle: subTitle,
              since: since,
              disc: disc,
              clubLogo: leadImg,
              id: itemId,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );

} catch(e){
return Text(e.toString());
}
  }
}
