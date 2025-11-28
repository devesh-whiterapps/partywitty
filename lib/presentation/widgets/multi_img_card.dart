import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:partywitty/gen/assets.gen.dart';

class MultiImgCard extends StatelessWidget {
  final List<String> imgList;
  final Function onTap;
  const MultiImgCard({super.key,required this.imgList,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        ImageSlideshow(
                                  width: double.infinity,
                                  height: 450,
                                  initialPage: 0,
                                  indicatorColor: Colors.blue,
                                  indicatorBackgroundColor: Colors.grey,
                                  autoPlayInterval: 3000,
                                  isLoop: true,
                                  children: imgList
                                      .map(
                                        (url) => InkWell(
                                          onTap: () => onTap,
                                          child: Image.network(
                                            url,
                                            width: double.infinity,
                                            height: 450,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),

                                 
                         Positioned(
                              left: 10,
                              top: 220,
                              child: Assets.arrorLeft.image(),
                            ),
                          
                       Positioned(
                              right: 10,
                              top: 220,
                              child: Assets.arrowRight.image(),
                            )
                         ,
      ],
    );
  }
}