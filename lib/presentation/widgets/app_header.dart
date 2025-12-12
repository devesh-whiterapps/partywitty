import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Header widget with logo, location, and notifications
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Row(
        children: [
          // Logo
          // _buildLogo(),
          //   Image.asset('assets/logo/logs.png', width: 40, height: 40),
          SvgPicture.asset('assets/logo/logo.svg', width: 40, height: 40),
          const SizedBox(width: 12),
          // Location selector
          _buildLocationSelector(),
          Spacer(),
          // Notification icon
          // IconButton(
          //   icon: const Icon(Icons.notifications_outlined),
          //   onPressed: () {},
          // ),
          // Image.asset('assets/icons/notification.png', width: 44, height: 45),
          // const SizedBox(width: 12),
          // Image.asset(
          //   'assets/icons/scanner.png',
          //   width: 44,
          //   height: 45,
          //   //color: Color(0xffffffff).withOpacity(0.5),
          // ),
          Container(
            width: 44,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            decoration: BoxDecoration(
              // color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            // child: Image.asset(
            //   'assets/icons/notification_new.png',
            //   width: 40,
            //   height: 41,
            //   color: Colors.black.withOpacity(0.8),
            // ),
            child: SvgPicture.asset(
              'assets/icons/bell.svg',
              width: 26,
              height: 26,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            // child: Image.asset(
            //   'assets/icons/qr_new.png',
            //   width: 40,
            //   height: 41,
            //   color: Colors.black.withOpacity(0.8),
            //   //color: Color(0xffffffff).withOpacity(0.5),
            // ),
            child: SvgPicture.asset(
              'assets/icons/scan.svg',
              width: 25,
              height: 27,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          // Green square
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Yellow triangle
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(topRight: Radius.circular(2)),
              ),
            ),
          ),
          // Blue circle
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          // White X
          Center(
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'X',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Container(
          // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xffffffff).withOpacity(0.55),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 20,
                color: Color(0xff4f4f4f),
              ),
              const Text(
                'Vasant Kunj',
                style: TextStyle(fontSize: 13, color: Color(0xff4f4f4f)),
              ),
              //const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Color(0xff4f4f4f),
              ),
            ],
          ),
        ),
        const Text(
          'Asant Kunj Comes Under ..',
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
