import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:partywitty/presentation/screens/reel/view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SingleImgReel extends StatefulWidget {
  
  const SingleImgReel({super.key, });

  @override
  State<SingleImgReel> createState() => _SingleImgReelState();
}

class _SingleImgReelState extends State<SingleImgReel> {

  @override
  void initState() {
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

   // 1. Get arguments safely, checking for null
    final args1 = ModalRoute.of(context)?.settings.arguments;

    // 2. Safely cast to the expected type (Map<String, dynamic> or null)
    final Map<String, dynamic>? args = args1 is Map<String, dynamic> ? args1 : null;
      
  final String imageUrl = args?['image'] ;
  print("1245 $imageUrl");
    final String title = args?['title'] ;

  final String subTitle = args?['subTitle'] ;

  final String leadImg = args?['leadImg'] ;

  final String since = args?['since'] ;

  final int disc = args?['disc'] ;

  final int itemId = args?['id'];

    return 
    Scaffold(
      extendBody: true,
      body: Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: .fill,
          // Equivalent to the original loadingBuilder
          placeholder: (BuildContext context, String url) {
            // Show a loading indicator while the image is loading
            return 
          Center(
        
            child: CircularProgressIndicator(),
          );
          },
          // Equivalent to the original errorBuilder
          errorWidget: (BuildContext context, String url, dynamic error) {
            // Show an error icon and text if the image fails to load
            return  Container(
        color: Colors.grey[200], // Light grey background for error
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.broken_image,
              color: Colors.grey[600],
              size: 60,
            ),
            const SizedBox(height: 8),
            Text(
              'Failed to load image',
              style: TextStyle(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
            );
          },
        ),

          Positioned.fill(child: ReelPage(title: title, subTitle: subTitle, since: since, disc: disc, clubLogo: leadImg, id: itemId,width: MediaQuery.of(context).size.width,))
      ],
    ),
    );
       }
}
