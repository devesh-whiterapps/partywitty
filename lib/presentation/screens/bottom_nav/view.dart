import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBloc()..add(BottomNavInitEvent()),
      child: BlocConsumer<BottomNavBloc, BottomNavState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case BottomNavStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case BottomNavStatus.loaded:
              return BottomNavLoadedPage(state: state);
            case BottomNavStatus.error:
              return Scaffold(
                body: Center(child: Text(state.error ?? "An error occurred")),
              );
            default:
              return const Scaffold(body: Center(child: Text("Unknown state")));
          }
        },
      ),
    );
  }
}

class BottomNavLoadedPage extends StatelessWidget {
  BottomNavState state;
  BottomNavLoadedPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: state.screenList![state.selectedIndex ?? 0],
      ),

      
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 30,left: 10,right: 10),
        child: Card(
          shape: StadiumBorder(),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              // color: Colors.amberAccent,
              // borderRadius:  BorderRadius.circular(
              //   50
              // ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withAlpha(20),
              //     blurRadius: 10.0,
              //     spreadRadius: 0.0,
              //     offset: Offset(0.0, -10.0),
              //   ),
              // ],
            ),
          
            child: GNav(
            rippleColor: Colors.deepPurpleAccent, // tab button ripple color when pressed
            hoverColor:  Colors.deepPurpleAccent, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 30, 
            tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
            // tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
            // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 900), // tab animation duration
            gap: 8, // the tab button gap between icon and text 
            color:  Colors.deepPurpleAccent, // unselected icon color
            activeColor: Colors.white, // selected icon and text color
            iconSize: 24, // tab button icon size
            // tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5), // navigation bar padding
            tabs: [
              GButton(
          icon: Icons.home,
          text: 'Home',
          backgroundColor:  Colors.deepPurpleAccent,
          
              ),
              GButton(
          icon: Icons.search,
          text: 'Search',
          backgroundColor:  Colors.deepPurpleAccent,
              ),
              GButton(
          icon: Icons.toc_outlined,
          text: 'Menu',
          backgroundColor:  Colors.deepPurpleAccent,
              ),
              GButton(
          icon: Icons.person_2_outlined,
          text: 'Profile',
          backgroundColor:  Colors.deepPurpleAccent,
              )
            ]
          )
          ),
        ),
      ),
    );
  }
}
