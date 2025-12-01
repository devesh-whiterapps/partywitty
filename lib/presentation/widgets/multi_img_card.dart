import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:partywitty/gen/assets.gen.dart';
import 'package:partywitty/presentation/resources/color_manager.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MultiImgCard extends StatefulWidget {
   final List<String> imgList;
  final Function onTap;
  const MultiImgCard({super.key, required this.imgList, required this.onTap});

  @override
  State<MultiImgCard> createState() => _MultiImgCardState();
}

class _MultiImgCardState extends State<MultiImgCard> {
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
    return  Stack(
      alignment: .center,
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: widget.imgList
              .map(
                (url) => InkWell(
                  onTap: () => widget.onTap,
                  child: Image.network(
                    url,
                    width: double.infinity,
                    height: 450,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width:  double.infinity,
                      color:
                          Colors.grey[200], // Light grey background for error
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
                    ),
                  ),
                ),
              )
              .toList(),
            
               options: CarouselOptions(autoPlay: true,viewportFraction: 1,height: double.infinity,onPageChanged: (index, reason) => setState(() {
                if(index<widget.imgList.length){
pageIndex =index;
                }
                 
               }),)),

              Positioned(bottom: 30, 
               child: Transform.scale(
                scale: 0.5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  decoration: BoxDecoration(
                    color: ColorManager.primary.withAlpha(100),
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child: AnimatedSmoothIndicator(    
                      activeIndex: pageIndex,   
                     count:  6,    
                     effect:  WormEffect(
                      radius: 10,
                      dotColor: ColorManager.primary,
                      activeDotColor: ColorManager.primary
                     ),  // your preferred effect    
                     onDotClicked: (index){    
                    }
                  ),
                ),
              ),),
        // ImageSlideshow(
        //   width: double.infinity,
        //   height: 450,
        //   initialPage: 0,
        //   indicatorColor: ColorManager.primary,
        //   indicatorBackgroundColor: Colors.grey,
        //   autoPlayInterval: 3000,
        //   isLoop: true,
        //   children: imgList
        //       .map(
        //         (url) => InkWell(
        //           onTap: () => onTap,
        //           child: Image.network(
        //             url,
        //             width: double.infinity,
        //             height: 450,
        //             fit: BoxFit.cover,
        //             errorBuilder: (context, error, stackTrace) => Container(
        //               color:
        //                   Colors.grey[200], // Light grey background for error
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     Icons.broken_image,
        //                     color: Colors.grey[600],
        //                     size: 60,
        //                   ),
        //                   const SizedBox(height: 8),
        //                   Text(
        //                     'Failed to load image',
        //                     style: TextStyle(color: Colors.grey[600]),
        //                     textAlign: TextAlign.center,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //       .toList(),
        // ),

        Positioned(left: 10, top: 220, child: InkWell(
          onTap: (){
            setState(() {
              _controller.previousPage();
            });
          },
          child: Transform.scale(
            scaleX: -1,
            child: Assets.arrowRight.image()),
        )),

        Positioned(right: 10, top: 220, child: InkWell(onTap:(){
          setState(() {
            _controller.nextPage();
          });
        },child:  Assets.arrowRight.image())),
      ],
    );
  }
}

class MultiImgCard1 extends StatelessWidget {
  final List<String> imgList;
  final Function onTap;
  const MultiImgCard1({super.key, required this.imgList, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        CarouselSlider(items: imgList
              .map(
                (url) => InkWell(
                  onTap: () => onTap,
                  child: Image.network(
                    url,
                    width: double.infinity,
                    height: 450,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color:
                          Colors.grey[200], // Light grey background for error
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
                    ),
                  ),
                ),
              )
              .toList(),
            
               options: CarouselOptions(autoPlay: true,viewportFraction: 1,height: double.infinity,onPageChanged: (index, reason) {} ,)),

              Positioned(bottom: 10,  child: AnimatedStepIndicator(totalSteps: 5, currentStep: 3)),
        // ImageSlideshow(
        //   width: double.infinity,
        //   height: 450,
        //   initialPage: 0,
        //   indicatorColor: ColorManager.primary,
        //   indicatorBackgroundColor: Colors.grey,
        //   autoPlayInterval: 3000,
        //   isLoop: true,
        //   children: imgList
        //       .map(
        //         (url) => InkWell(
        //           onTap: () => onTap,
        //           child: Image.network(
        //             url,
        //             width: double.infinity,
        //             height: 450,
        //             fit: BoxFit.cover,
        //             errorBuilder: (context, error, stackTrace) => Container(
        //               color:
        //                   Colors.grey[200], // Light grey background for error
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     Icons.broken_image,
        //                     color: Colors.grey[600],
        //                     size: 60,
        //                   ),
        //                   const SizedBox(height: 8),
        //                   Text(
        //                     'Failed to load image',
        //                     style: TextStyle(color: Colors.grey[600]),
        //                     textAlign: TextAlign.center,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //       .toList(),
        // ),

        Positioned(left: 10, top: 220, child: Assets.arrorLeft.image()),

        Positioned(right: 10, top: 220, child: Assets.arrowRight.image()),
      ],
    );
  }
}



class AnimatedStepIndicator extends StatefulWidget {
  final int totalSteps;
  final int currentStep; // The step we are moving towards (1-based)
  final Color activeColor;
  final Color inactiveColor;

  const AnimatedStepIndicator({
    Key? key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor = const Color(0xFF6B58D2),
    this.inactiveColor = const Color(0x806B58D2),
  }) : assert(currentStep >= 1 && currentStep <= totalSteps),
       super(key: key);

  @override
  State<AnimatedStepIndicator> createState() => _AnimatedStepIndicatorState();
}

class _AnimatedStepIndicatorState extends State<AnimatedStepIndicator>
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  
  // This value will track the *starting* point for the animation
  int _previousStep = 1;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    // If the current step changes externally, we trigger the animation
    if (widget.totalSteps<widget.currentStep &&widget.currentStep != _previousStep) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedStepIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentStep != oldWidget.currentStep) {
      _previousStep = oldWidget.currentStep;
      _startAnimation();
    }
  }

  void _startAnimation() {
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // --- Rendering the Indicator ---

  @override
  Widget build(BuildContext context) {
    // The AnimatedBuilder rebuilds the CustomPaint whenever the animation changes
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          // Set a fixed size for the painter canvas
          size: Size(
              (widget.totalSteps * 20.0) + (widget.totalSteps - 1) * 8.0, 20.0), 
          painter: _StepIndicatorPainter(
            totalSteps: widget.totalSteps,
            previousStep: _previousStep,
            currentStep: widget.currentStep,
            animationValue: _controller.value, // Pass the current animation value (0.0 to 1.0)
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
          ),
        );
      },
    );
  }
}

class _StepIndicatorPainter extends CustomPainter {
  final int totalSteps;
  final int previousStep;
  final int currentStep;
  final double animationValue; // 0.0 at start, 1.0 at end
  final Color activeColor;
  final Color inactiveColor;

  _StepIndicatorPainter({
    required this.totalSteps,
    required this.previousStep,
    required this.currentStep,
    required this.animationValue,
    required this.activeColor,
    required this.inactiveColor,
  });

  // Constants
  final double radius = 6.0;
  final double spacing = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final activePaint = Paint()..color = activeColor;
    final inactivePaint = Paint()..color = inactiveColor;
    
    // Calculate the total width of one segment (circle + spacing)
    final double segmentWidth = (radius * 2) + spacing;
    // Y position for the center of all circles
    final double center_Y = size.height / 2;

    // --- 1. Draw all static circles ---
    for (int i = 0; i < totalSteps; i++) {
      final center_X = radius + (i * segmentWidth);
      
      // Determine color: The current step is the target/active one
      final paint = (i + 1 == currentStep) ? activePaint : inactivePaint;

      canvas.drawCircle(Offset(center_X, center_Y), radius, paint);
    }
    
    // --- 2. Draw the Elongated Animated Bar (Transition) ---
    
    // Determine start and end X coordinates based on the transition direction
    // Start index is the completed step (previousStep - 1) or 0 if starting from step 1
    final double start_X = radius + ((previousStep - 1) * segmentWidth);
    final double end_X = radius + ((currentStep - 1) * segmentWidth);

    // Interpolate the current X position for the center of the animated bar
    final double current_X = start_X + (end_X - start_X) * animationValue;

    // Calculate the length of the animated bar (distance between two segment centers)
    final double barLength = segmentWidth - spacing; 
    
    // Define the rect for the animated bar (elongated shape)
    // The bar starts at the previous step's center and moves to the current step's center
    
    // Calculate the bounds for the rectangle at the current animation position
    // We want the bar to be centered at current_X and have a length of barLength
    final Rect elongatedRect = Rect.fromCenter(
      center: Offset(current_X, center_Y),
      width: barLength + (2 * radius), // Make it long enough to overlap the circles
      height: 2 * radius,
    );

    // Draw the rounded rectangle
    canvas.drawRRect(
      RRect.fromRectAndRadius(elongatedRect, Radius.circular(radius)),
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _StepIndicatorPainter oldDelegate) {
    // Repaint only when the animation value changes
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.currentStep != currentStep;
  }
}