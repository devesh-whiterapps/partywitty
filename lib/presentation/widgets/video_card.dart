import 'package:flutter/material.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String url;
  final Function onTap;
  const VideoCard({super.key,required this.onTap,required this.url});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {

   late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     widget.url,
    //   ),
    // )..initialize().then((_) => setState(() {}));

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.url,
      ),
    );

    // FIX: Check if the widget is still mounted before calling setState()
    _controller.initialize().then((_) {
      if (mounted) { 
        setState(() {});
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return (_controller.value.isInitialized
                                ? Stack(
                                  alignment: .center,
                                  children: [
                                    VideoPlayer(_controller),
                                    //Play button
                     
                           Positioned(
                              child: InkWell(
                                onTap: () =>widget.onTap,
                                child: Assets.homePlayIc.image(),
                              ),
                            )
                          
                                  ],
                                )
                                : Container());
  }
}