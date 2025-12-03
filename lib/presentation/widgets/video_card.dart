import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:partywitty/gen/assets.gen.dart';

class VideoCard extends StatefulWidget {
  final String url;
  final VoidCallback onTap;
  const VideoCard({super.key, required this.onTap, required this.url});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();

       player.open(Media(widget.url??''));

  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (_player == null || !_player!.isInitialized) {
    //   // Show a loading indicator or an empty container while initializing
    //   return Container(
    //     alignment: Alignment.center,
    //     child: const CircularProgressIndicator(), 
    //   );
    // }
    return (
      
       Stack(
            alignment: .center,
            children: [
              Video(controller: controller..player.pause(),fit: .fill,),

              //Play button
              Positioned(
                child: InkWell(
                  onTap: () => widget.onTap(),
                  child: Assets.homePlayIc.image(),
                ),
              ),
            ],
          )
        
        );
  }
}


