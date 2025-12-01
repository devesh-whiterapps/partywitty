import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:partywitty/core/global_state.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';

class VideoReel extends StatefulWidget {

  const VideoReel({super.key,});

  @override
  State<VideoReel> createState() => _VideoReelState();
}

class _VideoReelState extends State<VideoReel> {
   CachedVideoPlayerPlus? _player;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     widget.url,
    //   ),
    // )..initialize().then((_) => setState(() {}));
WidgetsBinding.instance.addPostFrameCallback((_) {
    _player = CachedVideoPlayerPlus.networkUrl(
      Uri.parse(GlobalState.instance.videoUrl),
      invalidateCacheIfOlderThan: const Duration(minutes: 69), // Nice!
    );
      if(mounted)
      {
    _player!.initialize().then((_){setState(() {
      
    });});

      }
  });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_player == null || !_player!.isInitialized) {
      // Show a loading indicator or an empty container while initializing
      return Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(), 
      );
    }
    return (
      
       Stack(
            alignment: .center,
            children: [
              VideoPlayer(_player!.controller),

              //Play button
              // Positioned(
              //   child: InkWell(
              //     onTap: () => widget.onTap,
              //     child: Assets.homePlayIc.image(),
              //   ),
              // ),
            ],
          )
        
        );
  }
}


