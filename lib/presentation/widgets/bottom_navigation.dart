import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const CustomBottomNavigation({super.key, this.currentIndex = 3, this.onTap});

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    // Create animation controllers for each tab
    _animationControllers = List.generate(
      5,
      (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
      ),
    );
    _scaleAnimations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    }).toList();
    _fadeAnimations = _animationControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    }).toList();

    // Start animation for initial selected tab
    if (widget.currentIndex < 5) {
      _animationControllers[widget.currentIndex].forward();
    }
  }

  @override
  void didUpdateWidget(CustomBottomNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      // Reverse previous tab animation
      if (oldWidget.currentIndex < 5) {
        _animationControllers[oldWidget.currentIndex].reverse();
      }
      // Forward new tab animation
      if (widget.currentIndex < 5) {
        _animationControllers[widget.currentIndex].reset();
        _animationControllers[widget.currentIndex].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F0), // Light beige/off-white
        borderRadius: BorderRadius.circular(70),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              Image.asset('assets/icons/home.png', width: 24, height: 24),
              0,
              'Home',
            ),
            _buildNavItem(
              Image.asset('assets/icons/search.png', width: 24, height: 24),
              1,
              'Search',
            ),
            _buildNavItem(
              Image.asset('assets/icons/fi-rr-bid.png', width: 24, height: 24),
              2,
              'Tools',
            ),
            _buildBookingNavItem(3, badge: '01'),
            _buildNavItem(
              Image.asset('assets/icons/more.png', width: 24, height: 24),
              4,
              'More',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(Widget icon, int index, String label) {
    final isSelected = index == widget.currentIndex;

    if (isSelected) {
      return AnimatedBuilder(
        animation: _animationControllers[index],
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimations[index].value,
            child: Transform.scale(
              scale: _scaleAnimations[index].value,
              child: GestureDetector(
                onTap: () => widget.onTap?.call(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple[700]!, Colors.blue[400]!],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon,
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return GestureDetector(
        onTap: () => widget.onTap?.call(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: _GradientIcon(icon: icon, size: 24, isSelected: isSelected),
        ),
      );
    }
  }

  Widget _buildBookingNavItem(int index, {String? badge}) {
    final isSelected = index == widget.currentIndex;

    if (isSelected) {
      return AnimatedBuilder(
        animation: _animationControllers[index],
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimations[index].value,
            child: Transform.scale(
              scale: _scaleAnimations[index].value,
              child: GestureDetector(
                onTap: () => widget.onTap?.call(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF7464E4),
                        // Colors.purple[700]!,
                        Color(0xFF3354F4),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Calendar + Shopping cart icon
                      Stack(
                        children: [
                          // const Icon(
                          //   Icons.calendar_today,
                          //   color: Colors.white,
                          //   size: 20,
                          // ),
                          Image.asset(
                            'assets/icons/booking.png',
                            width: 24,
                            height: 24,
                          ),
                          // Positioned(
                          //   right: -4,
                          //   bottom: -4,
                          //   child: Container(
                          //     padding: const EdgeInsets.all(1),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: Icon(
                          //       Icons.shopping_cart,
                          //       color: Colors.purple[700],
                          //       size: 8,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Booking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            // decoration: BoxDecoration(
                            //   gradient: LinearGradient(
                            //     colors: [
                            //       Colors.purple[700]!,
                            //       Colors.blue[400]!,
                            //     ],
                            //   ),
                            //shape: BoxShape.circle,
                            //),
                            child: Text(
                              badge,
                              style: const TextStyle(
                                color: Color(0xFF3354F4),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      return GestureDetector(
        onTap: () => widget.onTap?.call(index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          // child: _GradientIcon(
          //   icon: Icons.calendar_today_outlined,
          //   size: 24,
          //   isSelected: false,
          // ),
          child: Icon(Icons.calendar_today_outlined, size: 24),
        ),
      );
    }
  }
}

/// Widget for gradient outline icons
class _GradientIcon extends StatelessWidget {
  final Widget icon;
  final double size;
  final bool isSelected;

  const _GradientIcon({
    required this.icon,
    required this.size,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [Colors.purple[700]!, Colors.blue[400]!],
        ).createShader(bounds);
      },
      // child: Icon(
      //   icon as IconData,
      //   size: size,
      //   color: Colors.white, // This will be replaced by the gradient
      // ),
      child: icon,
    );
  }
}
