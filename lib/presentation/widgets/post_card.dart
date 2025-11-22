import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/image_assets.dart';
import '../resources/style_manager.dart';

Widget PostCard({required double width,required bool isAd})=>Container(
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
                              "Zeeshan Ahmad",
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
                              "22 h",
                              style: getRegular14Style(color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(
                          "Check In",
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
                                      "100K",
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
                                      "100K",
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
                                      "100K",
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
                  Text("Zeeshan.ahmad",style: getBold14Style(color: Colors.black),),
                  SizedBox(width: 10,),
                  Icon(
                              Icons.check_circle,
                              color: Colors.deepPurpleAccent,
                            ),
                ],),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae ...More",style: getRegular10Style(color: Colors.black),maxLines: 3,softWrap: true,)),

              ],
            ),
          );