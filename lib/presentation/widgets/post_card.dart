import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
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
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    )..initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE9EBDC).withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.data.usershared
              ? Row(
            children: [
              ClipOval(
                child: Image.network(
                  ImgAssets.boy,
                  fit: BoxFit.cover,
                  width: 25,
                  height: 25,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "User Name",
                style: GoogleFonts.lexend(
                    fontSize: 14,
                    color: Colors.black
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "shared this",
               style: GoogleFonts.lexend(
                 fontSize: 12,
                 color: Colors.black
               ),
              ),
            ],
          )
              : Container(),
          widget.data.usershared
              ? Divider(color: Colors.grey.withOpacity(0.4))
              : Container(),
          const SizedBox(height: 10),

          // Username Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: Image.network(
                  ImgAssets.boy,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
                ),
              ),
              const SizedBox(width: 5),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.data.name,
                            style: getBold16Style(
                                color: Colors.black, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Assets.checkIc.image(),
                        Assets.dimondIc.image(),
                        const SizedBox(width: 5),
                        Text(
                          widget.data.hoursSince == 0
                              ? "Just Now"
                              : "${widget.data.hoursSince} H",
                          style: getRegular14Style(color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(
                      widget.data.subtitle ?? "Check in",
                      style: GoogleFonts.lexend(
                        color: Colors.black
                      )
                    ),
                  ],
                ),
              ),

              TextButton(
                onPressed: () {},
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.followBtn,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.data.isAd ? "Reserve" : "Follow",
                      style: GoogleFonts.lexend(
                        fontSize: 10,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),

              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),

          const SizedBox(height: 10),

          // Media Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: SizedBox(
                  width: widget.width * 0.78,
                  height: 450,
                  child: Stack(
                    children: [
                      widget.data.imageUrls != null
                          ? ImageSlideshow(
                        width: double.infinity,
                        height: 450,
                        initialPage: 0,
                        indicatorColor: Colors.blue,
                        indicatorBackgroundColor: Colors.grey,
                        autoPlayInterval: 3000,
                        isLoop: true,
                        children: widget.data.imageUrls!.map(
                              (url) => Image.network(
                            url,
                            width: double.infinity,
                            height: 450,
                            fit: BoxFit.cover,
                          ),
                        ).toList(),
                      )
                          : (_controller.value.isInitialized
                          ? VideoPlayer(_controller)
                          : Container()),

                      // arrows
                      Positioned(left: 10, top: 220, child: Assets.arrorLeft.image()),
                      Positioned(right: 10, top: 220, child: Assets.arrowRight.image()),

                      // Ad overlays
                      if (widget.data.isAd)
                        Positioned(
                          top: 0,
                          width: widget.width * 0.78,
                          height: 30,
                          child: Container(
                            color: ColorManager.offerColor,
                            alignment: Alignment.center,
                            child: Text(
                              "Add On up to 50% Extra on Food & Beverages",
                              style: getBold14Style(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ),

                      if (widget.data.isAd)
                        Positioned(
                          bottom: 0,
                          width: widget.width * 0.90,
                          height: 30,
                          child: Container(
                            color: Colors.deepPurpleAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Book Now",
                                  style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    color: Colors.white
                                  ),

                                ),
                                const Icon(Icons.arrow_forward_ios,
                                    size: 20, color: Colors.white),
                              ],
                            ),
                          ),
                        ),

                      if (widget.data.isAd)
                        Positioned(
                          right: 0,
                          top: 100,
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: ColorManager.tagColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: Text("Ambience",
                            style: GoogleFonts.lexend(
                              fontSize: 16,
                              color: Colors.white
                            ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 3),


              SizedBox(
                width: 55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top two buttons
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Assets.starIc.image(color: Colors.black),
                        ),
                        const SizedBox(height: 5), // explicit gap
                        IconButton(
                          onPressed: () {},
                          icon: Assets.bookmarkIc.image(color: Colors.black),
                        ),
                      ],
                    ),

                    const SizedBox(height: 158),

                    Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              Assets.likeIc.image(color: Colors.black),
                              Text(
                                NumberFormat.compact()
                                    .format(widget.data.likeCount),
                                style: getBold14Style(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10), // explicit gap
                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              Assets.commentIc.image(color: Colors.black),
                              Text(
                                NumberFormat.compact()
                                    .format(widget.data.commentCount),
                                style: getBold14Style(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10), // explicit gap
                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              Assets.followerIc.image(color: Colors.black),
                              Text(
                                NumberFormat.compact()
                                    .format(widget.data.followerCount),
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

          const SizedBox(height: 8),

          // Caption
          !widget.data.isAd
              ? Row(
            children: [
              Text(
                widget.data.username,
                style: getBold14Style(color: Colors.black),
              ),
              const SizedBox(width: 10),
              Assets.checkIc.image(),
            ],
          )
              : Text(
            "The Live Edit connaught club house 25 July 2025",
            style: GoogleFonts.lexend(
              fontSize: 12,
              color: Colors.black
            ),
          ),

          !widget.data.isAd
              ? Text(
            "${widget.data.caption}",
            style: getRegular10Style(color: Colors.black),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
              : Text(
            "12 Oct25, 8:00 PM – 11:30 PM",
            style: GoogleFonts.lexend(
              color: Color(0xFF4F4F4F)
            ),
          ),
        ],
      ),
    );
  }
}
