import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:partywitty/model/feed_model.dart';
import 'package:partywitty/presentation/resources/image_assets.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';
import 'package:partywitty/presentation/widgets/post_card.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class PostCardPage extends StatelessWidget {
  const PostCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostCardBloc()..add(PostCardInitEvent()),
      child: BlocConsumer<PostCardBloc, PostCardState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case PostCardStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case PostCardStatus.loaded:
              return PostCardLoadedPage(state1: state);
            case PostCardStatus.error:
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

class PostCardLoadedPage extends StatelessWidget {
  PostCardState state1;
  PostCardLoadedPage({super.key, required this.state1});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PostCardBloc>().state;
    final width = MediaQuery.of(context).size.width;

    // 1. Extract the arguments from the Route
    final args = ModalRoute.of(context)!.settings.arguments;

    // 2. Check and Cast the data safely
    // It's good practice to ensure it's not null and is the right type
    if (args == null) {
       return const Scaffold(body: Center(child: Text("Error: No Data Found")));
    }

    final FeedItem data = FeedItem.fromJson(args as Map<String,dynamic>);

    return Container(
            color: Colors.white,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(10),

            child: Column(
              children: [
                //Username Header
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
                              data.name,
                              style: getBold16Style(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),

                            Icon(
                              Icons.check_circle,
                              color: Colors.deepPurpleAccent,
                            ),
                            Icon(Icons.circle, size: 10),
                            Text(
                              "${data.hoursSince == 0 ? "Just Now":data.hoursSince}",
                              style: getRegular14Style(color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          data.subtitle??"Check In",
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
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Follow",
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
                SizedBox(height: 10),
                //Media COntent
                Row(
                  children: [
                     //Media
                     data.imageUrls == null?
                     Stack(
                      alignment: .center,
                      children: [
                       
                        Image.network(
                          ImgAssets.boy,
                          height: 450,
                          width: width * 0.8,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => ErrorWidget(error),
                        ),
                        Positioned(
                          child: IconButton(onPressed: (){}, icon: Container(
                          decoration: BoxDecoration(
                                    shape: .circle,
                                    border: Border.all(),
                                  ),
                          child: Icon(Icons.play_arrow_outlined,size: 50,)))),

                          Positioned(
                            right: 10,
                            bottom: 10,
                          child: IconButton(onPressed: (){}, icon: Container(
                          decoration: BoxDecoration(
                                    shape: .circle,
                                    border: Border.all(),
                                  ),
                          child: Icon(Icons.volume_up_outlined,size: 30,)))),
                      ],
                    ):Placeholder(),
                   
                    
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
                                icon: Container(
                                  decoration: BoxDecoration(
                                    shape: .circle,
                                    border: Border.all(),
                                  ),
                                  child: Icon(
                                    Icons.star_border_rounded,
                                    size: 30,
                                  ),
                                ),
                              ),

                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.bookmark_outline, size: 30),
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
                                    Icon(
                                      Icons.favorite_border_outlined,
                                      size: 30,
                                    ),
                                    Text(
                                      "${NumberFormat.compact().format(data.likeCount)}",
                                      style: getBold14Style(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () {},
                                icon: Column(
                                  children: [
                                    Icon(Icons.comment_outlined, size: 30),
                                    Text(
                                      "${NumberFormat.compact().format(data.commentCount)}",
                                      style: getBold14Style(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                               IconButton(
                                onPressed: () {},
                                icon: Column(
                                  children: [
                                    Icon(CupertinoIcons.paperplane, size: 30),
                                    Text(
                                      "${NumberFormat.compact().format(data.followerCount)}",
                                      style: getBold14Style(
                                        color: Colors.black,
                                      ),
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
                Row(children: [
                  Text("${data.username}",style: getBold14Style(color: Colors.black),),
                  SizedBox(width: 10,),
                  Icon(
                              Icons.check_circle,
                              color: Colors.deepPurpleAccent,
                            ),
                ],),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text("${data.caption}",style: getRegular10Style(color: Colors.black),maxLines: 3,softWrap: true,)),

              ],
            ),
          );
}
}