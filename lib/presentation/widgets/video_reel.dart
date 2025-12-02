import 'dart:async';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:partywitty/core/global_state.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/screens/reel/view.dart';
import 'package:video_player/video_player.dart';

class VideoReel extends StatefulWidget {
  const VideoReel({super.key});

  @override
  State<VideoReel> createState() => _VideoReelState();
}

class _VideoReelState extends State<VideoReel> {
  CachedVideoPlayerPlus? _player;
  late VideoPlayerController _controller;

  @override
  void initState() {
    print("1245 ${GlobalState.instance.videoUrl}");
    runZoned((){
       _controller = VideoPlayerController.networkUrl(
      Uri.parse(GlobalState.instance.videoUrl),
    );
    
    // if (mounted) {
      _controller.initialize().then((_) {
        setState(() {});
       
      });
      // _player!.initialize().then((_) {
      //   setState(() {});
      // });
    // }
    });
     
     super.initState();

  

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _player = CachedVideoPlayerPlus.networkUrl(
    //       Uri.parse(GlobalState.instance.videoUrl),
    //       skipCache: true,
    //       invalidateCacheIfOlderThan: const Duration(minutes: 69), // Nice!
    //     );
    //       if(mounted)
    //       {
    //     _player!.initialize().then((_){setState(() {

    //     });});

    //       }
    //   });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      // Show a loading indicator or an empty container while initializing
      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      );
    }

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
        children: [_controller.value.isInitialized?
          VideoPlayer(_controller):Center(child: CircularProgressIndicator(),),

          //Play button
          !_controller.value.isPlaying
              ? Positioned(
                  child: InkWell(
                    onTap: () => setState(() {
                      _controller!.play();
                    }),
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
  }
}
