import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/model/feed_model.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/resources/router/route_manager.dart';
import 'package:video_player/video_player.dart';

import '../resources/image_assets.dart';
import '../resources/style_manager.dart';

class PostCard extends StatefulWidget {
  final double width;
  final FeedItem data;
  PostCard({super.key, required this.width, required this.data});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: .start,
        children: [
          //Username Header
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              children: [
                ClipOval(
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    ImgAssets.boy,
                    fit: .cover,
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        ErrorWidget("exception"),
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Text(
                          widget.data.name,
                          style: getBold16Style(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),

                        
                        Assets.checkIc.image(),
                        Assets.dimondIc.image(),
                        Text(
                          "${widget.data.hoursSince == 0 ? "Just Now" : "${widget.data.hoursSince} H"} ",
                          style: getRegular14Style(color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      widget.data.subtitle ?? "Check In",
                      style: getRegular14Style(color: Colors.black),
                    ),
                  ],
                ),

                TextButton(
                  onPressed: () {},

                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.followBtn,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.data.isAd ? "Reserve" : "Follow",
                        style: getBold14Style(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
              ],
            ),
          ),
          SizedBox(height: 10),
          //Media COntent
          Row(
            children: [
              //Media
              Stack(
                children: [
                  Container(
                    child: widget.data.imageUrls != null
                        ? Stack(
                          children: [
                            Container(
                                height: 450,
                                width: widget.width * 0.8,
                                child: ImageSlideshow(
                                  /// Width of the [ImageSlideshow].
                                  width: double.infinity,
                            
                                  /// Height of the [ImageSlideshow].
                                  //  height: 200,
                            
                                  /// The page to show when first creating the [ImageSlideshow].
                                  initialPage: 0,
                            
                                  /// The color to paint the indicator.
                                  indicatorColor: Colors.blue,
                            
                                  /// The color to paint behind th indicator.
                                  indicatorBackgroundColor: Colors.grey,
                            
                                  /// Called whenever the page in the center of the viewport changes.
                                  onPageChanged: (value) {
                                    print('Page changed: $value');
                                  },
                            
                                  /// Auto scroll interval.
                                  /// Do not auto scroll with null or 0.
                                  autoPlayInterval: 3000,
                            
                                  /// Loops back to first slide.
                                  isLoop: true,
                            
                                  /// The widgets to display in the [ImageSlideshow].
                                  /// Add the sample image file into the images folder
                                  children: [
                                    ...List.generate(
                                      widget.data.imageUrls?.length ?? 0,
                                      (index) => Image.network(
                                        widget.data.imageUrls![index],
                                        height: 450,
                                        width: widget.width * 0.8,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                ErrorWidget(error),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          Positioned(
                            left: 10,top: 230,
                                child: Assets.arrorLeft.image()
                              ),

                              Positioned(
                            right: 10,top: 230,
                                child: Assets.arrowRight.image()
                              ),
                          ],
                        )
                        : _controller.value.isInitialized
                        ? Stack(
                            alignment: .center,
                            children: [
                              Container(
                                height: 450,
                                width: widget.width * 0.8,
                                child: VideoPlayer(_controller),
                              ),

                              Positioned(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.reelPage,
                                      arguments: {
                                        "videoUrl": "${widget.data.videoUrl}",
                                      },
                                    );
                                  },
                                  icon:Assets.playIc.image(),
                                ),
                              ),

                              Positioned(
                                right: 10,
                                bottom: 30,
                                child: IconButton(
                                  onPressed: () {
                                    _controller.setVolume(100);
                                  },
                                  icon: Assets.volumeIc.image(),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ),

                    widget.data.isAd
                      ? Positioned(
                          height: 30,
                          width: widget.width * 0.8,
                          top: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.lightGreenAccent,
                            child: Row(
                              mainAxisAlignment: .center,
                              children: [
                                Text(
                                  "Add On up to 50% Extra on Food & Beverages",
                                  style: getBold14Style(color: Colors.black,fontSize: 12),
                                ),
                                
                              ],
                            ),
                          ),
                        )
                      : Container(),

                  widget.data.isAd
                      ? Positioned(
                          height: 30,
                          width: widget.width * 0.8,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.deepPurpleAccent,
                            child: Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Text(
                                  "Book Now",
                                  style: getBold14Style(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),

                       widget.data.isAd
                      ? Positioned(
                          height: 30,
                          right: 0,
                          top: 100,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                            
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft: Radius.circular(15))),
                            child: Text(
                              "Ambience",
                              style: getBold14Style(color: Colors.white),
                            ),
                          ),
                        )
                      : Container(),

                ],
              ),

              Container(
                // color: Colors.amber,
                child: Column(
                  mainAxisSize: .max,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: .min,
                      spacing: 5,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Assets.starIc.image(scale: 0.9,color: Colors.black),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Assets.bookmarkIc.image(color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 150),
                    Column(
                      mainAxisSize: .min,
                      spacing: 5,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              Assets.likeIc.image(color: Colors.black),
                              Text(
                                NumberFormat.compact().format(widget.data.likeCount),
                                style: getBold14Style(color: Colors.black),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              Assets.commentIc.image(color: Colors.black),
                              Text(
                                NumberFormat.compact().format(widget.data.commentCount),
                                style: getBold14Style(color: Colors.black),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              Assets.followerIc.image(color: Colors.black),
                              Text(
                                NumberFormat.compact().format(widget.data.followerCount),
                                style: getBold14Style(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          !widget.data.isAd?Row(
            children: [
              Text(
                widget.data.username,
                style: getBold14Style(color: Colors.black),
              ),
              SizedBox(width: 10),
              Assets.checkIc.image(),
            ],
          ):Text("The Live Edit connaught club house 25 July 2025",style: getBold14Style(color: Colors.black),textAlign: .left,),
          !widget.data.isAd?TextButton(
            onPressed: () {},
            child: Text(
              "${widget.data.caption}",
              style: getRegular10Style(color: Colors.black),
              maxLines: 3,
              softWrap: true,
            ),
          ):Text("12 Oct25, 8:00 PM – 11:30 PM",style: getRegular10Style(color: Colors.grey),),
        ],
      ),
    );
  }
}
