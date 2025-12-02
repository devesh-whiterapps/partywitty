import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MultiImgReel extends StatefulWidget {
  
  const MultiImgReel({super.key, });

  @override
  State<MultiImgReel> createState() => _MultiImgReelState();
}

class _MultiImgReelState extends State<MultiImgReel> {
  int pageIndex = 0;
  late CarouselSliderController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = CarouselSliderController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> args = 
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      
  final List<String?> imgList = args['images'] ;
  // print("1245 ${imgList![0]}");
  final int itemId = args['id'];

    return 
    Scaffold(body: Stack(
      alignment: .center,
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: imgList
              .map(
                (url) =>CachedNetworkImage(
  imageUrl: url??'',
  fit: .fill,
  // Equivalent to the original loadingBuilder
  placeholder: (BuildContext context, String url) {
    // Show a loading indicator while the image is loading
    return 
        Center(
          // Note: CachedNetworkImage's placeholder doesn't provide
          // the exact ImageChunkEvent. We use a standard
          // CircularProgressIndicator. If you need the progress value,
          // you should use the progressBuilder instead.
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
              )
              .toList(),
            
               options: CarouselOptions(autoPlay: true,viewportFraction: 1,height: double.infinity,onPageChanged: (index, reason) => setState(() {
                if(index<imgList!.length){
pageIndex =index;
                }
                 
               }),)),

              // Positioned(bottom: 30, 
              //  child: Transform.scale(
              //   scale: 0.5,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
              //     decoration: BoxDecoration(
              //       color: ColorManager.primary.withAlpha(100),
              //       borderRadius: BorderRadius.circular(30),

              //     ),
              //     child: AnimatedSmoothIndicator(    
              //         activeIndex: pageIndex,   
              //        count:  6,    
              //        effect:  WormEffect(
              //         radius: 10,
              //         dotColor: ColorManager.primary,
              //         activeDotColor: ColorManager.primary
              //        ),  // your preferred effect    
              //        onDotClicked: (index){    
              //       }
              //     ),
              //   ),
              // ),),
       

        // Positioned(left: 10, top: 220, child: InkWell(
        //   onTap: (){
        //     setState(() {
        //       _controller.previousPage();
        //     });
        //   },
        //   child: Transform.scale(
        //     scaleX: -1,
        //     child: Assets.arrowRight.image()),
        // )),

        // Positioned(right: 10, top: 220, child: InkWell(onTap:(){
        //   setState(() {
        //     _controller.nextPage();
        //   });
        // },child:  Assets.arrowRight.image())),
      ],
    ),); 

  
    
       }
}
