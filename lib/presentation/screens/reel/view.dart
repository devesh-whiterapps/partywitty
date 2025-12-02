import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/model/feed_model.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/resources/image_assets.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';
import 'package:partywitty/presentation/widgets/post_card.dart';
import 'package:video_player/video_player.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class ReelPage extends StatelessWidget {
  const ReelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReelBloc()..add(ReelInitEvent()),
      child: BlocConsumer<ReelBloc, ReelState>(
        listener: (context, state) {
          // handle navigation or snackbars
          if (state.status == ReelStatus.loaded){
            state.controller!.play();
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case ReelStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case ReelStatus.loaded:
              return ReelLoadedPage(state1: state);
            case ReelStatus.error:
              return Scaffold(
                body: Center(child: Text(state.error ?? "An error occurred")),
              );
            default:
              return const Scaffold(body: Center(child: Text("Unknown state")));
          }
        },
      ),
    );
  }
}

class ReelLoadedPage extends StatelessWidget {
  ReelState state1;
  ReelLoadedPage({super.key, required this.state1});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReelBloc>().state;
    final width = MediaQuery.of(context).size.width;

    // 1. Extract the arguments from the Route
    // final args = ModalRoute.of(context)!.settings.arguments;

    // // 2. Check and Cast the data safely
    // // It's good practice to ensure it's not null and is the right type
    // if (args == null) {
    //   return const Scaffold(body: Center(child: Text("Error: No Data Found")));
    // }

    // final Map<String,dynamic> data = args as Map<String, dynamic>;

    return Scaffold(
      body: state.controller!.value.isInitialized
          ? Stack(
            alignment: .center,
            children: [
              // VideoPlayer(state.controller!),
              Positioned(
                top: 35,
                child: Blur(
                  blur: 10,
                  blurColor: ColorManager.reel_back,
                  colorOpacity: 0.3,
                  borderRadius: BorderRadius.circular(30),
                  overlay: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                     Assets.drinksIc.image(),
                      SizedBox(width: 5,),
                      Text("Watch Till End to unlock 25 Tulips",style: getRegular10Style(color: Colors.white),)
                    ],),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                     Assets.drinksIc.image(color: Colors.transparent),
                      SizedBox(width: 5,),
                      Text("Watch Till End to unlock 25 Tulips",style: getRegular10Style(color: Colors.transparent),)
                    ],),
                  ),
                  
                )),

                 Positioned(
                top: 35,
                right: 10,
                child: ClipOval(
                  child: Blur(
                    blur: 10,
                    blurColor: ColorManager.reel_back,
                    colorOpacity: 0.3,
                    overlay: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close,color: Colors.white,)
                      ),
                    ),
                    child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle),
                  
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.close,color: Colors.transparent,)
                      ),
                    ),
                  ),
                )),

                 Positioned(
                // top: 35,
                // right: 10,
                child: Assets.playIc.image()),

                 Positioned(
                bottom: 150,
                right: 10,
                width: 70,
                child: Blur(
                blur: 10,
                  blurColor: ColorManager.reel_back,
                  colorOpacity: 0.3,
                  borderRadius: BorderRadius.circular(8),
                  overlay: Padding(
                  padding: const EdgeInsets.all(2.0),
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
                          icon: Column(
                            children: [
                              SvgPicture.asset(Assets.likeIcSvg,height: 50,width: 50,),
                              Text(
                                "${NumberFormat.compact().format(2560000)}",
                                style: getBold14Style(color: Colors.white),
                              ),
                            ],
                          ),
                        ),

          

                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              SvgPicture.asset(Assets.followerIcSvg,height: 50,width: 50,),
                              // Assets.followerIc.image(color: Colors.white,scale: 0.4),
                              Text(
                                "${NumberFormat.compact().format(40000)}",
                                style: getBold14Style(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
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
                          icon: Column(
                            children: [
                              SvgPicture.asset(Assets.likeIcSvg,height: 50,width: 50,),
                              // Assets.likeIc.image(color: Colors.white,scale: 0.4),
                              Text(
                                "${NumberFormat.compact().format(2560000)}",
                                style: getBold14Style(color: Colors.white),
                              ),
                            ],
                          ),
                        ),

          

                        IconButton(
                          onPressed: () {},
                          icon: Column(
                            children: [
                              SvgPicture.asset(Assets.followerIcSvg,height: 50,width: 50,),

                              // Assets.followerIc.image(color: Colors.white,scale: 0.4),
                              Text(
                                "${NumberFormat.compact().format(40000)}",
                                style: getBold14Style(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ),)),

                Positioned(
                  bottom: 25,
                  left: 10,right: 10,
                  child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
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
                              "The Dark Room",
                              style: getBold16Style(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SvgPicture.asset(Assets.checkIcSvg,),
                              SvgPicture.asset(Assets.dimondIcSvg,),

                            // Assets.checkIc.image(color: Colors.white),
                            // Assets.dimondIc.image(color: Colors.white),
                            Text(
                              "22 H",
                              style: getRegular14Style(color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          "Sappire Plaza,Greater Noida, 0 Kms",
                          style: getRegular14Style(color: Colors.white),
                        ),
                      ],
                    ),
                
                    TextButton(
                      onPressed: () {},
                
                      child: Card(
                        color: Colors.deepPurpleAccent,
                        shape: StadiumBorder(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Reserve" ,
                            style: getBold14Style(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                   
                  ],
                ),

                TextButton(
                      onPressed: () {},
                
                      child: Card(
                        color: Colors.lightGreen,
                        shape: StadiumBorder(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightGreen,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Assets.offersIc.image(color: Colors.white),
                              SizedBox(width: 5,),
                              Text(
                                "20%Off" ,
                                style: getBold14Style(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),),
            ],
          )
          : Container(
            alignment:.center,
            child: Text("Video Loading"),),
    );
  }
}
