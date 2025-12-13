import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_txt/gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:partywitty/presentation/screens/booking_screen.dart';

class MenuScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const MenuScreen({super.key, this.onBack});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isSwitched = false;
  bool _showAccountList = false;
  int _selectedAccountIndex = 0;
  bool _showOptions = true;
  // Sample account data
  final List<Map<String, dynamic>> accounts = [
    {
      'name': 'Zeeshan Ahmad',
      'phone': '91-958 297 4280',
      'company': 'Indus Global Pvt Ltd',
      'role': 'Corporate',
      'image': 'assets/images/image1.png',
    },
    {
      'name': 'Zeeshan Ahmad',
      'phone': '91-958 297 4280',
      'company': 'Rapper',
      'role': 'Artist',
      'image': 'assets/images/image1.png',
    },
    {
      'name': 'Zeeshan Ahmad',
      'phone': '91-958 297 4280',
      'company': 'Global Foods',
      'role': 'Caterer',
      'image': 'assets/images/image1.png',
    },
    {
      'name': 'Zeeshan Ahmad',
      'phone': '91-958 297 4280',
      'company': 'Lifestyle',
      'role': 'Influencer',
      'image': 'assets/images/image1.png',
    },
    {
      'name': 'Zeeshan Ahmad',
      'phone': '91-958 297 4280',
      'company': 'Stage ur Music',
      'role': 'Event Organizer',
      'image': 'assets/images/image1.png',
    },
  ];

  // ignore: unused_element
  void _showAccountSwitcher() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF5D50B6), Color(0xFF2943C3)],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Indus Global',
                              style: GoogleFonts.lexend(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            Text(
                              'UI UX Designer',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Switch Account',
                              style: GoogleFonts.lexend(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 9,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Account list
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: accounts.length,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (context, index) {
                        final account = accounts[index];
                        final isSelected = _selectedAccountIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setModalState(() {
                              _selectedAccountIndex = index;
                            });
                            setState(() {
                              _selectedAccountIndex = index;
                            });
                            // Close bottom sheet after selection
                            Future.delayed(Duration(milliseconds: 300), () {
                              Navigator.pop(context);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0xffE0E0E0),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Profile image
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset(
                                      account['image'],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(Icons.person, size: 30);
                                          },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                // Account details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            account['name'],
                                            style: GoogleFonts.lexend(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff1C1B1D),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getRoleColor(
                                                account['role'],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              account['role'],
                                              style: GoogleFonts.lexend(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        account['phone'],
                                        style: GoogleFonts.lexend(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff4F4F4F),
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(0xffE0E0E0),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          account['company'],
                                          style: GoogleFonts.lexend(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff4F4F4F),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Selection indicator
                                if (isSelected)
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF5D50B6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Corporate':
        return Color(0xFF5D50B6);
      case 'Artist':
        return Color(0xFF8B5CF6);
      case 'Caterer':
        return Color(0xFF4F46E5);
      case 'Influencer':
        return Color(0xFF6366F1);
      case 'Event Organizer':
        return Color(0xFF7C3AED);
      default:
        return Color(0xFF5D50B6);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF).withValues(alpha: 0.6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
          child: Stack(
            children: [
              // Main content that's always visible
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              if (widget.onBack != null) {
                                widget.onBack!();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingScreen(),
                                  ),
                                );
                              }
                            },
                            child: Image.asset(
                              'assets/icons/arrow_back.png',
                              width: 16,
                              height: 13,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 380,
                          padding: const EdgeInsets.only(top: 15),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff7464E4).withOpacity(0.1),
                                Color(0xffB5A78B).withOpacity(0.08),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.centerRight,
                            ),
                            border: Border.all(
                              color: Color(0xffEDEDED),
                              width: 0.5,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(155),
                                              ),
                                              child: Image.asset(
                                                'assets/images/image1.png',
                                                width: 80,
                                                height: 80,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'John Doe',
                                                  style: GoogleFonts.lexend(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff1C1B1D),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  '91-958 297 4280',
                                                  style: GoogleFonts.lexend(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xff4F4F4F),
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Color(
                                                      0xff000000,
                                                    ).withValues(alpha: 0.89),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          100,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    'Join Crown membership',
                                                    style: GoogleFonts.lexend(
                                                      fontSize: 12,
                                                      color: Color(0xffB7986C),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF5D50B6),
                                          Color(0xFF2943C3),
                                        ],
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Indus Global',
                                                style: GoogleFonts.lexend(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                              ),
                                              Text(
                                                'UI UX Designer',
                                                style: GoogleFonts.lexend(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _showAccountList =
                                                  !_showAccountList;
                                            });
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Switch Account',
                                                  style: GoogleFonts.lexend(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xffFFFFFF),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 9,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 10,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    showProfileBottomOverlay(context);
                                  },
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    padding: EdgeInsets.all(5),
                                    child: SvgPicture.asset(
                                      'assets/icons/edit.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Main menu - always visible
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 2,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Color(0xff4F4F4F),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'MAIN MENU',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: Color(0xff4F4F4F),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14),
                        menuwidgets(
                          SvgPicture.asset(
                            'assets/icons/turn.svg',
                            height: 20,
                            width: 20,
                          ),
                          'My Plan',
                        ),
                        SizedBox(height: 14),
                        menuwidgets(
                          SvgPicture.asset(
                            'assets/icons/chat.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Chat Room',
                        ),
                        SizedBox(height: 14),
                        menuwidgets(
                          SvgPicture.asset(
                            'assets/icons/notification.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Notification',
                        ),
                        SizedBox(height: 14),
                        menuwidgets(
                          SvgPicture.asset(
                            'assets/icons/like.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Save & Like',
                        ),
                        SizedBox(height: 14),
                        menuwidgets(
                          SvgPicture.asset(
                            'assets/icons/champ.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Rewards',
                        ),
                        SizedBox(height: 14),
                        menuwidgets(
                          SvgPicture.asset(
                            'assets/icons/location_plus.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Select Location',
                        ),
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 2,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Color(0xff4F4F4F),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            SizedBox(width: 14),
                            Text(
                              'SUPPORTIVE PAGE    ',
                              style: GoogleFonts.lexend(
                                fontSize: 12,
                                color: Color(0xff4F4F4F),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  // child: SvgPicture.asset(
                                  //   'assets/icons/turn.svg',
                                  //   height: 20,
                                  //   width: 20,
                                  // ),
                                  child: SvgPicture.asset(
                                    'assets/icons/dark_mode.svg',
                                  ),
                                ),
                                SizedBox(width: 10),
                                // Text(
                                //   // 'My Plan',
                                //   text,
                                //   style: GoogleFonts.lexend(
                                //     fontSize: 16,
                                //     color: Color(0xff4F4F4F),
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                GradientText(
                                  text: 'Dark Mode',
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF5D50B6),
                                      Color(0xFF2943C3),
                                    ],
                                  ),
                                  style: GoogleFonts.lexend(
                                    fontSize: 16,
                                    // color: Color(0xff4F4F4F),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            // Switch(
                            //   value: _isSwitched,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       _isSwitched = value;
                            //     });
                            //   },
                            //   activeColor: Colors.blue, // Custom colors
                            //   activeTrackColor: Colors.blue.shade200,
                            //   // inactiveThumbImage: AssetImage(
                            //   //   'assets/icons/switch.png',
                            //   // ),
                            //   inactiveThumbColor: Color(0xff4F4F4F),
                            //   inactiveTrackColor: Color(0xffA09E9E),
                            // ),
                            CustomToggleSwitch(
                              value: _isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 14),
                        menuwidgets(
                          SvgPicture.asset(
                            'assets/icons/power.svg',
                            height: 20,
                            width: 20,
                          ),
                          'Logout',
                        ),
                      ],
                    ),
                  ),
                  //  Spacer(),
                  Spacer(),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset('assets/images/hamburger.png'),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'v2.1.4',
                          style: GoogleFonts.lexend(
                            fontSize: 16,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              // Account list overlay - positioned above main menu
              if (_showAccountList)
                Positioned(
                  left: 0,
                  right: 0,
                  top:
                      183, // Adjust this value to position it right after the profile card
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(
                        0xffFFFFFF,
                      ).withOpacity(0.95), // Semi-transparent background
                      border: Border.all(color: Color(0xffDCDCDC)),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: accounts.length,
                      padding: EdgeInsets.symmetric(
                        vertical: 9,
                        horizontal: 10,
                      ),
                      itemBuilder: (context, index) {
                        final account = accounts[index];
                        final isSelected = _selectedAccountIndex == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _showAccountList = !_showAccountList;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.asset(
                                      account['image'],
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(Icons.person, size: 25);
                                          },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            account['name'],
                                            style: GoogleFonts.lexend(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff1C1B1D),
                                            ),
                                          ),
                                          SizedBox(width: 6),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 3,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF5D50B6),
                                                  Color(0xFF2943C3),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              account['role'],
                                              style: GoogleFonts.lexend(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        account['phone'],
                                        style: GoogleFonts.lexend(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4F4F4F),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Color(
                                            0xffDDDDDD,
                                          ).withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                        child: Text(
                                          account['company'],
                                          style: GoogleFonts.lexend(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff4F4F4F),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    width: 26,
                                    height: 26,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF5D50B6),
                                          Color.fromARGB(231, 47, 74, 207),
                                        ],
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xffFFFFFF).withValues(alpha: 0.6),
  //     body: SafeArea(
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
  //         child: Column(
  //           children: [
  //             // AppBar(
  //             //   backgroundColor: Colors.transparent,
  //             //   elevation: 0,
  //             //   leading: IconButton(
  //             //     icon: Image.asset(
  //             //       'assets/icons/arrow_back.png',
  //             //       width: 16,
  //             //       height: 13,
  //             //     ),
  //             //     onPressed: () => Navigator.of(context).pop(),
  //             //   ),
  //             //   titleSpacing: -10,
  //             //   // title: Text(
  //             //   //   'Transaction History',
  //             //   //   // style: GoogleFonts.lexend(
  //             //   //   //   color: Color(0xff070707),
  //             //   //   //   fontSize: 18,
  //             //   //   //   fontWeight: FontWeight.w500,
  //             //   //   // ),
  //             //   // ),
  //             //   // centerTitle: false,
  //             //   // actions: [
  //             //   //   Padding(
  //             //   //     padding: const EdgeInsets.only(right: 16.0),
  //             //   //     child: Container(
  //             //   //       width: 38,
  //             //   //       height: 38,
  //             //   //       padding: const EdgeInsets.symmetric(
  //             //   //         horizontal: 10,
  //             //   //         vertical: 7,
  //             //   //       ),
  //             //   //       decoration: BoxDecoration(
  //             //   //         border: Border.all(
  //             //   //           color: Color(0xffECECE9),
  //             //   //           width: 0.5,
  //             //   //         ),
  //             //   //         borderRadius: BorderRadius.circular(4),
  //             //   //         color: Color(0xffFFFFFF).withOpacity(0.5),
  //             //   //       ),
  //             //   //       child: SvgPicture.asset(
  //             //   //         'assets/icons/search.svg',
  //             //   //         width: 24,
  //             //   //         height: 24,
  //             //   //         color: Color(0xff4F4F4F),
  //             //   //       ),
  //             //   //     ),
  //             //   //   ),
  //             //   // ],
  //             // ),
  //             Container(
  //               width: double.infinity,
  //               // height: 218,
  //               decoration: BoxDecoration(
  //                 //  color: Colors.white,
  //                 //  borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Container(
  //                     // child: IconButton(
  //                     //   icon: Image.asset(
  //                     //     'assets/icons/arrow_back.png',
  //                     //     width: 16,
  //                     //     height: 13,
  //                     //   ),
  //                     //   onPressed: () => Navigator.of(context).pop(),
  //                     // ),
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         if (widget.onBack != null) {
  //                           widget.onBack!();
  //                         } else {
  //                           Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder: (context) => BookingScreen(),
  //                             ),
  //                           );
  //                         }
  //                       },
  //                       child: Image.asset(
  //                         'assets/icons/arrow_back.png',
  //                         width: 16,
  //                         height: 13,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 10),

  //                   Container(
  //                     // height: 175,
  //                     width: 380,
  //                     padding: const EdgeInsets.only(top: 15),
  //                     decoration: BoxDecoration(
  //                       //  color: Colors.white,
  //                       // borderRadius: BorderRadius.circular(10),
  //                       gradient: LinearGradient(
  //                         colors: [
  //                           Color(0xff7464E4).withOpacity(0.1),
  //                           Color(0xffB5A78B).withOpacity(0.08),
  //                           // Color(0xffffffff).withOpacity(0.1),
  //                           // Color(0xffffffff),

  //                           //  Color(0xff7464E4).withValues(alpha: 0.2),
  //                         ],
  //                         begin: Alignment.topLeft,
  //                         end: Alignment.centerRight,
  //                       ),
  //                       border: Border.all(
  //                         color: Color(0xffEDEDED),
  //                         width: 0.5,
  //                       ),
  //                     ),
  //                     child: Stack(
  //                       children: [
  //                         Column(
  //                           children: [
  //                             Row(
  //                               children: [
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                     left: 10,
  //                                     right: 10,
  //                                   ),
  //                                   child: Row(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Container(
  //                                         width: 80,
  //                                         height: 80,
  //                                         decoration: BoxDecoration(
  //                                           color: Colors.white,
  //                                           borderRadius: BorderRadius.circular(
  //                                             155,
  //                                           ),
  //                                         ),
  //                                         // child: SvgPicture.asset(
  //                                         //   'assets/images/image1.svg',
  //                                         //   width: 80,
  //                                         //   height: 80,
  //                                         // ),
  //                                         child: Image.asset(
  //                                           'assets/images/image1.png',
  //                                           width: 80,
  //                                           height: 80,
  //                                         ),
  //                                       ),
  //                                       SizedBox(width: 8),
  //                                       Column(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Text(
  //                                             'John Doe',
  //                                             style: GoogleFonts.lexend(
  //                                               fontSize: 16,
  //                                               fontWeight: FontWeight.w500,
  //                                               color: Color(0xff1C1B1D),
  //                                             ),
  //                                           ),
  //                                           SizedBox(height: 8),
  //                                           Text(
  //                                             '91-958 297 4280',
  //                                             style: GoogleFonts.lexend(
  //                                               fontSize: 13,
  //                                               fontWeight: FontWeight.w500,
  //                                               color: Color(0xff4F4F4F),
  //                                             ),
  //                                           ),
  //                                           SizedBox(height: 10),
  //                                           Container(
  //                                             padding:
  //                                                 const EdgeInsets.symmetric(
  //                                                   horizontal: 10,
  //                                                   vertical: 4,
  //                                                 ),
  //                                             decoration: BoxDecoration(
  //                                               color: Color(
  //                                                 0xff000000,
  //                                               ).withValues(alpha: 0.89),
  //                                               borderRadius:
  //                                                   BorderRadius.circular(100),
  //                                             ),
  //                                             child: Text(
  //                                               'Join Crown membership',
  //                                               style: GoogleFonts.lexend(
  //                                                 fontSize: 12,
  //                                                 color: Color(0xffB7986C),
  //                                                 fontWeight: FontWeight.w400,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(height: 8),
  //                             Container(
  //                               //   height: 59,
  //                               width: double.infinity,
  //                               padding: EdgeInsets.symmetric(
  //                                 horizontal: 10,
  //                                 vertical: 6,
  //                               ),
  //                               decoration: BoxDecoration(
  //                                 gradient: LinearGradient(
  //                                   colors: [
  //                                     // Color(0xff7464E4),
  //                                     // Color(0xff3354F4),
  //                                     Color(0xFF5D50B6), // Same as booking tab
  //                                     Color(0xFF2943C3),
  //                                   ],
  //                                 ),
  //                               ),
  //                               child: Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                                   Container(
  //                                     // height: 36,
  //                                     child: Column(
  //                                       crossAxisAlignment:
  //                                           CrossAxisAlignment.start,
  //                                       children: [
  //                                         Text(
  //                                           'Indus Global',
  //                                           style: GoogleFonts.lexend(
  //                                             fontSize: 16,
  //                                             fontWeight: FontWeight.w400,
  //                                             color: Color(0xffFFFFFF),
  //                                           ),
  //                                         ),
  //                                         Text(
  //                                           'UI UX Designer',
  //                                           style: GoogleFonts.lexend(
  //                                             fontSize: 12,
  //                                             fontWeight: FontWeight.w400,
  //                                             color: Color(0xffFFFFFF),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       setState(() {
  //                                         _showAccountList = !_showAccountList;
  //                                         _showOptions = !_showOptions;
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                       child: Row(
  //                                         children: [
  //                                           Text(
  //                                             'Switch Account',
  //                                             style: GoogleFonts.lexend(
  //                                               fontSize: 14,
  //                                               fontWeight: FontWeight.w500,
  //                                               color: Color(0xffFFFFFF),
  //                                             ),
  //                                           ),
  //                                           SizedBox(width: 5),
  //                                           Icon(
  //                                             Icons.arrow_forward_ios,
  //                                             size: 9,

  //                                             color: Colors.white,
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),

  //                         Positioned(
  //                           right: 10,
  //                           top: 0,
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               showProfileBottomOverlay(context);
  //                             },
  //                             child: Container(
  //                               width: 28,
  //                               height: 28,
  //                               padding: EdgeInsets.all(5),
  //                               child: SvgPicture.asset(
  //                                 'assets/icons/edit.svg',
  //                                 width: 15,
  //                                 height: 15,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),

  //                   // Account List Dropdown
  //                   if (_showAccountList)
  //                     Container(
  //                       width: double.infinity,
  //                       decoration: BoxDecoration(
  //                         // color: Color(0xffffffff).withOpacity(0.3),
  //                         // boxShadow: [
  //                         //   BoxShadow(
  //                         //     color: Color(0xffDCDCDC),
  //                         //     blurRadius: 10,
  //                         //     offset: Offset(0, 5),
  //                         //   ),
  //                         // ],
  //                         border: Border.all(color: Color(0xffDCDCDC)),
  //                       ),
  //                       child: ListView.builder(
  //                         shrinkWrap: true,
  //                         physics: NeverScrollableScrollPhysics(),
  //                         itemCount: accounts.length,
  //                         padding: EdgeInsets.symmetric(vertical: 9),
  //                         itemBuilder: (context, index) {
  //                           final account = accounts[index];
  //                           final isSelected = _selectedAccountIndex == index;

  //                           return Container(
  //                             // margin: EdgeInsets.symmetric(
  //                             //   horizontal: 12,
  //                             //   vertical: 2,
  //                             // ),
  //                             padding: EdgeInsets.all(10),
  //                             decoration: BoxDecoration(
  //                               //color: Colors.white,
  //                               // border: Border.all(
  //                               //   color: Color(0xffE0E0E0),
  //                               //   width: 1,
  //                               // ),
  //                               // borderRadius: BorderRadius.circular(
  //                               //   8,
  //                               // ),
  //                             ),
  //                             child: Row(
  //                               children: [
  //                                 // Profile image
  //                                 Container(
  //                                   width: 50,
  //                                   height: 50,
  //                                   decoration: BoxDecoration(
  //                                     //   color: Colors.grey[200],
  //                                     borderRadius: BorderRadius.circular(25),
  //                                   ),
  //                                   child: ClipRRect(
  //                                     borderRadius: BorderRadius.circular(25),
  //                                     child: Image.asset(
  //                                       account['image'],
  //                                       fit: BoxFit.cover,
  //                                       errorBuilder:
  //                                           (context, error, stackTrace) {
  //                                             return Icon(
  //                                               Icons.person,
  //                                               size: 25,
  //                                             );
  //                                           },
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(width: 10),
  //                                 // Account details
  //                                 Expanded(
  //                                   child: Column(
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Row(
  //                                         children: [
  //                                           Text(
  //                                             account['name'],
  //                                             style: GoogleFonts.lexend(
  //                                               fontSize: 16,
  //                                               fontWeight: FontWeight.w400,
  //                                               color: Color(0xff1C1B1D),
  //                                             ),
  //                                           ),
  //                                           SizedBox(width: 6),
  //                                           Container(
  //                                             padding: EdgeInsets.symmetric(
  //                                               horizontal: 10,
  //                                               vertical: 3,
  //                                             ),
  //                                             decoration: BoxDecoration(
  //                                               // color: _getRoleColor(
  //                                               //   account['role'],
  //                                               // ),
  //                                               gradient: LinearGradient(
  //                                                 colors: [
  //                                                   Color(
  //                                                     0xFF5D50B6,
  //                                                   ), // Same as booking tab
  //                                                   Color(0xFF2943C3),
  //                                                 ],
  //                                               ),
  //                                               borderRadius:
  //                                                   BorderRadius.circular(10),
  //                                             ),
  //                                             child: Text(
  //                                               account['role'],
  //                                               style: GoogleFonts.lexend(
  //                                                 fontSize: 10,
  //                                                 fontWeight: FontWeight.w400,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ],
  //                                       ),
  //                                       SizedBox(height: 3),
  //                                       Text(
  //                                         account['phone'],
  //                                         style: GoogleFonts.lexend(
  //                                           fontSize: 14,
  //                                           fontWeight: FontWeight.w500,
  //                                           color: Color(0xff4F4F4F),
  //                                         ),
  //                                       ),
  //                                       SizedBox(height: 3),
  //                                       Container(
  //                                         padding: EdgeInsets.symmetric(
  //                                           horizontal: 10,
  //                                           vertical: 4,
  //                                         ),
  //                                         decoration: BoxDecoration(
  //                                           color: Color(
  //                                             0xffDDDDDD,
  //                                           ).withOpacity(0.8),
  //                                           borderRadius: BorderRadius.circular(
  //                                             100,
  //                                           ),
  //                                         ),
  //                                         child: Text(
  //                                           account['company'],
  //                                           style: GoogleFonts.lexend(
  //                                             fontSize: 12,
  //                                             fontWeight: FontWeight.w500,
  //                                             color: Color(0xff4F4F4F),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 // Selection indicator
  //                                 if (isSelected)
  //                                   Container(
  //                                     width: 26,
  //                                     height: 26,
  //                                     padding: EdgeInsets.all(3),
  //                                     decoration: BoxDecoration(
  //                                       color: Color(0xFF5D50B6),
  //                                       gradient: LinearGradient(
  //                                         colors: [
  //                                           Color(
  //                                             0xFF5D50B6,
  //                                           ), // Same as booking tab
  //                                           Color.fromARGB(231, 47, 74, 207),
  //                                           // Color(
  //                                           //   0xff000000,
  //                                           // ).withOpacity(0.2),
  //                                         ],
  //                                       ),
  //                                       shape: BoxShape.circle,
  //                                     ),
  //                                     child: Icon(
  //                                       Icons.check,
  //                                       color: Colors.white,
  //                                       size: 20,
  //                                     ),
  //                                   ),
  //                               ],
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                 ],
  //               ),
  //             ),

  //             if (_showOptions)
  //               Container(
  //                 padding: EdgeInsets.symmetric(vertical: 15),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   children: [
  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         // VerticalDivider(
  //                         //   thickness: 2,
  //                         //   radius: BorderRadius.circular(12),
  //                         //   color: Color(0xff4F4F4F),
  //                         // ),
  //                         Container(
  //                           width: 2,
  //                           height: 18,
  //                           decoration: BoxDecoration(
  //                             color: Color(0xff4F4F4F),
  //                             borderRadius: BorderRadius.circular(12),
  //                           ),
  //                         ),
  //                         SizedBox(width: 12),
  //                         Text(
  //                           'MAIN MENU',
  //                           style: GoogleFonts.lexend(
  //                             fontSize: 12,
  //                             color: Color(0xff4F4F4F),
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 14),

  //                     // Row(
  //                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     //   children: [
  //                     //     Row(
  //                     //       children: [
  //                     //         Container(
  //                     //           height: 20,
  //                     //           width: 20,
  //                     //           child: SvgPicture.asset(
  //                     //             'assets/icons/turn.svg',
  //                     //             height: 20,
  //                     //             width: 20,
  //                     //           ),
  //                     //         ),
  //                     //         SizedBox(width: 10),
  //                     //         Text(
  //                     //           'My Plan',
  //                     //           style: GoogleFonts.lexend(
  //                     //             fontSize: 16,
  //                     //             color: Color(0xff4F4F4F),
  //                     //             fontWeight: FontWeight.w500,
  //                     //           ),
  //                     //         ),
  //                     //       ],
  //                     //     ),
  //                     //     Icon(
  //                     //       Icons.arrow_forward_ios,
  //                     //       size: 10,

  //                     //       color: Color(0xff7464E4),
  //                     //     ),
  //                     //   ],
  //                     // ),
  //                     menuwidgets(
  //                       SvgPicture.asset(
  //                         'assets/icons/turn.svg',
  //                         height: 20,
  //                         width: 20,
  //                       ),
  //                       'My Plan',
  //                     ),
  //                     SizedBox(height: 14),
  //                     menuwidgets(
  //                       SvgPicture.asset(
  //                         'assets/icons/chat.svg',
  //                         height: 20,
  //                         width: 20,
  //                       ),
  //                       'Chat Room',
  //                     ),
  //                     SizedBox(height: 14),
  //                     menuwidgets(
  //                       SvgPicture.asset(
  //                         'assets/icons/notification.svg',
  //                         height: 20,
  //                         width: 20,
  //                       ),
  //                       'Notification',
  //                     ),
  //                     SizedBox(height: 14),
  //                     menuwidgets(
  //                       SvgPicture.asset(
  //                         'assets/icons/like.svg',
  //                         height: 20,
  //                         width: 20,
  //                       ),
  //                       'Save & Like',
  //                     ),
  //                     SizedBox(height: 14),
  //                     menuwidgets(
  //                       SvgPicture.asset(
  //                         'assets/icons/champ.svg',
  //                         height: 20,
  //                         width: 20,
  //                       ),
  //                       'Rewards',
  //                     ),
  //                     SizedBox(height: 14),
  //                     menuwidgets(
  //                       SvgPicture.asset(
  //                         'assets/icons/location_plus.svg',
  //                         height: 20,
  //                         width: 20,
  //                       ),
  //                       'Select Location',
  //                     ),
  //                     SizedBox(height: 15),

  //                     Row(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         // VerticalDivider(
  //                         //   thickness: 2,
  //                         //   radius: BorderRadius.circular(12),
  //                         //   color: Color(0xff4F4F4F),
  //                         // ),
  //                         Container(
  //                           width: 2,
  //                           height: 18,
  //                           decoration: BoxDecoration(
  //                             color: Color(0xff4F4F4F),
  //                             borderRadius: BorderRadius.circular(12),
  //                           ),
  //                         ),
  //                         SizedBox(width: 14),
  //                         Text(
  //                           'SUPPORTIVE PAGE    ',
  //                           style: GoogleFonts.lexend(
  //                             fontSize: 12,
  //                             color: Color(0xff4F4F4F),
  //                             fontWeight: FontWeight.w500,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     SizedBox(height: 15),
  //                     // menuwidgets(
  //                     //   SvgPicture.asset(
  //                     //     'assets/icons/turn.svg',
  //                     //     height: 20,
  //                     //     width: 20,
  //                     //   ),
  //                     //   'Dark Mode',
  //                     // ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Container(
  //                               height: 20,
  //                               width: 20,
  //                               // child: SvgPicture.asset(
  //                               //   'assets/icons/turn.svg',
  //                               //   height: 20,
  //                               //   width: 20,
  //                               // ),
  //                               child: SvgPicture.asset(
  //                                 'assets/icons/dark_mode.svg',
  //                               ),
  //                             ),
  //                             SizedBox(width: 10),
  //                             // Text(
  //                             //   // 'My Plan',
  //                             //   text,
  //                             //   style: GoogleFonts.lexend(
  //                             //     fontSize: 16,
  //                             //     color: Color(0xff4F4F4F),
  //                             //     fontWeight: FontWeight.w500,
  //                             //   ),
  //                             // ),
  //                             GradientText(
  //                               text: 'Dark Mode',
  //                               gradient: LinearGradient(
  //                                 colors: [
  //                                   Color(0xFF5D50B6),
  //                                   Color(0xFF2943C3),
  //                                 ],
  //                               ),
  //                               style: GoogleFonts.lexend(
  //                                 fontSize: 16,
  //                                 // color: Color(0xff4F4F4F),
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         // Switch(
  //                         //   value: _isSwitched,
  //                         //   onChanged: (value) {
  //                         //     setState(() {
  //                         //       _isSwitched = value;
  //                         //     });
  //                         //   },
  //                         //   activeColor: Colors.blue, // Custom colors
  //                         //   activeTrackColor: Colors.blue.shade200,
  //                         //   // inactiveThumbImage: AssetImage(
  //                         //   //   'assets/icons/switch.png',
  //                         //   // ),
  //                         //   inactiveThumbColor: Color(0xff4F4F4F),
  //                         //   inactiveTrackColor: Color(0xffA09E9E),
  //                         // ),
  //                         CustomToggleSwitch(
  //                           value: _isSwitched,
  //                           onChanged: (value) {
  //                             setState(() {
  //                               _isSwitched = value;
  //                             });
  //                           },
  //                         ),
  //                       ],
  //                     ),

  //                     SizedBox(height: 14),
  //                     menuwidgets(
  //                       SvgPicture.asset(
  //                         'assets/icons/power.svg',
  //                         height: 20,
  //                         width: 20,
  //                       ),
  //                       'Logout',
  //                     ),

  //                     //   Spacer(),
  //                   ],
  //                 ),
  //               ),
  //             Spacer(),
  //             Container(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     padding: EdgeInsets.symmetric(horizontal: 1),
  //                     decoration: BoxDecoration(
  //                       color: Colors.black,
  //                       borderRadius: BorderRadius.circular(4),
  //                     ),
  //                     child: Image.asset('assets/images/hamburger.png'),
  //                   ),
  //                   // SvgPicture.asset('assets/images/hamburger.svg'),
  //                   SizedBox(width: 10),
  //                   Text(
  //                     'v2.1.4',
  //                     style: GoogleFonts.lexend(
  //                       fontSize: 16,
  //                       color: Color(0xff000000),
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 15),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Color(0xffFFFFFF).withValues(alpha: 0.6),
  //     body: SafeArea(
  //       child: Stack(
  //         children: [
  //           // Main content
  //           Padding(
  //             padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   width: double.infinity,
  //                   decoration: BoxDecoration(),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         child: GestureDetector(
  //                           onTap: () {
  //                             if (widget.onBack != null) {
  //                               widget.onBack!();
  //                             } else {
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder: (context) => BookingScreen(),
  //                                 ),
  //                               );
  //                             }
  //                           },
  //                           child: Image.asset(
  //                             'assets/icons/arrow_back.png',
  //                             width: 16,
  //                             height: 13,
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Container(
  //                         width: 380,
  //                         padding: const EdgeInsets.only(top: 15),
  //                         decoration: BoxDecoration(
  //                           gradient: LinearGradient(
  //                             colors: [
  //                               Color(0xff7464E4).withOpacity(0.1),
  //                               Color(0xffB5A78B).withOpacity(0.08),
  //                             ],
  //                             begin: Alignment.topLeft,
  //                             end: Alignment.centerRight,
  //                           ),
  //                           border: Border.all(
  //                             color: Color(0xffEDEDED),
  //                             width: 0.5,
  //                           ),
  //                         ),
  //                         child: Stack(
  //                           children: [
  //                             Column(
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(
  //                                         left: 10,
  //                                         right: 10,
  //                                       ),
  //                                       child: Row(
  //                                         crossAxisAlignment:
  //                                             CrossAxisAlignment.start,
  //                                         children: [
  //                                           Container(
  //                                             width: 80,
  //                                             height: 80,
  //                                             decoration: BoxDecoration(
  //                                               color: Colors.white,
  //                                               borderRadius:
  //                                                   BorderRadius.circular(155),
  //                                             ),
  //                                             child: Image.asset(
  //                                               'assets/images/image1.png',
  //                                               width: 80,
  //                                               height: 80,
  //                                             ),
  //                                           ),
  //                                           SizedBox(width: 8),
  //                                           Column(
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               Text(
  //                                                 'John Doe',
  //                                                 style: GoogleFonts.lexend(
  //                                                   fontSize: 16,
  //                                                   fontWeight: FontWeight.w500,
  //                                                   color: Color(0xff1C1B1D),
  //                                                 ),
  //                                               ),
  //                                               SizedBox(height: 8),
  //                                               Text(
  //                                                 '91-958 297 4280',
  //                                                 style: GoogleFonts.lexend(
  //                                                   fontSize: 13,
  //                                                   fontWeight: FontWeight.w500,
  //                                                   color: Color(0xff4F4F4F),
  //                                                 ),
  //                                               ),
  //                                               SizedBox(height: 10),
  //                                               Container(
  //                                                 padding:
  //                                                     const EdgeInsets.symmetric(
  //                                                       horizontal: 10,
  //                                                       vertical: 4,
  //                                                     ),
  //                                                 decoration: BoxDecoration(
  //                                                   color: Color(
  //                                                     0xff000000,
  //                                                   ).withValues(alpha: 0.89),
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                         100,
  //                                                       ),
  //                                                 ),
  //                                                 child: Text(
  //                                                   'Join Crown membership',
  //                                                   style: GoogleFonts.lexend(
  //                                                     fontSize: 12,
  //                                                     color: Color(0xffB7986C),
  //                                                     fontWeight:
  //                                                         FontWeight.w400,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(height: 8),
  //                                 Container(
  //                                   width: double.infinity,
  //                                   padding: EdgeInsets.symmetric(
  //                                     horizontal: 10,
  //                                     vertical: 6,
  //                                   ),
  //                                   decoration: BoxDecoration(
  //                                     gradient: LinearGradient(
  //                                       colors: [
  //                                         Color(0xFF5D50B6),
  //                                         Color(0xFF2943C3),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   child: Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     children: [
  //                                       Container(
  //                                         child: Column(
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               'Indus Global',
  //                                               style: GoogleFonts.lexend(
  //                                                 fontSize: 16,
  //                                                 fontWeight: FontWeight.w400,
  //                                                 color: Color(0xffFFFFFF),
  //                                               ),
  //                                             ),
  //                                             Text(
  //                                               'UI UX Designer',
  //                                               style: GoogleFonts.lexend(
  //                                                 fontSize: 12,
  //                                                 fontWeight: FontWeight.w400,
  //                                                 color: Color(0xffFFFFFF),
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                       GestureDetector(
  //                                         onTap: () {
  //                                           setState(() {
  //                                             _showAccountList =
  //                                                 !_showAccountList;
  //                                           });
  //                                         },
  //                                         child: Container(
  //                                           child: Row(
  //                                             children: [
  //                                               Text(
  //                                                 'Switch Account',
  //                                                 style: GoogleFonts.lexend(
  //                                                   fontSize: 14,
  //                                                   fontWeight: FontWeight.w500,
  //                                                   color: Color(0xffFFFFFF),
  //                                                 ),
  //                                               ),
  //                                               SizedBox(width: 5),
  //                                               Icon(
  //                                                 Icons.arrow_forward_ios,
  //                                                 size: 9,
  //                                                 color: Colors.white,
  //                                               ),
  //                                             ],
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                             Positioned(
  //                               right: 10,
  //                               top: 0,
  //                               child: GestureDetector(
  //                                 onTap: () {
  //                                   showProfileBottomOverlay(context);
  //                                 },
  //                                 child: Container(
  //                                   width: 28,
  //                                   height: 28,
  //                                   padding: EdgeInsets.all(5),
  //                                   child: SvgPicture.asset(
  //                                     'assets/icons/edit.svg',
  //                                     width: 15,
  //                                     height: 15,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 if (_showOptions)
  //                   Container(
  //                     padding: EdgeInsets.symmetric(vertical: 15),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Container(
  //                               width: 2,
  //                               height: 18,
  //                               decoration: BoxDecoration(
  //                                 color: Color(0xff4F4F4F),
  //                                 borderRadius: BorderRadius.circular(12),
  //                               ),
  //                             ),
  //                             SizedBox(width: 12),
  //                             Text(
  //                               'MAIN MENU',
  //                               style: GoogleFonts.lexend(
  //                                 fontSize: 12,
  //                                 color: Color(0xff4F4F4F),
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 14),
  //                         menuwidgets(
  //                           SvgPicture.asset(
  //                             'assets/icons/turn.svg',
  //                             height: 20,
  //                             width: 20,
  //                           ),
  //                           'My Plan',
  //                         ),
  //                         SizedBox(height: 14),
  //                         menuwidgets(
  //                           SvgPicture.asset(
  //                             'assets/icons/chat.svg',
  //                             height: 20,
  //                             width: 20,
  //                           ),
  //                           'Chat Room',
  //                         ),
  //                         SizedBox(height: 14),
  //                         menuwidgets(
  //                           SvgPicture.asset(
  //                             'assets/icons/notification.svg',
  //                             height: 20,
  //                             width: 20,
  //                           ),
  //                           'Notification',
  //                         ),
  //                         SizedBox(height: 14),
  //                         menuwidgets(
  //                           SvgPicture.asset(
  //                             'assets/icons/like.svg',
  //                             height: 20,
  //                             width: 20,
  //                           ),
  //                           'Save & Like',
  //                         ),
  //                         SizedBox(height: 14),
  //                         menuwidgets(
  //                           SvgPicture.asset(
  //                             'assets/icons/champ.svg',
  //                             height: 20,
  //                             width: 20,
  //                           ),
  //                           'Rewards',
  //                         ),
  //                         SizedBox(height: 14),
  //                         menuwidgets(
  //                           SvgPicture.asset(
  //                             'assets/icons/location_plus.svg',
  //                             height: 20,
  //                             width: 20,
  //                           ),
  //                           'Select Location',
  //                         ),
  //                         SizedBox(height: 15),
  //                         Row(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Container(
  //                               width: 2,
  //                               height: 18,
  //                               decoration: BoxDecoration(
  //                                 color: Color(0xff4F4F4F),
  //                                 borderRadius: BorderRadius.circular(12),
  //                               ),
  //                             ),
  //                             SizedBox(width: 14),
  //                             Text(
  //                               'SUPPORTIVE PAGE    ',
  //                               style: GoogleFonts.lexend(
  //                                 fontSize: 12,
  //                                 color: Color(0xff4F4F4F),
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         SizedBox(height: 14),
  //                         menuwidgets(
  //                           SvgPicture.asset(
  //                             'assets/icons/power.svg',
  //                             height: 20,
  //                             width: 20,
  //                           ),
  //                           'Logout',
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 Spacer(),
  //                 Container(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         padding: EdgeInsets.symmetric(horizontal: 1),
  //                         decoration: BoxDecoration(
  //                           color: Colors.black,
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                         child: Image.asset('assets/images/hamburger.png'),
  //                       ),
  //                       SizedBox(width: 10),
  //                       Text(
  //                         'v2.1.4',
  //                         style: GoogleFonts.lexend(
  //                           fontSize: 16,
  //                           color: Color(0xff000000),
  //                           fontWeight: FontWeight.w600,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 15),
  //               ],
  //             ),
  //           ),

  //           // Account List Overlay - positioned exactly below the profile card
  //           if (_showAccountList)
  //             Positioned(
  //               left: 30,
  //               right: 30,
  //               top:
  //                   139, // Adjust this value based on your back button + profile card height
  //               child: GestureDetector(
  //                 onTap: () {}, // Prevents closing when tapping on the list
  //                 child: Container(
  //                   width: double.infinity,
  //                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
  //                   decoration: BoxDecoration(
  //                     color: Colors.white.withOpacity(0.95),
  //                     border: Border.all(color: Color(0xffDCDCDC)),
  //                   ),
  //                   child: ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: NeverScrollableScrollPhysics(),
  //                     itemCount: accounts.length,
  //                     itemBuilder: (context, index) {
  //                       final account = accounts[index];
  //                       final isSelected = _selectedAccountIndex == index;

  //                       return GestureDetector(
  //                         onTap: () {
  //                           setState(() {
  //                             _selectedAccountIndex = index;
  //                             _showAccountList = false;
  //                           });
  //                         },
  //                         child: Container(
  //                           padding: EdgeInsets.symmetric(vertical: 10),
  //                           child: Row(
  //                             children: [
  //                               Container(
  //                                 width: 50,
  //                                 height: 50,
  //                                 decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(25),
  //                                 ),
  //                                 child: ClipRRect(
  //                                   borderRadius: BorderRadius.circular(25),
  //                                   child: Image.asset(
  //                                     account['image'],
  //                                     fit: BoxFit.cover,
  //                                     errorBuilder:
  //                                         (context, error, stackTrace) {
  //                                           return Icon(Icons.person, size: 25);
  //                                         },
  //                                   ),
  //                                 ),
  //                               ),
  //                               SizedBox(width: 10),
  //                               Expanded(
  //                                 child: Column(
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   children: [
  //                                     Row(
  //                                       children: [
  //                                         Text(
  //                                           account['name'],
  //                                           style: GoogleFonts.lexend(
  //                                             fontSize: 16,
  //                                             fontWeight: FontWeight.w400,
  //                                             color: Color(0xff1C1B1D),
  //                                           ),
  //                                         ),
  //                                         SizedBox(width: 6),
  //                                         Container(
  //                                           padding: EdgeInsets.symmetric(
  //                                             horizontal: 10,
  //                                             vertical: 3,
  //                                           ),
  //                                           decoration: BoxDecoration(
  //                                             gradient: LinearGradient(
  //                                               colors: [
  //                                                 Color(0xFF5D50B6),
  //                                                 Color(0xFF2943C3),
  //                                               ],
  //                                             ),
  //                                             borderRadius:
  //                                                 BorderRadius.circular(10),
  //                                           ),
  //                                           child: Text(
  //                                             account['role'],
  //                                             style: GoogleFonts.lexend(
  //                                               fontSize: 10,
  //                                               fontWeight: FontWeight.w400,
  //                                               color: Colors.white,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     SizedBox(height: 3),
  //                                     Text(
  //                                       account['phone'],
  //                                       style: GoogleFonts.lexend(
  //                                         fontSize: 14,
  //                                         fontWeight: FontWeight.w500,
  //                                         color: Color(0xff4F4F4F),
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 3),
  //                                     Container(
  //                                       padding: EdgeInsets.symmetric(
  //                                         horizontal: 10,
  //                                         vertical: 4,
  //                                       ),
  //                                       decoration: BoxDecoration(
  //                                         color: Color(
  //                                           0xffDDDDDD,
  //                                         ).withOpacity(0.8),
  //                                         borderRadius: BorderRadius.circular(
  //                                           100,
  //                                         ),
  //                                       ),
  //                                       child: Text(
  //                                         account['company'],
  //                                         style: GoogleFonts.lexend(
  //                                           fontSize: 12,
  //                                           fontWeight: FontWeight.w500,
  //                                           color: Color(0xff4F4F4F),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               if (isSelected)
  //                                 Container(
  //                                   width: 26,
  //                                   height: 26,
  //                                   padding: EdgeInsets.all(3),
  //                                   decoration: BoxDecoration(
  //                                     gradient: LinearGradient(
  //                                       colors: [
  //                                         Color(0xFF5D50B6),
  //                                         Color.fromARGB(231, 47, 74, 207),
  //                                       ],
  //                                     ),
  //                                     shape: BoxShape.circle,
  //                                   ),
  //                                   child: Icon(
  //                                     Icons.check,
  //                                     color: Colors.white,
  //                                     size: 20,
  //                                   ),
  //                                 ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget menuwidgets(Widget icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 20,
              // child: SvgPicture.asset(
              //   'assets/icons/turn.svg',
              //   height: 20,
              //   width: 20,
              // ),
              child: icon,
            ),
            SizedBox(width: 10),
            // Text(
            //   // 'My Plan',
            //   text,
            //   style: GoogleFonts.lexend(
            //     fontSize: 16,
            //     color: Color(0xff4F4F4F),
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
            GradientText(
              text: text,
              gradient: LinearGradient(
                colors: [Color(0xFF5D50B6), Color(0xFF2943C3)],
              ),
              style: GoogleFonts.lexend(
                fontSize: 16,
                // color: Color(0xff4F4F4F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Icon(Icons.arrow_forward_ios, size: 10, color: Color(0xff7464E4)),
      ],
    );
  }
}

class CustomToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final double width;
  final double height;

  const CustomToggleSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor = const Color(0xff4CAF50),
    this.inactiveColor = const Color(0xff5F5F5F),
    this.thumbColor = const Color(0xffB0B0B0),
    this.width = 49,
    this.height = 26,
  });

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onChanged != null) {
          widget.onChanged!(!widget.value);
        }
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.height / 2),
              color: Color.lerp(
                widget.inactiveColor,
                widget.activeColor,
                _animation.value,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.lerp(
                  Alignment.centerLeft,
                  Alignment.centerRight,
                  _animation.value,
                )!,
                child: Container(
                  width: widget.height - 8,
                  height: widget.height - 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.thumbColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Call this function to show the overlay
void showProfileBottomOverlay(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const ProfileBottomOverlay(),
  );
}

class ProfileBottomOverlay extends StatefulWidget {
  const ProfileBottomOverlay({Key? key}) : super(key: key);

  @override
  State<ProfileBottomOverlay> createState() => _ProfileBottomOverlayState();
}

class _ProfileBottomOverlayState extends State<ProfileBottomOverlay> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isLoading = true;
  bool _isUpdating = false;
  bool _isUploadingImage = false;
  String _gender = '';
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _whatsappController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _fetchProfile() async {
    setState(() => _isLoading = true);

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://admin.partywitty.com/master/api/UserAuth/getUser'),
      )..fields['userId'] = '14393';

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body) as Map<String, dynamic>;
        if (jsonBody['status'] == true && jsonBody['data'] != null) {
          final data = jsonBody['data'] as Map<String, dynamic>;
          _nameController.text = (data['name'] ?? '').toString().trim();
          _emailController.text = (data['email'] ?? '').toString().trim();
          _whatsappController.text = (data['whatsapp'] ?? '').toString().trim();
          _dobController.text = (data['dob'] ?? '').toString().trim();
          _addressController.text = (data['address'] ?? '').toString().trim();
          _gender = (data['gender'] ?? '').toString();
          _imageUrl = data['img']?.toString();
        } else {
          _showSnackBar(
            jsonBody['msg']?.toString() ?? 'Failed to load profile',
          );
        }
      } else {
        _showSnackBar('Failed to load profile (${response.statusCode})');
      }
    } catch (e) {
      _showSnackBar('Something went wrong while loading profile');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isUpdating = true);
    try {
      final request =
          http.MultipartRequest(
              'POST',
              Uri.parse(
                'https://admin.partywitty.com/master/api/UserAuth/UpdateProfile',
              ),
            )
            ..fields.addAll({
              'user_id': '14393',
              'name': _nameController.text.trim(),
              'email': _emailController.text.trim(),
              'whatsapp': _whatsappController.text.trim(),
              'dob': _dobController.text.trim(),
              'gender': _gender,
              'address': _addressController.text.trim(),
            });

      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body) as Map<String, dynamic>;
        if (jsonBody['status'] == true) {
          _showSnackBar(jsonBody['msg']?.toString() ?? 'Profile updated');
        } else {
          _showSnackBar(jsonBody['msg']?.toString() ?? 'Update failed');
        }
      } else {
        _showSnackBar('Update failed (${response.statusCode})');
      }
    } catch (e) {
      _showSnackBar('Something went wrong while updating profile');
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    setState(() => _isUploadingImage = true);
    try {
      final uri = Uri.parse(
        'https://admin.partywitty.com/master/api/UserAuth/updateProfileImage',
      );
      final request = http.MultipartRequest('POST', uri)
        ..fields['user_id'] = '14393'
        ..files.add(await http.MultipartFile.fromPath('img', pickedFile.path));

      final response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body) as Map<String, dynamic>;
        if (jsonBody['status'] == true &&
            jsonBody['data'] is List &&
            (jsonBody['data'] as List).isNotEmpty) {
          final data = (jsonBody['data'] as List).first;
          final newImg = data['img']?.toString();
          if (newImg != null && newImg.isNotEmpty) {
            setState(() {
              _imageUrl = newImg.startsWith('http')
                  ? newImg
                  : 'https://admin.partywitty.com/master/assets/uploads/$newImg';
            });
          }
          _showSnackBar(jsonBody['msg']?.toString() ?? 'Image updated');
        } else {
          _showSnackBar(jsonBody['msg']?.toString() ?? 'Image upload failed');
        }
      } else {
        _showSnackBar('Image upload failed (${response.statusCode})');
      }
    } catch (e) {
      _showSnackBar('Something went wrong while uploading image');
    } finally {
      if (mounted) setState(() => _isUploadingImage = false);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.64,
      minChildSize: 0.35,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          // height: 500,
          decoration: const BoxDecoration(
            color: Color(0xFFECECEC),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //  const SizedBox(height: 20),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 40),
                          child: CircularProgressIndicator(),
                        )
                      else ...[
                        // Profile Picture
                        Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // border: Border.all(
                                //   color: Colors.white,
                                //   width: 4,
                                // ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    _imageUrl != null && _imageUrl!.isNotEmpty
                                        ? _imageUrl!
                                        : 'https://via.placeholder.com/120',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (_isUploadingImage)
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.35),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _isUploadingImage
                                    ? null
                                    : _pickAndUploadImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C63FF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        _buildTextField(
                          label: 'Name',
                          controller: _nameController,
                        ),

                        const SizedBox(height: 16),

                        _buildTextField(
                          label: 'Email',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        _buildTextField(
                          label: 'Date of Birth',
                          controller: _dobController,
                          // suffixIcon: Icons.calendar_today,
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _gender = 'Male'),
                                child: _buildGenderOption(
                                  label: 'Male',
                                  isSelected: _gender.toLowerCase() == 'male',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _gender = 'Female'),
                                child: _buildGenderOption(
                                  label: 'Female',
                                  isSelected: _gender.toLowerCase() == 'female',
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'WhatsApp Number',
                              style: GoogleFonts.lexend(
                                fontWeight: FontWeight.w400,
                                color: Color(0xff4F4F4F),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 10),
                            _buildTextField(
                              label: 'WhatsApp Number',
                              controller: _whatsappController,
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // _buildTextField(
                        //   label: 'Address',
                        //   controller: _addressController,
                        //   keyboardType: TextInputType.streetAddress,
                        // ),
                        // const SizedBox(height: 30),
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     onPressed: _isUpdating ? null : _updateProfile,
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: const Color(0xFF6C63FF),
                        //       padding: const EdgeInsets.symmetric(vertical: 18),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(4),
                        //       ),
                        //       elevation: 0,
                        //     ),
                        //     child: _isUpdating
                        //         ? const SizedBox(
                        //             height: 20,
                        //             width: 20,
                        //             child: CircularProgressIndicator(
                        //               valueColor: AlwaysStoppedAnimation<Color>(
                        //                 Colors.white,
                        //               ),
                        //               strokeWidth: 2,
                        //             ),
                        //           )
                        //         : const Text(
                        //             'Update Profile',
                        //             style: TextStyle(
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w400,
                        //               color: Colors.white,
                        //             ),
                        //           ),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: _isUpdating ? null : _updateProfile,
                          child: Container(
                            width: double.infinity,
                            height: 42,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF5D50B6), Color(0xFF2943C3)],
                              ),
                            ),
                            child: _isUpdating
                                ? const Center(
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      'Update Profile',
                                      style: GoogleFonts.lexend(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        // const SizedBox(height: 20),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    IconData? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   label,
        //   style: const TextStyle(
        //     fontSize: 16,
        //     color: Colors.black54,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        // const SizedBox(height: 8),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            color: Color(0xffffffff).withOpacity(0.9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: suffixIcon != null
                  ? Icon(suffixIcon, size: 20)
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption({required String label, required bool isSelected}) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: isSelected
            ? Border.all(color: const Color(0xFF6C63FF), width: 2)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? const Color(0xFF6C63FF) : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6C63FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isSelected ? const Color(0xFF6C63FF) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
