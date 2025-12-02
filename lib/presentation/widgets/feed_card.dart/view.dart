import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partywitty/core/global_state.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/resources/image_assets.dart';
import 'package:partywitty/presentation/resources/router/route_manager.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';
import 'package:partywitty/presentation/widgets/multi_img_card.dart';
import 'package:partywitty/presentation/widgets/side_bar.dart';
import 'package:partywitty/presentation/widgets/single_image_section.dart';
import 'package:partywitty/presentation/widgets/top_section_card.dart';
import 'package:partywitty/presentation/widgets/video_card.dart';

import '../../../gen/assets.gen.dart';
import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class FeedCardPage extends StatelessWidget {
  final HomeItemModel item;
  final double width;
    final double height;


  const FeedCardPage({super.key, required this.item, required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCardBloc(item: item)..add(FeedCardInitEvent()),
      child: BlocConsumer<FeedCardBloc, FeedCardState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case FeedCardStatus.initial:
              return Center(child: CircularProgressIndicator());
            case FeedCardStatus.loading:
              return SizedBox(
                height: height,width: width,
                child: Center(child: CircularProgressIndicator()));
            case FeedCardStatus.loaded:
              return FeedCardLoadedPage(state: state, width: width,height: height,);
            case FeedCardStatus.error:
              return Scaffold(
                body: Center(child: Text(state.error ?? "An error occurred")),
              );
            }
        },
      ),
    );
  }
}

class FeedCardLoadedPage extends StatelessWidget {
  FeedCardState state;
  final double width;
  final double height;

  FeedCardLoadedPage({super.key, required this.state, required this.width,required this.height});

  @override
  Widget build(BuildContext context) {
    if (state.type == 'package') {
      return Blur(
        blurColor: ColorManager.cardBackground,
        blur:75.91,
        overlay: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(width: 0.76, color: ColorManager.reel_back),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Party Packages',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'View all',
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(Assets.arrowRight2IcSvg)
                          // Assets.arrowRight2Ic.image(),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 6),
        
                SizedBox(
                  height: height,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Container(
                          width: 185,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            image: DecorationImage(
                              image: NetworkImage(
                                state.packageItem![index].img ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 185,
                            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(127)
                            ),
                            child: Column(
                              crossAxisAlignment: .center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${state.packageItem![index].name}',
                                  style: getRegular14Style(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  (state.packageItem![index].totalPackages ?? 0) >
                                          199
                                      ? '(199+)'
                                      : '0',
                                  style: getRegular14Style(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        child: Container(
          foregroundDecoration: BoxDecoration(
            color: Colors.transparent,
            // border: Border.all(width: 0.76, color: ColorManager.reel_back),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Party Packages',
                      style: GoogleFonts.lexend(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'View all',
                            style: GoogleFonts.lexend(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(Assets.arrowRight2IcSvg),
                          // Assets.arrowRight2Ic.image(),
                        ],
                      ),
                    ),
                  ],
                ),
        
                const SizedBox(height: 6),
        
                SizedBox(
                  height: 256,width: width,
                  child: Container()
                ),
              ],
            ),
          ),
        ),
      );
    }


    //Event Teaser Gallery Card
    return Blur(
      blurColor: ColorManager.cardBackground,
      blur: 75.91,
      overlay: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 0.76, color: ColorManager.reel_back),
        ),
        // color: Color(0xFFE9EBDC).withOpacity(0.5),
        // margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
      
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Username shared
            Row(
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
                  style: GoogleFonts.lexend(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(width: 10),
                Text(
                  "shared this",
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
      
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(color: ColorManager.dividerColor, thickness: 0.39),
            ),
      
            const SizedBox(height: 10),
            
            // Top Section Of Card
            switch (state.type!) {
              'event' => TopSectionCard(
                isFollow: false,
                leadingImg: "${state.eventItem?.clubLogo}",
                onFollow: () {},
                onMenu: () {},
                since: "${state.eventItem?.eventTime}",
                subTitle:
                    "${state.eventItem?.areaName},${state.eventItem?.cityName}",
                title: "${state.eventItem?.clubName}",
              ),
      
              //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);
              'gallery' => TopSectionCard(
                hideFollow: true,
                hideSince: true,
                isFollow: true,
                leadingImg: "${state.galleryItem?.clubLogo}",
                onFollow: () {},
                onMenu: () {},
                since: "${state.galleryItem?.clubId}",
                subTitle: "${state.galleryItem?.meta?.address}",
                title: "${state.galleryItem?.clubName}",
              ),
      
              'teaser' => TopSectionCard(
                hideFollow: true,
                isFollow: true,
                leadingImg: "${state.teaserItem?.clubLogo}",
                onFollow: () {},
                onMenu: () {},
                since: "${state.teaserItem?.clubId}",
                subTitle:
                    "${state.teaserItem?.areaName}${state.teaserItem?.cityName}",
                title: "${state.teaserItem?.clubName}",
              ),
      
              // TODO: Handle this case.
              String() => throw UnimplementedError(),
            },
      
            const SizedBox(height: 10),
      
            // Media Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.82,
                  height: height,
                  child: switch (state.type!) {
                    'event' => Column(
                      children: [
                         state.eventItem?.discount != null &&
                                int.parse(state.eventItem?.discount ?? '0') > 0
                            ? Container(
                              color: ColorManager.offerColor,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                "Add On up to ${state.eventItem?.discount}% Extra on Food & Beverages",
                                style: getBold14Style(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            )
                            : Container(),

                        Expanded(
                          child: SingleImageSection(
                            fit: .fill,
                            imageUrl: "${state.eventItem?.image}",
                            onTap: () {Navigator.of(context).pushNamed(Routes.singleImgPage,arguments: {
'image': "${state.eventItem?.image}",
    'id': 123,
                            });},
                          ),
                        ),
      
                       
                        Container(
                          color: ColorManager.followBtn,
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Book Now",
                                style: GoogleFonts.lexend(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                              SvgPicture.asset(Assets.arrowRightIcSvg),
                             
                            ],
                          ),
                        ),
                      ],
                    ),
      
                    //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);
                    'gallery' => SizedBox(
                      height: height,
                      width: width*0.82,
                      child: Stack(
                        children: [
                          MultiImgCard(
                            imgList: state.galleryItem!.images!
                                .map((data) => data.img ?? '')
                                .toList(),
                            onTap: () {
                              Navigator.of(context).pushNamed( Routes.multiImgPage,arguments: {
    'images': List.generate(state.galleryItem?.images?.length??0, (index){
      return state.galleryItem!.images![index].img;
    }),
    'id': 123,
  },);
                            },
                          ),
                            
                          //  state.eventItem?.discount !=null && int.parse(state.eventItem?.discount??'0') > 0? Positioned(
                          //     top: 0,
                          //     width: width * 0.83,
                          //     height: 30,
                          //     child: Container(
                          //       color: ColorManager.offerColor,
                          //       alignment: Alignment.center,
                          //       child: Text(
                          //         "Add On up to ${state.eventItem?.discount}% Extra on Food & Beverages",
                          //         style: getBold14Style(
                          //           color: Colors.black,
                          //           fontSize: 12,
                          //         ),
                          //       ),
                          //     ),
                          //   ):Container(),
                          Positioned(
                            bottom: 0,
                            width: width * 0.82,
                            height: 30,
                            child: Container(
                              color: ColorManager.followBtn,
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Book Now",
                                    style: GoogleFonts.lexend(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SvgPicture.asset(Assets.arrowRightIcSvg,height: 30,width: 40,)
                                  // Assets.arrowRightIc.image(scale: 0.9),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
      
                    'teaser' => Stack(
                      children: [
                        VideoCard(
                          onTap: () {
                            GlobalState.instance.videoUrl = state.teaserItem?.video??'';
                            Navigator.of(context).pushNamed(Routes.videoPage);
                          },
                          url: "${state.teaserItem?.video}",
                        ),
      
                        Positioned(
                          right: 0,
                          top: 100,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: ColorManager.tagColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            child: Text(
                              "${state.teaserItem?.category}",
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
      
                    // TODO: Handle this case.
                    String() => throw UnimplementedError(),
                  },
                ),
      
                // const SizedBox(width: 3),
      
                //SideBar Buttons
                SizedBox(
                  height: height,
                  child: switch (state.type!) {
                    'event' => SideBar(
                      commentCount: 0,
                      followCount: 0,
                      likeCount: (state.eventItem?.totalLikes ?? 0).toDouble(),
                      onBookmark: () {},
                      onComment: () {},
                      onFollow: () {},
                      onLike: () {},
                      onStar: () {},
                    ),
                        
                    //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);
                    'gallery' => SideBar(
                      commentCount: 0,
                      followCount: 0,
                      likeCount: 0,
                      onBookmark: () {},
                      onComment: () {},
                      onFollow: () {},
                      onLike: () {},
                      onStar: () {},
                    ),
                    'teaser' => SideBar(
                      commentCount: 0,
                      followCount: 0,
                      likeCount: (state.teaserItem?.totalLikes ?? 0).toDouble(),
                      onBookmark: () {},
                      onComment: () {},
                      onFollow: () {},
                      onLike: () {},
                      onStar: () {},
                    ),
                        
                    // TODO: Handle this case.
                    String() => throw UnimplementedError(),
                  },
                ),
                // SideBar(commentCount: 0, followCount: 0, likeCount: state.eventItem?.totalLikes as double, onBookmark: (){}, onComment: (){}, onFollow: (){}, onLike: (){}, onStar: (){})
              ],
            ),
      
            const SizedBox(height: 8),
            //Caption Text
            switch (state.type!) {
              'event' => Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "${state.eventItem?.name}",
                    style: getBold14Style(color: Colors.black),
                    textAlign: .left,
                  ),
                  Text(
                    "${state.eventItem?.eventDate},${state.eventItem?.eventTime} - ${state.eventItem?.eventEndTime}",
                    style: getRegular14Style(color: Colors.black),
                    textAlign: .left,
                  ),
                ],
              ),
      
              //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);
              'gallery' => Container(),
              'teaser' => Container(),
      
              // TODO: Handle this case.
              String() => throw UnimplementedError(),
            },
      
            // Caption
            //  !widget.data.isAd
            //       ?CaptionText(data: widget.data)
            //       : Column(
            //         crossAxisAlignment: .start,
            //         children: [
            //           Text(
            //               "The Live Edit connaught club house 25 July 2025",
            //               style: getBold14Style(color: Colors.black),
            //               textAlign: .left,
            //             ),
            //              Text(
            //               "12 Oct25, 8:00 PM – 11:30 PM",
            //               style: getRegular14Style(color: Colors.black),
            //               textAlign: .left,
            //             ),
            //         ],
            //       ),
          ],
        ),
   
      ),
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: Colors.transparent
        ),
        // decoration: BoxDecoration(
         
        //   border: Border.all(width: 0.76, color: ColorManager.reel_back),
        // ),
        // color: Color(0xFFE9EBDC).withOpacity(0.5),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                  style: GoogleFonts.lexend(fontSize: 14, color: Colors.black),
                ),
                const SizedBox(width: 10),
                Text(
                  "shared this",
                  style: GoogleFonts.lexend(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
      
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Divider(color: ColorManager.dividerColor, thickness: 0.39),
            ),
      
            const SizedBox(height: 10),
      
            // Top Section Of Card
            switch (state.type!) {
              'event' => TopSectionCard(
                isFollow: false,
                leadingImg: "${state.eventItem?.clubLogo}",
                onFollow: () {},
                onMenu: () {},
                since: "${state.eventItem?.eventTime}",
                subTitle:
                    "${state.eventItem?.areaName},${state.eventItem?.cityName}",
                title: "${state.eventItem?.clubName}",
              ),
      
              //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);
              'gallery' => TopSectionCard(
                hideFollow: true,
                hideSince: true,
                isFollow: true,
                leadingImg: "${state.galleryItem?.clubLogo}",
                onFollow: () {},
                onMenu: () {},
                since: "${state.galleryItem?.clubId}",
                subTitle: "${state.galleryItem?.meta?.address}",
                title: "${state.galleryItem?.clubName}",
              ),
      
              'teaser' => TopSectionCard(
                hideFollow: true,
                isFollow: true,
                leadingImg: "${state.teaserItem?.clubLogo}",
                onFollow: () {},
                onMenu: () {},
                since: "${state.teaserItem?.clubId}",
                subTitle:
                    "${state.teaserItem?.areaName}${state.teaserItem?.cityName}",
                title: "${state.teaserItem?.clubName}",
              ),
      
              // TODO: Handle this case.
              String() => throw UnimplementedError(),
            },
      
            const SizedBox(height: 10),
      
            // Media Content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.83,
                  height: height,
                  child: Container()
                ),
      
                const SizedBox(width: 3),
      
                //SideBar Buttons
                switch (state.type!) {
                  'event' => SideBar(
                    commentCount: 0,
                    followCount: 0,
                    likeCount: (state.eventItem?.totalLikes ?? 0).toDouble(),
                    onBookmark: () {},
                    onComment: () {},
                    onFollow: () {},
                    onLike: () {},
                    onStar: () {},
                  ),
      
                  //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);
                  'gallery' => SideBar(
                    commentCount: 0,
                    followCount: 0,
                    likeCount: 0,
                    onBookmark: () {},
                    onComment: () {},
                    onFollow: () {},
                    onLike: () {},
                    onStar: () {},
                  ),
                  'teaser' => SideBar(
                    commentCount: 0,
                    followCount: 0,
                    likeCount: (state.teaserItem?.totalLikes ?? 0).toDouble(),
                    onBookmark: () {},
                    onComment: () {},
                    onFollow: () {},
                    onLike: () {},
                    onStar: () {},
                  ),
      
                  // TODO: Handle this case.
                  String() => throw UnimplementedError(),
                },
                // SideBar(commentCount: 0, followCount: 0, likeCount: state.eventItem?.totalLikes as double, onBookmark: (){}, onComment: (){}, onFollow: (){}, onLike: (){}, onStar: (){})
              ],
            ),
      
            const SizedBox(height: 8),
            //Caption Text
            switch (state.type!) {
              'event' => Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "${state.eventItem?.name}",
                    style: getBold14Style(color: Colors.black),
                    textAlign: .left,
                  ),
                  Text(
                    "${state.eventItem?.eventDate},${state.eventItem?.eventTime} - ${state.eventItem?.eventEndTime}",
                    style: getRegular14Style(color: Colors.black),
                    textAlign: .left,
                  ),
                ],
              ),
      
              //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);
              'gallery' => Container(),
              'teaser' => Container(),
      
              // TODO: Handle this case.
              String() => throw UnimplementedError(),
            },
      
            // Caption
            //  !widget.data.isAd
            //       ?CaptionText(data: widget.data)
            //       : Column(
            //         crossAxisAlignment: .start,
            //         children: [
            //           Text(
            //               "The Live Edit connaught club house 25 July 2025",
            //               style: getBold14Style(color: Colors.black),
            //               textAlign: .left,
            //             ),
            //              Text(
            //               "12 Oct25, 8:00 PM – 11:30 PM",
            //               style: getRegular14Style(color: Colors.black),
            //               textAlign: .left,
            //             ),
            //         ],
            //       ),
          ],
        ),
      ),
    );
  }
}
