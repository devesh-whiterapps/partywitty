import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:partywitty/domain/entities/feed/feed_event.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/resources/image_assets.dart';
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
  const FeedCardPage({super.key,required this.item,required this.width});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedCardBloc(item: item)..add(FeedCardInitEvent()),
      child: BlocConsumer<FeedCardBloc, FeedCardState>(
        listener: (context, state) {
          if(state.status == FeedCardStatus.loading){
            
                      switch(item.type){
                                  case 'event':
                                  print("Listener Excuted");
                                  context.read<FeedCardBloc>().add(SetDataTypeEvent(type: item.type??'',eventItem: item.data as EventModel));
                                  case 'package':
                                  context.read<FeedCardBloc>().add(SetDataTypeEvent(type: item.type??'',packageItem: item.data as PackageModel));
                                  case 'gallery':
                                  context.read<FeedCardBloc>().add(SetDataTypeEvent(type: item.type??'',galleryItem: item.data as GalleryModel));
                                  case 'teaser':
                                  context.read<FeedCardBloc>().add(SetDataTypeEvent(type: item.type??'',teaserItem: item.data as TeaserModel));
                                  default:
                                  
                              }
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case FeedCardStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case FeedCardStatus.loaded:
              return FeedCardLoadedPage(state: state,width: width,);
            case FeedCardStatus.error:
              return Scaffold(
                body: Center(child: Text(state.error ?? "An error occurred")),
              );
            default:
              return const Center(child: Text("UnknownState"),);
          }
        },
      ),
    );
  }
}

class FeedCardLoadedPage extends StatelessWidget {
  FeedCardState state;
  final double width;
  FeedCardLoadedPage({super.key, required this.state,required this.width});

  @override
  Widget build(BuildContext context) {

      
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE9EBDC).withOpacity(0.5),
        border: Border.all(width: 0.76,color: ColorManager.reel_back)
      ),
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
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "shared this",
                      style: GoogleFonts.lexend(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
             
           Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Divider(color: ColorManager.dividerColor,thickness: 0.39,),
                ),
             
          const SizedBox(height: 10),

          // Top Section Of Card
            switch(state.type!){
                                   'event' =>TopSectionCard(isFollow: true, leadingImg: "${state.eventItem?.clubLogo}", onFollow: (){}, onMenu: (){}, since: "${state.eventItem?.eventTime}", subTitle: "${state.eventItem?.areaName},${state.eventItem?.cityName}", title: "${state.eventItem?.clubName}"),
                                  //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);

                                   'gallery' =>TopSectionCard(isFollow: true, leadingImg: "${state.galleryItem?.clubLogo}", onFollow: (){}, onMenu: (){}, since: "${state.galleryItem?.clubId}", subTitle: "${state.galleryItem?.category}", title: "${state.galleryItem?.clubName}"),

                                   'teaser'=>TopSectionCard(isFollow: true, leadingImg: "${state.teaserItem?.clubLogo}", onFollow: (){}, onMenu: (){}, since: "${state.teaserItem?.clubId}", subTitle: "${state.teaserItem?.areaName}${state.teaserItem?.cityName}", title: "${state.teaserItem?.clubName}"),

                                  
                                  
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
                height: 450,
                child: switch(state.type!){
                                   'event' =>SingleImageSection(imageUrl: "${state.eventItem?.image}", onTap: (){}),
                                  //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);

                                   'gallery' =>MultiImgCard(imgList: state.galleryItem!.images!.map((data)=>data.img??'').toList(), onTap: (){}),

                                   'teaser'=>VideoCard(onTap: (){}, url: "${state.teaserItem?.video}"),

                                  
                                  
              // TODO: Handle this case.
              String() => throw UnimplementedError(),
                              },
              ),

              const SizedBox(width: 3),

              //SideBar Buttons
              switch(state.type!){
                                   'event' =>SideBar(commentCount: 0, followCount: 0, likeCount: (state.eventItem?.totalLikes ??0).toDouble(), onBookmark: (){}, onComment: (){}, onFollow: (){}, onLike: (){}, onStar: (){}),
                                  //  'package'=>TopSectionCard(isFollow: true, leadingImg: "${state.packageItem?.clubLogo}", onFollow: onFollow, onMenu: onMenu, since: since, subTitle: subTitle, title: title);

                                   'gallery' =>SideBar(commentCount: 0, followCount: 0, likeCount: 0, onBookmark: (){}, onComment: (){}, onFollow: (){}, onLike: (){}, onStar: (){}),
                                   'teaser'=>SideBar(commentCount: 0, followCount: 0, likeCount:( state.teaserItem?.totalLikes ??0).toDouble(), onBookmark: (){}, onComment: (){}, onFollow: (){}, onLike: (){}, onStar: (){}),

                                  
                                  
              // TODO: Handle this case.
              String() => throw UnimplementedError(),
                              },
              // SideBar(commentCount: 0, followCount: 0, likeCount: state.eventItem?.totalLikes as double, onBookmark: (){}, onComment: (){}, onFollow: (){}, onLike: (){}, onStar: (){})
            ],
          ),

          const SizedBox(height: 8),

           switch(state.type!){
                                   'event' =>Column(
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

                                   'gallery' =>Container(),
                                   'teaser'=>Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                      "${state.teaserItem?.meta?.address}",
                      style: getBold14Style(color: Colors.black),
                      textAlign: .left,
                    ),
                     Text(
                      "${state.teaserItem?.meta?.slug}",
                      style: getRegular14Style(color: Colors.black),
                      textAlign: .left,
                    ),
                ],
              ),

                                  
                                  
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
    );
}


}