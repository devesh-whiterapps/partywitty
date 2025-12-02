import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class ReelPage extends StatelessWidget {
   final String title;
  final String subTitle;
  final String clubLogo;
  final String since;
  final int disc;
  final int id;
  final double width;
  const ReelPage({super.key, required this.title, 
  required this.subTitle,
   required this.clubLogo,
    required this.since,
     required this.disc,
      required this.id,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReelBloc(title: title, subtitle: subTitle, since: since, disc: disc, clubLogo: clubLogo, id: id)..add(ReelInitEvent()),
      child: BlocConsumer<ReelBloc, ReelState>(
        listener: (context, state) {
          // handle navigation or snackbars
          // if (state.status == ReelStatus.loaded){
          //   state.controller!.play();
          // }
        },
        builder: (context, state) {
          switch (state.status) {
            case ReelStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator(color: Colors.amber,)),
              );
            case ReelStatus.loaded:
              return ReelLoadedPage(state1: state,width:width);
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
  final double width;
  ReelLoadedPage({super.key, required this.state1,required this.width});

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

    return  SizedBox(
      width: width,
      child: Stack(
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
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.close,color: Colors.white,)
                          ),
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
      
                  //  Positioned(
                  // // top: 35,
                  // // right: 10,
                  // child: Assets.playIc.image()),
      
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
                                SvgPicture.asset(Assets.likeIcSvg,height: 50,width: 50,color: Colors.white,),
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
                                SvgPicture.asset(Assets.followerIcSvg,height: 50,width: 50,color: Colors.white,),
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
                                SvgPicture.asset(Assets.likeIcSvg,height: 50,width: 50,color: Colors.white,),
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
                                SvgPicture.asset(Assets.followerIcSvg,height: 50,width: 50,color: Colors.white,),
      
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
                    left: 10,bottom: 80,
                    child:  ClipOval(
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  state.clubLogo!,
                                  fit: .cover,
                                  width: 50,
                                  height: 50,
                                  errorBuilder: (context, error, stackTrace) =>
                                      ErrorWidget("exception"),
                                ),
                              ),),

                              Positioned(
                    left: 10,bottom: 15,
                    child:  (state.disc??0) > 0? TextButton(
                                onPressed: () {},
                          
                                child: Card(
                                  color: Colors.lightGreen,
                                  shape: StadiumBorder(),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4,
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
                                          "${state.disc}%Off" ,
                                          style: getBold14Style(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ):Container(),),

                              Positioned(
                    right: 0,bottom: 80,
                    child:      TextButton(
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
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),),

                              Positioned(
                    left: 65,bottom: 85,
                    child:SizedBox(
                                width: width*0.5,
                                child: Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Row(
                                      spacing: 10,
                                      children: [
                                        Text(
                                          "${state.title}",
                                          style: getBold16Style(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                          overflow: .ellipsis,
                                          maxLines: 1,
                                        ),
                                        SvgPicture.asset(Assets.checkIcSvg,color: Colors.white,),
                                          state.since!.isNotEmpty? SvgPicture.asset(Assets.dimondIcSvg,color: Colors.white,):Container(),
                                                  
                                        // Assets.checkIc.image(color: Colors.white),
                                        // Assets.dimondIc.image(color: Colors.white),
                                        Text(
                                          "${state.since}",
                                          style: getRegular14Style(color: Colors.white,fontSize: 12),
                                          overflow: .ellipsis,
                                      maxLines: 1,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${state.subTitle}",
                                      style: getRegular14Style(color: Colors.white,fontSize: 12),
                                      overflow: .ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),),
      //This Positioned Widget is overflowing horizontally suggets fix
                  // Positioned(
                  //   bottom: 25,
                  //   left: 10,right: 10,
                  //   child: SizedBox(
                  //     height: 115,width: width,
                  //     child: Column(
                  //       crossAxisAlignment: .start,
                  //       children: [
                          
                  //     Row(
                  //           mainAxisAlignment: .spaceEvenly, 
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             ClipOval(
                  //               clipBehavior: Clip.hardEdge,
                  //               child: Image.network(
                  //                 state.clubLogo!,
                  //                 fit: .cover,
                  //                 width: 50,
                  //                 height: 50,
                  //                 errorBuilder: (context, error, stackTrace) =>
                  //                     ErrorWidget("exception"),
                  //               ),
                  //             ),
                  //             SizedBox(width: 5),
                  //             SizedBox(
                  //               width: width*0.5,
                  //               child: Column(
                  //                 crossAxisAlignment: .start,
                  //                 children: [
                  //                   Row(
                  //                     spacing: 10,
                  //                     children: [
                  //                       Text(
                  //                         "${state.title}",
                  //                         style: getBold16Style(
                  //                           color: Colors.white,
                  //                           fontSize: 14,
                  //                         ),
                  //                         overflow: .ellipsis,
                  //                                                         maxLines: 1,
                  //                       ),
                  //                       SvgPicture.asset(Assets.checkIcSvg,color: Colors.white,),
                  //                         SvgPicture.asset(Assets.dimondIcSvg,),
                                                  
                  //                       // Assets.checkIc.image(color: Colors.white),
                  //                       // Assets.dimondIc.image(color: Colors.white),
                  //                       Text(
                  //                         "${state.since}",
                  //                         style: getRegular14Style(color: Colors.white,fontSize: 12),
                  //                         overflow: .ellipsis,
                  //                     maxLines: 1,
                  //                       ),
                  //                     ],
                  //                   ),
                  //                   Text(
                  //                     "${state.subTitle}",
                  //                     style: getRegular14Style(color: Colors.white,fontSize: 12),
                  //                     overflow: .ellipsis,
                  //                     maxLines: 1,
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                          
                  //             TextButton(
                  //               onPressed: () {},
                          
                  //               child: Card(
                  //                 color: Colors.deepPurpleAccent,
                  //                 shape: StadiumBorder(),
                  //                 child: Container(
                  //                   padding: EdgeInsets.symmetric(
                  //                     vertical: 5,
                  //                     horizontal: 10,
                  //                   ),
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.deepPurpleAccent,
                  //                     borderRadius: BorderRadius.circular(20),
                  //                   ),
                  //                   child: Text(
                  //                     "Reserve" ,
                  //                     style: getBold14Style(
                  //                       color: Colors.white,
                  //                       fontSize: 14,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                             
                  //           ],
                  //         ),
                                  
                      
                  //         (state.disc??0) > 0? TextButton(
                  //               onPressed: () {},
                          
                  //               child: Card(
                  //                 color: Colors.lightGreen,
                  //                 shape: StadiumBorder(),
                  //                 child: Container(
                  //                   padding: EdgeInsets.symmetric(
                  //                     vertical: 8,
                  //                     horizontal: 15,
                  //                   ),
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.lightGreen,
                  //                     borderRadius: BorderRadius.circular(20),
                  //                   ),
                  //                   child: Row(
                  //                     children: [
                  //                       Assets.offersIc.image(color: Colors.white),
                  //                       SizedBox(width: 5,),
                  //                       Text(
                  //                         "${state.disc}%Off" ,
                  //                         style: getBold14Style(
                  //                           color: Colors.white,
                  //                           fontSize: 15,
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
                  //             ):Container(),
                  //       ],
                  //     ),
                  //   ),),
              ],
            ),
    );
         
    
  }
}
