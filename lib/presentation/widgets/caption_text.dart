import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/model/feed_model.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';

class CaptionText extends StatefulWidget {
  final FeedItem1 data;
  
  CaptionText({super.key, required this.data});

  @override
  State<CaptionText> createState() => _CaptionTextState();
}

class _CaptionTextState extends State<CaptionText> {
  bool isExpanded = false;
  int? maxLines = 2;
  String addtionalCaption='';
  String btnText = "..more";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data.caption!.length <35){
      addtionalCaption =  widget.data.caption!;
    }else
addtionalCaption = widget.data.caption!.substring(0,35);
    
    
  }
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        // Base style for all children (optional)
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        children: <InlineSpan>[
          // 1. Standard Text
          TextSpan(
            text: '${widget.data.username}',
            style: getBold14Style(color: Colors.black),
          ),

          // 2. WidgetSpan for the Image
          WidgetSpan(
            // The widget to embed (e.g., Image, Icon, Container)
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              // It's crucial to use a constrained widget here (like SizedBox or Icon)
              child: Assets.checkIc.image(),
            ),
            // Alignment controls how the widget sits vertically relative to the text baseline
            alignment: PlaceholderAlignment.middle,
          ),
          // WidgetSpan(
          //         // The widget to embed (e.g., Image, Icon, Container)
          //         child:Text("${widget.data.caption}",style: getRegular10Style(color: Colors.black),maxLines: maxLines,),
          //         // Alignment controls how the widget sits vertically relative to the text baseline
          //         alignment: PlaceholderAlignment.middle,
          //       ),
          // 3. More Standard Text
          TextSpan(
            text: '$addtionalCaption',
            style: getRegular10Style(color: Colors.black, fontSize: 14),
            children: [
             widget.data.caption!.length > 35 ? WidgetSpan(
            // The widget to embed (e.g., Image, Icon, Container)
            child: TextButton(
              // splashColor: Colors.amber,
              onPressed: () {
               
                setState(() {
 isExpanded = !isExpanded;
                if (isExpanded == false) {
                  addtionalCaption = widget.data.caption!.substring(0,35);
                  btnText = '..more';
                } else {
                  btnText = '..less';
                  addtionalCaption = widget.data.caption??'';

                }
                });
              },
              child: Text("$btnText",style: getBold14Style(color: Colors.black),),
            ),
            // Alignment controls how the widget sits vertically relative to the text baseline
            alignment: PlaceholderAlignment.middle,
          ):WidgetSpan(child: Container()),
            ]
          ),
          
        ],
      ),
    );
  }
}
