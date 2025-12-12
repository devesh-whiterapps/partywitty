// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../data/services/search_service.dart';
// import '../../domain/models/search_model.dart';

// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   bool _isSearchExpanded = false;
//   bool _showHistory = false;
//   bool _showSuggestions = false;
//   bool _isSearchFocused = false;
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();

//   // Search API related
//   final SearchService _searchService = SearchService();
//   SearchResponse? _searchResponse;
//   bool _isSearching = false;
//   Timer? _debounceTimer;
//   String _selectedTab = 'Events';

//   // Scroll tracking
//   final ScrollController _scrollController = ScrollController();
//   bool _isSearchBarVisible = true;
//   double _lastScrollOffset = 0.0;

//   // Hardcoded coordinates
//   static const String _latitude = '28.6294016';
//   static const String _longitude = '77.135872';

//   final List<String> _searchHistory = [
//     'Nike Air Max - Lightweight running shoes',
//     'Adidas Ultraboost - Best for daily training',
//     'Puma RS-X - Casual streetwear sneakers',
//     'Woodland Boots - Durable for trekking',
//     'Bata Formal Shoes - Office & business wear',
//   ];

//   final List<String> _suggestions = [
//     'Flying Dutch Man',
//     'Flying Room',
//     'Sky Fly',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _searchController.addListener(_onSearchChanged);
//     _scrollController.addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _debounceTimer?.cancel();
//     _searchController.removeListener(_onSearchChanged);
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     final currentOffset = _scrollController.offset;

//     // Don't hide search bar if it's expanded (showing suggestions/history/helper)
//     if (_isSearchExpanded) {
//       return;
//     }

//     // Hide search bar when scrolling down, show when scrolling up
//     if (currentOffset > _lastScrollOffset && currentOffset > 50) {
//       // Scrolling down - hide search bar
//       if (_isSearchBarVisible) {
//         setState(() {
//           _isSearchBarVisible = false;
//         });
//       }
//     } else if (currentOffset < _lastScrollOffset || currentOffset <= 50) {
//       // Scrolling up or near top - show search bar
//       if (!_isSearchBarVisible) {
//         setState(() {
//           _isSearchBarVisible = true;
//         });
//       }
//     }

//     _lastScrollOffset = currentOffset;
//   }

//   void _onSearchChanged() {
//     final query = _searchController.text.trim();

//     // Cancel previous timer
//     _debounceTimer?.cancel();

//     if (query.isEmpty) {
//       setState(() {
//         _searchResponse = null;
//         _isSearching = false;
//         // Show suggestions while typing if focused
//         if (_isSearchFocused) {
//           _showSuggestions = true;
//           _isSearchExpanded = true;
//         }
//       });
//       return;
//     }

//     // Show suggestions while typing (before search completes)
//     if (_isSearchFocused && !_isSearchExpanded) {
//       setState(() {
//         _showSuggestions = true;
//         _isSearchExpanded = true;
//       });
//     }

//     // Debounce search API call
//     _debounceTimer = Timer(Duration(milliseconds: 500), () {
//       _performSearch(query);
//     });
//   }

//   Future<void> _performSearch(String keyword) async {
//     if (keyword.isEmpty) return;

//     setState(() {
//       _isSearching = true;
//     });

//     try {
//       final response = await _searchService.globalSearch(
//         keyword: keyword,
//         latitude: _latitude,
//         longitude: _longitude,
//       );

//       setState(() {
//         _searchResponse = response;
//         _isSearching = false;
//         // Hide suggestions when search completes
//         _showSuggestions = false;
//         // If no results, show search helper
//         if (!response.status || !_hasResults(response)) {
//           _isSearchExpanded = true;
//         } else {
//           // If results present, collapse expanded view (results shown in scrollable content)
//           _isSearchExpanded = false;
//         }
//       });
//     } catch (e) {
//       print('Search error: $e');
//       setState(() {
//         _isSearching = false;
//         _searchResponse = null;
//       });
//     }
//   }

//   bool _hasResults(SearchResponse response) {
//     return response.data.clubs.isNotEmpty ||
//         response.data.packages.isNotEmpty ||
//         response.data.events.isNotEmpty;
//   }

//   int _getTabCount(String tab) {
//     if (_searchResponse == null) return 0;
//     switch (tab) {
//       case 'Events':
//         return _searchResponse!.data.events.length;
//       case 'Venue':
//         return _searchResponse!.data.clubs.length;
//       case 'Packages':
//         return _searchResponse!.data.packages.length;
//       case 'Artist':
//         return 0; // No artist data in API response
//       default:
//         return 0;
//     }
//   }

//   void _handleSearchBarTap() {
//     // When user clicks on search bar, focus and show suggestions
//     if (!_isSearchFocused) {
//       setState(() {
//         _isSearchFocused = true;
//         _showSuggestions = true;
//         _isSearchExpanded = true;
//         _showHistory = false;
//       });
//       Future.delayed(Duration(milliseconds: 100), () {
//         _searchFocusNode.requestFocus();
//       });
//     }
//   }

//   double get _containerHeight {
//     if (!_isSearchExpanded) return 76.0;
//     if (_showHistory) return 336.0;
//     if (_showSuggestions) return 236.0;
//     return 224.0; // Search helper height
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Scrollable Content (can scroll above search bar)
//             SingleChildScrollView(
//               controller: _scrollController,
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: [
//                   SizedBox(height: _containerHeight + 13),
//                   // Only show "Categorises for you" section when search is complete and results are present
//                   if (!_isSearching &&
//                       _searchResponse != null &&
//                       _hasResults(_searchResponse!))
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Color(0xffF1F1F1).withOpacity(0.5),
//                         border: Border.all(
//                           color: Color(0xffDDDDDD).withOpacity(0.76),
//                           width: 0.7,
//                         ),
//                       ),
//                       padding: EdgeInsets.all(15),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Categorises for you',
//                             style: GoogleFonts.lexend(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xff070707),
//                             ),
//                           ),
//                           SizedBox(height: 15),
//                           SearchBookingTabs(
//                             selectedTab: _selectedTab,
//                             onTabSelected: (tab) {
//                               setState(() {
//                                 _selectedTab = tab;
//                               });
//                             },
//                             eventCount: _getTabCount('Events'),
//                             venueCount: _getTabCount('Venue'),
//                             packageCount: _getTabCount('Packages'),
//                             artistCount: _getTabCount('Artist'),
//                           ),
//                           SizedBox(height: 10),
//                           _buildSearchResultsContent(),
//                         ],
//                       ),
//                     ),
//                   SizedBox(height: 15),
//                   BlogSection(
//                     blogs: List.generate(
//                       3,
//                       (index) => {
//                         'imageUrl': 'assets/images/blog.png',
//                         'title': 'Title',
//                         'description':
//                             'Lorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development.',
//                         'date': 'Jan 4, 2022',
//                         'views': 3344,
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 150),
//                 ],
//               ),
//             ),
//             // Sticky Search Bar (front) - hides when scrolling down
//             AnimatedPositioned(
//               duration: Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               top: _isSearchBarVisible ? 0 : -_containerHeight,
//               left: 0,
//               right: 0,
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 400),
//                 curve: Curves.easeInOut,
//                 height: _containerHeight,
//                 decoration: BoxDecoration(
//                   color: _isSearchExpanded
//                       ? Color(0xffF1F1F1).withOpacity(0.5)
//                       : Color(0xffF1F1F1).withOpacity(0.5),
//                   border: Border.all(
//                     color: Color(0xffDDDDDD).withOpacity(0.76),
//                     width: 0.7,
//                   ),
//                 ),
//                 clipBehavior: Clip.hardEdge,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Search Bar
//                     Container(
//                       height: 74,
//                       padding: EdgeInsets.all(15),
//                       child: GestureDetector(
//                         behavior: HitTestBehavior.opaque,
//                         onTap:
//                             _isSearchExpanded &&
//                                 !_showHistory &&
//                                 !_showSuggestions
//                             ? null
//                             : _handleSearchBarTap,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color(0xff7464E4).withOpacity(0.1),
//                                 Color(0xffB5A78B).withOpacity(0.1),
//                               ],
//                             ),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           padding: EdgeInsets.symmetric(
//                             vertical: 10,
//                             horizontal: 15,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     SvgPicture.asset(
//                                       'assets/icons/search.svg',
//                                       width: 24,
//                                       height: 24,
//                                       color: Color(0xff4F4F4F),
//                                     ),
//                                     SizedBox(width: 5),
//                                     if (_isSearchFocused)
//                                       Expanded(
//                                         child: TextField(
//                                           controller: _searchController,
//                                           focusNode: _searchFocusNode,
//                                           style: GoogleFonts.lexend(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                             color: Color(0xff4F4F4F),
//                                           ),
//                                           decoration: InputDecoration(
//                                             hintText: 'Search your vibe',
//                                             hintStyle: GoogleFonts.lexend(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500,
//                                               color: Color(0xff4F4F4F),
//                                             ),
//                                             border: InputBorder.none,
//                                             isDense: true,
//                                             contentPadding: EdgeInsets.zero,
//                                           ),
//                                         ),
//                                       )
//                                     else
//                                       Expanded(
//                                         child: Text(
//                                           'Search your vibe',
//                                           style: GoogleFonts.lexend(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w500,
//                                             color: Color(0xff4F4F4F),
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                               SvgPicture.asset('assets/icons/mic.svg'),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Expanded Search Content
//                     if (_isSearchExpanded || _showSuggestions || _showHistory)
//                       Expanded(
//                         child: ClipRect(
//                           child: AnimatedSwitcher(
//                             duration: Duration(milliseconds: 400),
//                             switchInCurve: Curves.easeInOut,
//                             switchOutCurve: Curves.easeInOut,
//                             child: _showHistory
//                                 ? _buildHistoryView()
//                                 : _showSuggestions
//                                 ? _buildSuggestionsView()
//                                 : _buildSearchHelperView(),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchHelperView() {
//     return Container(
//       key: ValueKey('helper'),
//       padding: EdgeInsets.only(left: 15, bottom: 12, right: 15, top: 0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Search Helper',
//               style: GoogleFonts.lexend(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xff070707),
//               ),
//             ),
//             SizedBox(height: 6),
//             Text(
//               'Explore new possibilities',
//               style: GoogleFonts.lexend(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xff070707),
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'We couldn\'t find any results for your search. Try using different keywords or adjusting filters.',
//               style: GoogleFonts.lexend(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w400,
//                 color: Color(0xff4F4F4F),
//                 height: 1.3,
//               ),
//             ),
//             SizedBox(height: 12),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _showHistory = true;
//                   _showSuggestions = false;
//                   _isSearchExpanded = true;
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//                 decoration: BoxDecoration(
//                   //  borderRadius: BorderRadius.circular(4),
//                   color: Color(0xff7464E4).withOpacity(0.15),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.arrow_back, color: Color(0xff7464E4), size: 16),
//                     SizedBox(width: 6),
//                     Text(
//                       'Go Back',
//                       style: GoogleFonts.lexend(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xff7464E4),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHistoryView() {
//     return Container(
//       key: ValueKey('history'),
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'History',
//                   style: GoogleFonts.lexend(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xff070707),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     'Clear',
//                     style: GoogleFonts.lexend(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xffFF5555),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: _searchHistory.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: 10),
//                   child: Row(
//                     children: [
//                       Icon(Icons.history, size: 20, color: Color(0xff4F4F4F)),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: Text(
//                           _searchHistory[index],
//                           style: GoogleFonts.lexend(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xff070707),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSuggestionsView() {
//     return Container(
//       key: ValueKey('suggestions'),
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Suggestions',
//                   style: GoogleFonts.lexend(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xff070707),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Text(
//                     'Clear',
//                     style: GoogleFonts.lexend(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Color(0xffFF5555),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: _suggestions.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     _searchController.text = _suggestions[index];
//                     _performSearch(_suggestions[index]);
//                   },
//                   child: Padding(
//                     padding: EdgeInsets.only(bottom: 10),
//                     child: Row(
//                       children: [
//                         Icon(Icons.search, size: 20, color: Color(0xff4F4F4F)),
//                         SizedBox(width: 10),
//                         Expanded(
//                           child: Text(
//                             _suggestions[index],
//                             style: GoogleFonts.lexend(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xff070707),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchResultsContent() {
//     if (_searchResponse == null || !_hasResults(_searchResponse!)) {
//       return SizedBox.shrink();
//     }

//     switch (_selectedTab) {
//       case 'Events':
//         if (_searchResponse!.data.events.isEmpty) {
//           return SizedBox.shrink();
//         }
//         return Column(
//           children: _searchResponse!.data.events.map((event) {
//             return EventCard(
//               imageUrl: 'assets/images/category1.png', // Placeholder for now
//               title: event.name,
//               location: '${event.clubName}, ${event.cityName}',
//               eventType: event.category,
//               date: event.eventDate,
//               tagColor: Color(0xff8B7DD8),
//               onTap: () {},
//             );
//           }).toList(),
//         );
//       case 'Venue':
//         if (_searchResponse!.data.clubs.isEmpty) {
//           return SizedBox.shrink();
//         }
//         return Column(
//           children: _searchResponse!.data.clubs.map((club) {
//             return EventCard(
//               imageUrl: 'assets/images/category1.png', // Placeholder for now
//               title: club.name,
//               location: '${club.areaName}, ${club.cityName}',
//               eventType: club.category,
//               date: '${club.distance} km away',
//               tagColor: Color(0xff8B7DD8),
//               onTap: () {},
//             );
//           }).toList(),
//         );
//       case 'Packages':
//         if (_searchResponse!.data.packages.isEmpty) {
//           return SizedBox.shrink();
//         }
//         return Column(
//           children: _searchResponse!.data.packages.map((pkg) {
//             return EventCard(
//               imageUrl: 'assets/images/category1.png', // Placeholder for now
//               title: pkg.title,
//               location: '${pkg.clubName}, ${pkg.cityName}',
//               eventType: 'Package',
//               date: '${pkg.distance} km away',
//               tagColor: Color(0xff8B7DD8),
//               onTap: () {},
//             );
//           }).toList(),
//         );
//       case 'Artist':
//         return SizedBox.shrink();
//       default:
//         return SizedBox.shrink();
//     }
//   }
// }

// // EventCard, SearchBookingTabs, BlogCard, and BlogSection remain the same
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
//   final String selectedTab;
//   final Function(String) onTabSelected;
//   final int eventCount;
//   final int venueCount;
//   final int packageCount;
//   final int artistCount;

//   const SearchBookingTabs({
//     super.key,
//     this.tabs = const ['Events', 'Venue', 'Packages', 'Artist'],
//     required this.selectedTab,
//     required this.onTabSelected,
//     this.eventCount = 0,
//     this.venueCount = 0,
//     this.packageCount = 0,
//     this.artistCount = 0,
//   });

//   int _getCount(String tab) {
//     switch (tab) {
//       case 'Events':
//         return eventCount;
//       case 'Venue':
//         return venueCount;
//       case 'Packages':
//         return packageCount;
//       case 'Artist':
//         return artistCount;
//       default:
//         return 0;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 38,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: tabs.length,
//         itemBuilder: (context, index) {
//           final tab = tabs[index];
//           final isSelected = tab == selectedTab;
//           return Padding(
//             padding: const EdgeInsets.only(right: 10.0),
//             child: _buildTab(tab, isSelected, context),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTab(String tab, bool isSelected, BuildContext context) {
//     final count = _getCount(tab);
//     return GestureDetector(
//       onTap: () => onTabSelected(tab),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? Color(0xff7464E4) : Colors.white.withOpacity(0.7),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               tab,
//               style: GoogleFonts.lexend(
//                 color: isSelected ? Colors.white : Colors.black87,
//                 fontSize: 14,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//               ),
//             ),
//             if (count > 0) ...[
//               SizedBox(width: 6),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? Colors.white.withOpacity(0.3)
//                       : Color(0xff7464E4).withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   count.toString(),
//                   style: GoogleFonts.lexend(
//                     color: isSelected ? Colors.white : Color(0xff7464E4),
//                     fontSize: 11,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ],
//           ],
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

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partywitty/data/services/search_service.dart';
import 'package:partywitty/domain/models/search_model.dart';

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
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // Search API related
  final SearchService _searchService = SearchService();
  SearchResponse? _searchResponse;
  bool _isSearching = false;
  Timer? _debounceTimer;
  String _selectedTab = 'Events';

  // Scroll controller for main content
  final ScrollController _scrollController = ScrollController();

  // Hardcoded coordinates
  static const String _latitude = '28.6294016';
  static const String _longitude = '77.135872';

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
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _scrollController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();

    // Cancel previous timer
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      setState(() {
        _searchResponse = null;
        _isSearching = false;
        // Show suggestions while typing if focused
        if (_isSearchFocused) {
          _showSuggestions = true;
          _isSearchExpanded = true;
        }
      });
      return;
    }

    // Show suggestions while typing (before search completes)
    if (_isSearchFocused && !_isSearchExpanded) {
      setState(() {
        _showSuggestions = true;
        _isSearchExpanded = true;
      });
    }

    // Debounce search API call
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String keyword) async {
    if (keyword.isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    try {
      final response = await _searchService.globalSearch(
        keyword: keyword,
        latitude: _latitude,
        longitude: _longitude,
      );

      setState(() {
        _searchResponse = response;
        _isSearching = false;
        // Hide suggestions when search completes
        _showSuggestions = false;
        // If no results, show search helper
        if (!response.status || !_hasResults(response)) {
          _isSearchExpanded = true;
        } else {
          // If results present, collapse expanded view (results shown in scrollable content)
          _isSearchExpanded = false;
        }
      });
    } catch (e) {
      print('Search error: $e');
      setState(() {
        _isSearching = false;
        _searchResponse = null;
      });
    }
  }

  bool _hasResults(SearchResponse response) {
    return response.data.clubs.isNotEmpty ||
        response.data.packages.isNotEmpty ||
        response.data.events.isNotEmpty;
  }

  int _getTabCount(String tab) {
    if (_searchResponse == null) return 0;
    switch (tab) {
      case 'Events':
        return _searchResponse!.data.events.length;
      case 'Venue':
        return _searchResponse!.data.clubs.length;
      case 'Packages':
        return _searchResponse!.data.packages.length;
      case 'Artist':
        return 0; // No artist data in API response
      default:
        return 0;
    }
  }

  void _handleSearchBarTap() {
    // When user clicks on search bar, focus and show suggestions
    if (!_isSearchFocused) {
      setState(() {
        _isSearchFocused = true;
        _showSuggestions = true;
        _isSearchExpanded = true;
        _showHistory = false;
      });
      Future.delayed(Duration(milliseconds: 100), () {
        _searchFocusNode.requestFocus();
      });
    }
  }

  double get _containerHeight {
    if (!_isSearchExpanded) return 76.0;
    if (_showHistory) return 336.0;
    if (_showSuggestions) return 236.0;
    return 224.0; // Search helper height
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Search Container (always visible at top)
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
                                  if (_isSearchFocused)
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
                                        'Search your vibe',
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
            // Scrollable Content (starts below fixed search container)
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Only show "Categorises for you" section when search is complete and results are present
                    if (!_isSearching &&
                        _searchResponse != null &&
                        _hasResults(_searchResponse!))
                      Container(
                        margin: EdgeInsets.only(top: 12),
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
                            SearchBookingTabs(
                              selectedTab: _selectedTab,
                              onTabSelected: (tab) {
                                setState(() {
                                  _selectedTab = tab;
                                });
                              },
                              eventCount: _getTabCount('Events'),
                              venueCount: _getTabCount('Venue'),
                              packageCount: _getTabCount('Packages'),
                              artistCount: _getTabCount('Artist'),
                            ),
                            SizedBox(height: 10),
                            _buildSearchResultsContent(),
                          ],
                        ),
                      ),
                    SizedBox(height: 12),
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
                  _isSearchExpanded = true;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
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
                return GestureDetector(
                  onTap: () {
                    _searchController.text = _suggestions[index];
                    _performSearch(_suggestions[index]);
                  },
                  child: Padding(
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultsContent() {
    if (_searchResponse == null || !_hasResults(_searchResponse!)) {
      return SizedBox.shrink();
    }

    switch (_selectedTab) {
      case 'Events':
        if (_searchResponse!.data.events.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          children: _searchResponse!.data.events.map((event) {
            return EventCard(
              imageUrl: 'assets/images/category1.png', // Placeholder for now
              title: event.name,
              location: '${event.clubName}, ${event.cityName}',
              eventType: event.category,
              date: event.eventDate,
              tagColor: Color(0xff8B7DD8),
              onTap: () {},
            );
          }).toList(),
        );
      case 'Venue':
        if (_searchResponse!.data.clubs.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          children: _searchResponse!.data.clubs.map((club) {
            return EventCard(
              imageUrl: 'assets/images/category1.png', // Placeholder for now
              title: club.name,
              location: '${club.areaName}, ${club.cityName}',
              eventType: club.category,
              date: '${club.distance} km away',
              tagColor: Color(0xff8B7DD8),
              onTap: () {},
            );
          }).toList(),
        );
      case 'Packages':
        if (_searchResponse!.data.packages.isEmpty) {
          return SizedBox.shrink();
        }
        return Column(
          children: _searchResponse!.data.packages.map((pkg) {
            return EventCard(
              imageUrl: 'assets/images/category1.png', // Placeholder for now
              title: pkg.title,
              location: '${pkg.clubName}, ${pkg.cityName}',
              eventType: 'Package',
              date: '${pkg.distance} km away',
              tagColor: Color(0xff8B7DD8),
              onTap: () {},
            );
          }).toList(),
        );
      case 'Artist':
        return SizedBox.shrink();
      default:
        return SizedBox.shrink();
    }
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
  final String selectedTab;
  final Function(String) onTabSelected;
  final int eventCount;
  final int venueCount;
  final int packageCount;
  final int artistCount;

  const SearchBookingTabs({
    super.key,
    this.tabs = const ['Events', 'Venue', 'Packages', 'Artist'],
    required this.selectedTab,
    required this.onTabSelected,
    this.eventCount = 0,
    this.venueCount = 0,
    this.packageCount = 0,
    this.artistCount = 0,
  });

  int _getCount(String tab) {
    switch (tab) {
      case 'Events':
        return eventCount;
      case 'Venue':
        return venueCount;
      case 'Packages':
        return packageCount;
      case 'Artist':
        return artistCount;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = tab == selectedTab;
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: _buildTab(tab, isSelected, context),
          );
        },
      ),
    );
  }

  Widget _buildTab(String tab, bool isSelected, BuildContext context) {
    final count = _getCount(tab);
    return GestureDetector(
      onTap: () => onTabSelected(tab),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff7464E4) : Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tab,
              style: GoogleFonts.lexend(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (count > 0) ...[
              SizedBox(width: 6),

              // Container(
              //   height: 20,
              //   width: 20,
              //   padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              //   decoration: BoxDecoration(
              //     color: isSelected
              //         ? Color(0xffD3CDFF).withOpacity(0.12)
              //         : Color(0xffECECEC),
              //     // borderRadius: BorderRadius.circular(20),
              //     shape: BoxShape.circle,
              //   ),
              //   alignment: Alignment.center,
              //   child: Center(
              //     child: Text(
              //       count.toString(),
              //       style: GoogleFonts.lexend(
              //         color: isSelected ? Colors.white : Color(0xff7464E4),
              //         fontSize: 11,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ),
              // ),
              CircleAvatar(
                radius: 10, // Half of diameter
                backgroundColor: isSelected
                    ? Color(0xffD3CDFF).withOpacity(0.2)
                    : Color(0xffECECEC),
                child: Text(
                  count.toString(),
                  style: GoogleFonts.lexend(
                    color: isSelected ? Colors.white : Color(0xff4F4F4F),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
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
