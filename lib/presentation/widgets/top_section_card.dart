

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';

class TopSectionCard extends StatelessWidget {
  final String leadingImg;
  final String title;
  final String subTitle;
  final String since;
  final Function onFollow;
  final Function onMenu;
  final bool isFollow;
  final bool hideSince;
  final bool hideFollow;

  const TopSectionCard({super.key,
   required this.isFollow,
   required this.leadingImg,
   required this.onFollow,
   required this.onMenu,
   required this.since,
   required this.subTitle,
   required this.title,
    this.hideFollow = false,
    this.hideSince =false
   });

  @override
  Widget build(BuildContext context) {
    return  Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: Image.network(
                  leadingImg,
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
                            title,
                            style: getBold16Style(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SvgPicture.asset(Assets.checkIcSvg),
                        !hideSince ?SvgPicture.asset(Assets.dimondIcSvg):Container(),
                        !hideSince ?const SizedBox(width: 5):Container(),
                        !hideSince ? Text(
                          since == 0
                              ? "Just Now"
                              : "${since} H",
                          style: getRegular14Style(color: Colors.grey),
                        ):Container(),
                      ],
                    ),
                    Text(
                      subTitle ,
                      style: GoogleFonts.lexend(color: Colors.black),
                      overflow: .ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),

              !hideFollow? TextButton(
                onPressed: onFollow(),
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
                    !isFollow ? "Reserve" : "Follow",
                    style: GoogleFonts.lexend(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ):Container(),
         IconButton(onPressed: (){}, icon:  Icon(Icons.more_horiz,color: ColorManager.rightIcColor,)),
            SizedBox(width: 3,)
            ],
          );
  }
}