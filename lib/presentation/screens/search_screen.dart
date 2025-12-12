// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:partywitty/presentation/widgets/booking_tabs.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: 74,
//                 decoration: BoxDecoration(
//                   color: Color(0xffF1F1F1).withOpacity(0.5),
//                   border: Border.all(
//                     color: Color(0xffDDDDDD).withOpacity(0.76),
//                     width: 0.7,
//                   ),
//                 ),
//                 padding: EdgeInsets.all(15),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xff7464E4).withOpacity(0.1),
//                         Color(0xffB5A78B).withOpacity(0.1),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/icons/search.svg',
//                             width: 24,
//                             height: 24,
//                             color: Color(0xff4F4F4F),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             'Search your vibe',
//                             style: GoogleFonts.lexend(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff4F4F4F),
//                             ),
//                           ),
//                         ],
//                       ),

//                       SvgPicture.asset('assets/icons/mic.svg'),
//                     ],
//                   ),
//                 ),
//               ),

//               SizedBox(height: 13),
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Color(0xffF1F1F1).withOpacity(0.5),
//                   border: Border.all(
//                     color: Color(0xffDDDDDD).withOpacity(0.76),
//                     width: 0.7,
//                   ),
//                 ),
//                 padding: EdgeInsets.all(15),

//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Categorises for you',
//                       style: GoogleFonts.lexend(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff070707),
//                       ),
//                     ),

//                     SizedBox(height: 15),
//                     SearchBookingTabs(),
//                     SizedBox(height: 10),
//                     EventCard(
//                       imageUrl: 'assets/images/category1.png',
//                       title: '3-Day Competition',
//                       location: 'F-bar, Delhi',
//                       eventType: 'Live Music',
//                       date: 'Sun, 5 Oct',
//                       tagColor: Color(0xff8B7DD8),
//                       onTap: () {
//                         // Handle tap
//                       },
//                     ),
//                     EventCard(
//                       imageUrl: 'assets/images/category1.png',
//                       title: '3-Day Competition',
//                       location: 'F-bar, Delhi',
//                       eventType: 'Live Music',
//                       date: 'Sun, 5 Oct',
//                       tagColor: Color(0xff8B7DD8),
//                       onTap: () {
//                         // Handle tap
//                       },
//                     ),
//                     EventCard(
//                       imageUrl: 'assets/images/category1.png',
//                       title: '3-Day Competition',
//                       location: 'F-bar, Delhi',
//                       eventType: 'Live Music',
//                       date: 'Sun, 5 Oct',
//                       tagColor: Color(0xff8B7DD8),
//                       onTap: () {
//                         // Handle tap
//                       },
//                     ),
//                     EventCard(
//                       imageUrl: 'assets/images/category1.png',
//                       title: '3-Day Competition',
//                       location: 'F-bar, Delhi',
//                       eventType: 'Live Music',
//                       date: 'Sun, 5 Oct',
//                       tagColor: Color(0xff8B7DD8),
//                       onTap: () {
//                         // Handle tap
//                       },
//                     ),
//                     EventCard(
//                       imageUrl: 'assets/images/category1.png',
//                       title: '3-Day Competition',
//                       location: 'F-bar, Delhi',
//                       eventType: 'Live Music',
//                       date: 'Sun, 5 Oct',
//                       tagColor: Color(0xff8B7DD8),
//                       onTap: () {
//                         // Handle tap
//                       },
//                     ),
//                     EventCard(
//                       imageUrl: 'assets/images/category1.png',
//                       title: '3-Day Competition',
//                       location: 'F-bar, Delhi',
//                       eventType: 'Live Music',
//                       date: 'Sun, 5 Oct',
//                       tagColor: Color(0xff8B7DD8),
//                       onTap: () {
//                         // Handle tap
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15),

//               BlogSection(
//                 blogs: [
//                   {
//                     'imageUrl': 'assets/images/blog.png',
//                     'title': 'Title',
//                     'description':
//                         'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                     'date': 'Jan 4, 2022',
//                     'views': 3344,
//                   },
//                   // More blogs...
//                   {
//                     'imageUrl': 'assets/images/blog.png',
//                     'title': 'Title',
//                     'description':
//                         'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                     'date': 'Jan 4, 2022',
//                     'views': 3344,
//                   },
//                   {
//                     'imageUrl': 'assets/images/blog.png',
//                     'title': 'Title',
//                     'description':
//                         'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                     'date': 'Jan 4, 2022',
//                     'views': 3344,
//                   },
//                 ],
//                 //onViewAll: () => print('View all tapped'),
//               ),

//               SizedBox(height: 150),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class EventCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String location;
//   final String eventType;
//   final String date;
//   final Color? tagColor;
//   final VoidCallback? onTap;

//   const EventCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.location,
//     required this.eventType,
//     required this.date,
//     this.tagColor,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
//         // decoration: BoxDecoration(
//         //   color: Color(0xffECE8D, D),
//         //   borderRadius: BorderRadius.circular(12),
//         // ),
//         child: Row(
//           children: [
//             // Event Image with gradient border
//             Container(
//               width: 62,
//               height: 62,
//               decoration: BoxDecoration(
//                 // gradient: LinearGradient(
//                 //   colors: [Color(0xff7464E4), Color(0xffFF6B9D)],
//                 //   begin: Alignment.topLeft,
//                 //   end: Alignment.bottomRight,
//                 // ),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               // padding: EdgeInsets.all(3),
//               child: Container(
//                 width: 62,
//                 height: 62,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(13),
//                   color: Colors.white,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(4),
//                   child: Image.asset(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[300],
//                         child: Icon(Icons.image, size: 40, color: Colors.grey),
//                       );
//                     },
//                   ),
//                   //child: SvgPicture.asset(imageUrl),
//                 ),
//               ),
//             ),
//             SizedBox(width: 5),
//             // Event Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Title and Tag
//                   Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           title,
//                           style: GoogleFonts.lexend(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xff070707),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 5,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color(0xff7464E4).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Text(
//                           eventType,
//                           style: GoogleFonts.lexend(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff7464E4),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4),
//                   // Location
//                   Text(
//                     location,
//                     style: GoogleFonts.lexend(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4F4F4F),
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   // Date
//                   Row(
//                     children: [
//                       Text(
//                         'Event',
//                         style: GoogleFonts.lexend(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff4F4F4F),
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Container(
//                         width: 3,
//                         height: 3,
//                         decoration: BoxDecoration(
//                           color: Color(0xff4F4F4F),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Text(
//                         date,
//                         style: GoogleFonts.lexend(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff4F4F4F),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchBookingTabs extends StatelessWidget {
//   final List<String> tabs;

//   const SearchBookingTabs({
//     super.key,
//     this.tabs = const ['Events', 'Venue', 'Packages', 'Artist'],
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isSelected = true;
//     return SizedBox(
//       height: 38,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         //  padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         itemCount: tabs.length,
//         itemBuilder: (context, index) {
//           final tab = tabs[index];
//           //  final isSelected = tab == selectedTab;

//           return Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: _buildTab(tab, isSelected, context),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTab(String tab, bool isSelected, BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // context.read<BookingBloc>().add(ChangeBookingTabEvent(tab));
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xff7464E4) : Colors.white.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Center(
//           child: Text(
//             tab,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black87,
//               fontSize: 14,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BlogCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final String date;
//   final int views;
//   final VoidCallback? onTap;

//   const BlogCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.views,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Color(0xffF4F4F4),
//           borderRadius: BorderRadius.circular(0),
//           // boxShadow: [
//           //   BoxShadow(
//           //     color: Colors.black.withOpacity(0.05),
//           //     blurRadius: 8,
//           //     offset: Offset(0, 2),
//           //   ),
//           // ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Blog Image
//             Container(
//               width: 88,
//               height: 84,
//               padding: EdgeInsets.only(top: 4),
//               decoration: BoxDecoration(
//                 //borderRadius: BorderRadius.circular(8),
//                 //color: Colors.grey[300],
//               ),
//               child: ClipRRect(
//                 // borderRadius: BorderRadius.circular(8),
//                 child: Image.asset(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: Colors.grey[300],
//                       child: Icon(Icons.image, size: 40, color: Colors.grey),
//                     );
//                   },
//                 ),
//                 //  child: SvgPicture.asset(imageUrl),
//               ),
//             ),
//             SizedBox(width: 12),
//             // Blog Content
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title and Date/Views
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         title,
//                         style: GoogleFonts.lexend(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff2C2C2C),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),

//                       SizedBox(width: 12),
//                       Text(
//                         '$date • $views views',
//                         style: GoogleFonts.lexend(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w300,
//                           color: Color(0xff828282),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   // Description
//                   Text(
//                     description,
//                     style: GoogleFonts.lexend(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4F4F4F),
//                       height: 1.67,

//                       letterSpacing: 0,
//                     ),
//                     maxLines: 3,

//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BlogSection extends StatelessWidget {
//   final List<Map<String, dynamic>> blogs;
//   final VoidCallback? onViewAll;

//   const BlogSection({Key? key, required this.blogs, this.onViewAll})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Color(0xffF1F1F1).withOpacity(0.5),
//         border: Border.all(color: Color(0xffDDDDDD), width: 0.7),
//       ),

//       child: Column(
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Blogs',
//                 style: GoogleFonts.lexend(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xff070707),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: onViewAll,
//                 child: Row(
//                   children: [
//                     Text(
//                       'View all',
//                       style: GoogleFonts.lexend(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff070707),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     // Icon(
//                     //   Icons.arrow_forward,
//                     //   size: 20,
//                     //   color: Color(0xff151515),
//                     // ),
//                     SvgPicture.asset('assets/icons/next.svg'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 17),
//           // Blog Cards
//           ListView.separated(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: blogs.length,
//             separatorBuilder: (context, index) => SizedBox(height: 16),
//             itemBuilder: (context, index) {
//               final blog = blogs[index];
//               return BlogCard(
//                 imageUrl: blog['imageUrl'],
//                 title: blog['title'],
//                 description: blog['description'],
//                 date: blog['date'],
//                 views: blog['views'],
//                 onTap: () {
//                   print('Blog tapped: ${blog['title']}');
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:partywitty/presentation/widgets/booking_tabs.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             // Sticky Search Bar
//             SliverAppBar(
//               pinned: true,
//               floating: false,
//               forceElevated: false,
//               elevation: 0,
//               backgroundColor: Colors.transparent,
//               toolbarHeight: 74,
//               flexibleSpace: Container(
//                 height: 74,
//                 decoration: BoxDecoration(
//                   color: Color(0xffF1F1F1).withOpacity(0.5),
//                   border: Border.all(
//                     color: Color(0xffDDDDDD).withOpacity(0.76),
//                     width: 0.7,
//                   ),
//                 ),
//                 padding: EdgeInsets.all(15),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xff7464E4).withOpacity(0.1),
//                         Color(0xffB5A78B).withOpacity(0.1),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/icons/search.svg',
//                             width: 24,
//                             height: 24,
//                             color: Color(0xff4F4F4F),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             'Search your vibe',
//                             style: GoogleFonts.lexend(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff4F4F4F),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SvgPicture.asset('assets/icons/mic.svg'),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             // Scrollable Content
//             SliverToBoxAdapter(
//               child: Column(
//                 children: [
//                   SizedBox(height: 13),
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Color(0xffF1F1F1).withOpacity(0.5),
//                       border: Border.all(
//                         color: Color(0xffDDDDDD).withOpacity(0.76),
//                         width: 0.7,
//                       ),
//                     ),
//                     padding: EdgeInsets.all(15),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Categorises for you',
//                           style: GoogleFonts.lexend(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xff070707),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         SearchBookingTabs(),
//                         SizedBox(height: 10),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   BlogSection(
//                     blogs: [
//                       {
//                         'imageUrl': 'assets/images/blog.png',
//                         'title': 'Title',
//                         'description':
//                             'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                         'date': 'Jan 4, 2022',
//                         'views': 3344,
//                       },
//                       {
//                         'imageUrl': 'assets/images/blog.png',
//                         'title': 'Title',
//                         'description':
//                             'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                         'date': 'Jan 4, 2022',
//                         'views': 3344,
//                       },
//                       {
//                         'imageUrl': 'assets/images/blog.png',
//                         'title': 'Title',
//                         'description':
//                             'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                         'date': 'Jan 4, 2022',
//                         'views': 3344,
//                       },
//                     ],
//                   ),
//                   SizedBox(height: 150),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EventCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String location;
//   final String eventType;
//   final String date;
//   final Color? tagColor;
//   final VoidCallback? onTap;

//   const EventCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.location,
//     required this.eventType,
//     required this.date,
//     this.tagColor,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
//         child: Row(
//           children: [
//             Container(
//               width: 62,
//               height: 62,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Container(
//                 width: 62,
//                 height: 62,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(13),
//                   color: Colors.white,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(4),
//                   child: Image.asset(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[300],
//                         child: Icon(Icons.image, size: 40, color: Colors.grey),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 5),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           title,
//                           style: GoogleFonts.lexend(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xff070707),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 5,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color(0xff7464E4).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Text(
//                           eventType,
//                           style: GoogleFonts.lexend(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff7464E4),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     location,
//                     style: GoogleFonts.lexend(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4F4F4F),
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(
//                         'Event',
//                         style: GoogleFonts.lexend(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff4F4F4F),
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Container(
//                         width: 3,
//                         height: 3,
//                         decoration: BoxDecoration(
//                           color: Color(0xff4F4F4F),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Text(
//                         date,
//                         style: GoogleFonts.lexend(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff4F4F4F),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchBookingTabs extends StatelessWidget {
//   final List<String> tabs;

//   const SearchBookingTabs({
//     super.key,
//     this.tabs = const ['Events', 'Venue', 'Packages', 'Artist'],
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isSelected = true;
//     return SizedBox(
//       height: 38,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: tabs.length,
//         itemBuilder: (context, index) {
//           final tab = tabs[index];
//           return Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: _buildTab(tab, isSelected, context),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTab(String tab, bool isSelected, BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xff7464E4) : Colors.white.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Center(
//           child: Text(
//             tab,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black87,
//               fontSize: 14,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BlogCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final String date;
//   final int views;
//   final VoidCallback? onTap;

//   const BlogCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.views,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Color(0xffF4F4F4),
//           borderRadius: BorderRadius.circular(0),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 88,
//               height: 84,
//               padding: EdgeInsets.only(top: 4),
//               child: ClipRRect(
//                 child: Image.asset(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: Colors.grey[300],
//                       child: Icon(Icons.image, size: 40, color: Colors.grey),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         title,
//                         style: GoogleFonts.lexend(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff2C2C2C),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(width: 12),
//                       Text(
//                         '$date • $views views',
//                         style: GoogleFonts.lexend(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w300,
//                           color: Color(0xff828282),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     description,
//                     style: GoogleFonts.lexend(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4F4F4F),
//                       height: 1.67,
//                       letterSpacing: 0,
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BlogSection extends StatelessWidget {
//   final List<Map<String, dynamic>> blogs;
//   final VoidCallback? onViewAll;

//   const BlogSection({Key? key, required this.blogs, this.onViewAll})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Color(0xffF1F1F1).withOpacity(0.5),
//         border: Border.all(color: Color(0xffDDDDDD), width: 0.7),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Blogs',
//                 style: GoogleFonts.lexend(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xff070707),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: onViewAll,
//                 child: Row(
//                   children: [
//                     Text(
//                       'View all',
//                       style: GoogleFonts.lexend(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff070707),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     SvgPicture.asset('assets/icons/next.svg'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 17),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: blogs.length,
//             separatorBuilder: (context, index) => SizedBox(height: 16),
//             itemBuilder: (context, index) {
//               final blog = blogs[index];
//               return BlogCard(
//                 imageUrl: blog['imageUrl'],
//                 title: blog['title'],
//                 description: blog['description'],
//                 date: blog['date'],
//                 views: blog['views'],
//                 onTap: () {
//                   print('Blog tapped: ${blog['title']}');
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:partywitty/presentation/widgets/booking_tabs.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Sticky Search Bar (behind scrolling content)
//             BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
//               child: Container(
//                 height: 74,
//                 decoration: BoxDecoration(
//                   color: Color(0xffF1F1F1).withOpacity(0.3),
//                   border: Border.all(
//                     color: Color(0xffDDDDDD).withOpacity(0.76),
//                     width: 0.7,
//                   ),
//                 ),
//                 padding: EdgeInsets.all(15),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color(0xff7464E4).withOpacity(0.1),
//                         Color(0xffB5A78B).withOpacity(0.1),
//                       ],
//                     ),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           SvgPicture.asset(
//                             'assets/icons/search.svg',
//                             width: 24,
//                             height: 24,
//                             color: Color(0xff4F4F4F),
//                           ),
//                           SizedBox(width: 5),
//                           Text(
//                             'Search your vibe',
//                             style: GoogleFonts.lexend(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff4F4F4F),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SvgPicture.asset('assets/icons/mic.svg'),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             // Scrollable Content (on top, will hide the search bar when scrolled)
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 87), // Space for search bar + gap
//                   Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Color(0xffF1F1F1).withOpacity(0.5),
//                       border: Border.all(
//                         color: Color(0xffDDDDDD).withOpacity(0.76),
//                         width: 0.7,
//                       ),
//                     ),
//                     padding: EdgeInsets.all(15),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Categorises for you',
//                           style: GoogleFonts.lexend(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xff070707),
//                           ),
//                         ),
//                         SizedBox(height: 15),
//                         SearchBookingTabs(),
//                         SizedBox(height: 10),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                         EventCard(
//                           imageUrl: 'assets/images/category1.png',
//                           title: '3-Day Competition',
//                           location: 'F-bar, Delhi',
//                           eventType: 'Live Music',
//                           date: 'Sun, 5 Oct',
//                           tagColor: Color(0xff8B7DD8),
//                           onTap: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   BlogSection(
//                     blogs: [
//                       {
//                         'imageUrl': 'assets/images/blog.png',
//                         'title': 'Title',
//                         'description':
//                             'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                         'date': 'Jan 4, 2022',
//                         'views': 3344,
//                       },
//                       {
//                         'imageUrl': 'assets/images/blog.png',
//                         'title': 'Title',
//                         'description':
//                             'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                         'date': 'Jan 4, 2022',
//                         'views': 3344,
//                       },
//                       {
//                         'imageUrl': 'assets/images/blog.png',
//                         'title': 'Title',
//                         'description':
//                             'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                         'date': 'Jan 4, 2022',
//                         'views': 3344,
//                       },
//                     ],
//                   ),
//                   SizedBox(height: 150),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class EventCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String location;
//   final String eventType;
//   final String date;
//   final Color? tagColor;
//   final VoidCallback? onTap;

//   const EventCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.location,
//     required this.eventType,
//     required this.date,
//     this.tagColor,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
//         child: Row(
//           children: [
//             Container(
//               width: 62,
//               height: 62,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Container(
//                 width: 62,
//                 height: 62,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(13),
//                   color: Colors.white,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(4),
//                   child: Image.asset(
//                     imageUrl,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey[300],
//                         child: Icon(Icons.image, size: 40, color: Colors.grey),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 5),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                     children: [
//                       Flexible(
//                         child: Text(
//                           title,
//                           style: GoogleFonts.lexend(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xff070707),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 5,
//                           vertical: 2,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color(0xff7464E4).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(100),
//                         ),
//                         child: Text(
//                           eventType,
//                           style: GoogleFonts.lexend(
//                             fontSize: 10,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff7464E4),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     location,
//                     style: GoogleFonts.lexend(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4F4F4F),
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Text(
//                         'Event',
//                         style: GoogleFonts.lexend(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff4F4F4F),
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Container(
//                         width: 3,
//                         height: 3,
//                         decoration: BoxDecoration(
//                           color: Color(0xff4F4F4F),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: 4),
//                       Text(
//                         date,
//                         style: GoogleFonts.lexend(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xff4F4F4F),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SearchBookingTabs extends StatelessWidget {
//   final List<String> tabs;

//   const SearchBookingTabs({
//     super.key,
//     this.tabs = const ['Events', 'Venue', 'Packages', 'Artist'],
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isSelected = true;
//     return SizedBox(
//       height: 38,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: tabs.length,
//         itemBuilder: (context, index) {
//           final tab = tabs[index];
//           return Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: _buildTab(tab, isSelected, context),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTab(String tab, bool isSelected, BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xff7464E4) : Colors.white.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Center(
//           child: Text(
//             tab,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black87,
//               fontSize: 14,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class BlogCard extends StatelessWidget {
//   final String imageUrl;
//   final String title;
//   final String description;
//   final String date;
//   final int views;
//   final VoidCallback? onTap;

//   const BlogCard({
//     Key? key,
//     required this.imageUrl,
//     required this.title,
//     required this.description,
//     required this.date,
//     required this.views,
//     this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           color: Color(0xffF4F4F4),
//           borderRadius: BorderRadius.circular(0),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 88,
//               height: 84,
//               padding: EdgeInsets.only(top: 4),
//               child: ClipRRect(
//                 child: Image.asset(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       color: Colors.grey[300],
//                       child: Icon(Icons.image, size: 40, color: Colors.grey),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         title,
//                         style: GoogleFonts.lexend(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: Color(0xff2C2C2C),
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(width: 12),
//                       Text(
//                         '$date • $views views',
//                         style: GoogleFonts.lexend(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w300,
//                           color: Color(0xff828282),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     description,
//                     style: GoogleFonts.lexend(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff4F4F4F),
//                       height: 1.67,
//                       letterSpacing: 0,
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BlogSection extends StatelessWidget {
//   final List<Map<String, dynamic>> blogs;
//   final VoidCallback? onViewAll;

//   const BlogSection({Key? key, required this.blogs, this.onViewAll})
//     : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Color(0xffF1F1F1).withOpacity(0.5),
//         border: Border.all(color: Color(0xffDDDDDD), width: 0.7),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Blogs',
//                 style: GoogleFonts.lexend(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xff070707),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: onViewAll,
//                 child: Row(
//                   children: [
//                     Text(
//                       'View all',
//                       style: GoogleFonts.lexend(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff070707),
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     SvgPicture.asset('assets/icons/next.svg'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 17),
//           ListView.separated(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: blogs.length,
//             separatorBuilder: (context, index) => SizedBox(height: 16),
//             itemBuilder: (context, index) {
//               final blog = blogs[index];
//               return BlogCard(
//                 imageUrl: blog['imageUrl'],
//                 title: blog['title'],
//                 description: blog['description'],
//                 date: blog['date'],
//                 views: blog['views'],
//                 onTap: () {
//                   print('Blog tapped: ${blog['title']}');
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearchExpanded = false;
  bool _showHistory = false;
  bool _showSuggestions = false;
  bool _isSearchFocused = false;
  bool _showTextAfterCollapse = false;
  int _searchTapCount = 0;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  final List<String> _searchHistory = [
    'Nike Air Max - Lightweight running shoes',
    'Adidas Ultraboost - Best for daily training',
    'Puma RS-X - Casual streetwear sneakers',
    'Woodland Boots - Durable for trekking',
    'Bata Formal Shoes - Office & business wear',
  ];

  final List<String> _suggestions = [
    'Flying Dutch Man',
    'Flying Room',
    'Sky Fly',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _handleSearchBarTap() {
    print('========================================');
    print('Search bar TAPPED!');
    print('_isSearchFocused: $_isSearchFocused');
    print('_isSearchExpanded: $_isSearchExpanded');
    print('_showHistory: $_showHistory');
    print('_showSuggestions: $_showSuggestions');
    print('_showTextAfterCollapse: $_showTextAfterCollapse');
    print('_searchTapCount: $_searchTapCount');
    print('========================================');

    // Ignore taps while helper is open with no sub-state
    if (_isSearchExpanded && !_showHistory && !_showSuggestions) {
      return;
    }

    if (_showTextAfterCollapse && !_isSearchExpanded) {
      // Reset to initial state
      print('ACTION: Resetting to initial state');
      setState(() {
        _showTextAfterCollapse = false;
        _isSearchFocused = false;
        _searchController.clear();
        _searchTapCount = 0;
      });
    } else if (!_isSearchFocused && !_isSearchExpanded) {
      // First click: Show TextField for input
      print('ACTION: Showing TextField');
      setState(() {
        _isSearchFocused = true;
        _searchTapCount = 1;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        _searchFocusNode.requestFocus();
      });
    } else if (_isSearchFocused &&
        !_showHistory &&
        !_showSuggestions &&
        !_isSearchExpanded) {
      // Second click: Expand to search helper
      print('ACTION: Expanding to Search Helper');
      setState(() {
        _isSearchExpanded = true;
        _searchTapCount = 2;
      });
      _searchFocusNode.unfocus();
    } else if (_showHistory && !_showSuggestions) {
      // If showing history, switch to suggestions
      print('ACTION: Switching to Suggestions');
      setState(() {
        _showHistory = false;
        _showSuggestions = true;
        _searchTapCount = 3;
      });
    } else if (_showSuggestions) {
      // If showing suggestions, collapse and show "Flying Dutch Man"
      print('ACTION: Collapsing to Flying Dutch Man');
      setState(() {
        _isSearchExpanded = false;
        _showSuggestions = false;
        _showHistory = false;
        _isSearchFocused = false;
        _showTextAfterCollapse = true;
        _searchController.text = 'Flying Dutch Man';
        _searchTapCount = 4;
      });
    }
  }

  double get _containerHeight {
    if (!_isSearchExpanded) return 76.0;
    if (_showHistory) return 336.0;
    if (_showSuggestions) return 236.0;
    return 224.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable Content (on top)
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: _containerHeight + 13),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF1F1F1).withOpacity(0.5),
                      border: Border.all(
                        color: Color(0xffDDDDDD).withOpacity(0.76),
                        width: 0.7,
                      ),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Categorises for you',
                          style: GoogleFonts.lexend(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff070707),
                          ),
                        ),
                        SizedBox(height: 15),
                        SearchBookingTabs(),
                        SizedBox(height: 10),
                        ...List.generate(
                          6,
                          (index) => EventCard(
                            imageUrl: 'assets/images/category1.png',
                            title: '3-Day Competition',
                            location: 'F-bar, Delhi',
                            eventType: 'Live Music',
                            date: 'Sun, 5 Oct',
                            tagColor: Color(0xff8B7DD8),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  BlogSection(
                    blogs: List.generate(
                      3,
                      (index) => {
                        'imageUrl': 'assets/images/blog.png',
                        'title': 'Title',
                        'description':
                            'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
                        'date': 'Jan 4, 2022',
                        'views': 3344,
                      },
                    ),
                  ),
                  SizedBox(height: 150),
                ],
              ),
            ),
            // Sticky Search Bar (front)
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              height: _containerHeight,
              decoration: BoxDecoration(
                color: _isSearchExpanded
                    ? Color(0xffF1F1F1).withOpacity(0.5)
                    : Color(0xffF1F1F1).withOpacity(0.5),
                border: Border.all(
                  color: Color(0xffDDDDDD).withOpacity(0.76),
                  width: 0.7,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search Bar
                  Container(
                    height: 74,
                    padding: EdgeInsets.all(15),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap:
                          _isSearchExpanded &&
                              !_showHistory &&
                              !_showSuggestions
                          ? null
                          : _handleSearchBarTap,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff7464E4).withOpacity(0.1),
                              Color(0xffB5A78B).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/search.svg',
                                    width: 24,
                                    height: 24,
                                    color: Color(0xff4F4F4F),
                                  ),
                                  SizedBox(width: 5),
                                  if (_isSearchFocused &&
                                      !_showTextAfterCollapse)
                                    Expanded(
                                      child: TextField(
                                        controller: _searchController,
                                        focusNode: _searchFocusNode,
                                        style: GoogleFonts.lexend(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4F4F4F),
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Search your vibe',
                                          hintStyle: GoogleFonts.lexend(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff4F4F4F),
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                      ),
                                    )
                                  else
                                    Expanded(
                                      child: Text(
                                        _showTextAfterCollapse
                                            ? 'Flying Dutch Man'
                                            : 'Search your vibe',
                                        style: GoogleFonts.lexend(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff4F4F4F),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SvgPicture.asset('assets/icons/mic.svg'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded Search Content
                  if (_isSearchExpanded || _showSuggestions || _showHistory)
                    Expanded(
                      child: ClipRect(
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          child: _showHistory
                              ? _buildHistoryView()
                              : _showSuggestions
                              ? _buildSuggestionsView()
                              : _buildSearchHelperView(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHelperView() {
    return Container(
      key: ValueKey('helper'),
      padding: EdgeInsets.only(left: 15, bottom: 12, right: 15, top: 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Search Helper',
              style: GoogleFonts.lexend(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xff070707),
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Explore new possibilities',
              style: GoogleFonts.lexend(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff070707),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We couldn\'t find any results for your search. Try using different keywords or adjusting filters.',
              style: GoogleFonts.lexend(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xff4F4F4F),
                height: 1.3,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showHistory = true;
                  _showSuggestions = false;
                  _isSearchFocused = false;
                  _isSearchExpanded = true;
                  _searchTapCount = 2;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  //  borderRadius: BorderRadius.circular(4),
                  color: Color(0xff7464E4).withOpacity(0.15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, color: Color(0xff7464E4), size: 16),
                    SizedBox(width: 6),
                    Text(
                      'Go Back',
                      style: GoogleFonts.lexend(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff7464E4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryView() {
    return Container(
      key: ValueKey('history'),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff070707),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Clear',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFF5555),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _searchHistory.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(Icons.history, size: 20, color: Color(0xff4F4F4F)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _searchHistory[index],
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff070707),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsView() {
    return Container(
      key: ValueKey('suggestions'),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Suggestions',
                  style: GoogleFonts.lexend(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff070707),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Clear',
                    style: GoogleFonts.lexend(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffFF5555),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 20, color: Color(0xff4F4F4F)),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _suggestions[index],
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff070707),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// EventCard, SearchBookingTabs, BlogCard, and BlogSection remain the same
class EventCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String eventType;
  final String date;
  final Color? tagColor;
  final VoidCallback? onTap;

  const EventCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.eventType,
    required this.date,
    this.tagColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.image, size: 40, color: Colors.grey),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: GoogleFonts.lexend(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff070707),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff7464E4).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          eventType,
                          style: GoogleFonts.lexend(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7464E4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    location,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4F4F4F),
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Event',
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                      SizedBox(width: 4),
                      Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Color(0xff4F4F4F),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        date,
                        style: GoogleFonts.lexend(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff4F4F4F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBookingTabs extends StatelessWidget {
  final List<String> tabs;

  const SearchBookingTabs({
    super.key,
    this.tabs = const ['Events', 'Venue', 'Packages', 'Artist'],
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = true;
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: _buildTab(tab, isSelected, context),
          );
        },
      ),
    );
  }

  Widget _buildTab(String tab, bool isSelected, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            tab,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String date;
  final int views;
  final VoidCallback? onTap;

  const BlogCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.date,
    required this.views,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 88,
              height: 84,
              padding: EdgeInsets.only(top: 4),
              child: ClipRRect(
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.image, size: 40, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff2C2C2C),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 12),
                      Text(
                        '$date • $views views',
                        style: GoogleFonts.lexend(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          color: Color(0xff828282),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: GoogleFonts.lexend(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4F4F4F),
                      height: 1.67,
                      letterSpacing: 0,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlogSection extends StatelessWidget {
  final List<Map<String, dynamic>> blogs;
  final VoidCallback? onViewAll;

  const BlogSection({Key? key, required this.blogs, this.onViewAll})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xffF1F1F1).withOpacity(0.5),
        border: Border.all(color: Color(0xffDDDDDD), width: 0.7),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Blogs',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff070707),
                ),
              ),
              GestureDetector(
                onTap: onViewAll,
                child: Row(
                  children: [
                    Text(
                      'View all',
                      style: GoogleFonts.lexend(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff070707),
                      ),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset('assets/icons/next.svg'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 17),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: blogs.length,
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemBuilder: (context, index) {
              final blog = blogs[index];
              return BlogCard(
                imageUrl: blog['imageUrl'],
                title: blog['title'],
                description: blog['description'],
                date: blog['date'],
                views: blog['views'],
                onTap: () {
                  print('Blog tapped: ${blog['title']}');
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
