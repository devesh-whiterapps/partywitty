import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';

class SideBar extends StatefulWidget {
  final double likeCount;
  final double commentCount;
  final double followCount;
  

  final Function onLike;
  final Function onComment;
  final Function onFollow;
  final Function onBookmark;
  final Function onStar;
  const SideBar({super.key,
  required this.commentCount,
  required this.followCount,
  required this.likeCount,
  required this.onBookmark,
  required this.onComment,
  required this.onFollow,
  required this.onLike,
  required this.onStar
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: .max,
      children: [
        // Top two buttons
        Column(
          children: [
            IconButton(
              onPressed: widget.onStar(),
              icon: Assets.starIc.image(color: ColorManager.rightIcColor),
            ),
            const SizedBox(height: 5), // explicit gap
            IconButton(
              onPressed: widget.onBookmark(),
              icon: Assets.bookmarkIc.image(color: ColorManager.rightIcColor),
            ),
          ],
        ),
    
        const SizedBox(height: 158),
    
        Column(
          children: [
            IconButton(
              onPressed: widget.onLike(),
              icon: Column(
                children: [
                  Assets.likeIc.image(color:ColorManager.rightIcColor),
                  Text(
                    NumberFormat.compact().format(
                      widget.likeCount,
                    ),
                    style: getBold14Style(color: ColorManager.rightIcColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10), // explicit gap
            IconButton(
              onPressed: widget.onComment(),
              icon: Column(
                children: [
                  Assets.commentIc.image(color: ColorManager.rightIcColor),
                  Text(
                    NumberFormat.compact().format(
                      widget.commentCount,
                    ),
                    style: getBold14Style(color: ColorManager.rightIcColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10), // explicit gap
            IconButton(
              onPressed: widget.onFollow(),
              icon: Column(
                children: [
                  Assets.followerIc.image(color: ColorManager.rightIcColor),
                  Text(
                    NumberFormat.compact().format(
                      widget.followCount,
                    ),
                    style: getBold14Style(color: ColorManager.rightIcColor),
                  ),
                ],
              ),
            ),
                         
    
          ],
        ),
      ],
    );
  }
}