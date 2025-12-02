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
    VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
       GlobalState.instance.videoUrl,
      ),
    )..initialize().then((_) {
      if(mounted)
      {
    _player!.initialize().then((_){setState(() {
      
    });});

      }
    });

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
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null ) {
      // Show a loading indicator or an empty container while initializing
      return Scaffold(body:  Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(), 
      ),);
      
    }

    final Map<String, dynamic> args = 
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      
  final String title = args['title'] ;
  final String subTitle = args['subTitle'] ;
  final String leadImg = args['leadImg'] ;
  final String since = args['since'] ;
  final int disc = args['disc'];
  final int itemId = args['id'];
    return Scaffold(
      body: 
       Stack(
            alignment: .center,
            children: [
              VideoPlayer(_controller!),

              //Play button
              Positioned(
                child: InkWell(
                  onTap: () => setState(() {
                    _controller!.play();
                  }),
                  child: Assets.homePlayIc.image(),
                ),
              ),
          Positioned.fill(child: ReelPage(title: title, subTitle: subTitle, since: since, disc: disc, clubLogo: leadImg, id: itemId,width: MediaQuery.of(context).size.width,))


            ],
          )
        
        );
  }
}


