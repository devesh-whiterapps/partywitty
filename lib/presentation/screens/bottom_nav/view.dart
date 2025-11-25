import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../gen/assets.gen.dart';
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
        padding: const EdgeInsets.only(bottom: 60.0),
        child: state.screenList![state.selectedIndex ?? 0],
      ),

      floatingActionButtonLocation: .miniCenterFloat,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0), // Rounded corners for the container
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(50),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Margin for the container
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context,0, Assets.homeIc.path, 'Home'),
            _buildNavItem(context,1, Assets.searchIc.path, 'Search'),
            _buildNavItem(context,2,Assets.bidIc.path, 'Gavel'),
            _buildNavItem(context,3, Assets.bookingIc.path, 'Bookmark'),
            _buildNavItem(context,4,Assets.moreIc.path, 'More'),
          ],
        ),
      ),
        );
    
  }

  Widget _buildNavItem(BuildContext context, int index, String icon, String label) {
    final bool isSelected = state.selectedIndex == index;
    return GestureDetector(
      onTap: () {context.read<BottomNavBloc>().add(onItemTappedEvent(selectedIndex: index));},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: isSelected
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)], // Purple gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
              )
            : null,
        child: Row(
          children: [
            Image.asset(icon,color: isSelected ? Colors.white : Colors.deepPurple,),
            // Icon(
            //   icon,
            //   color: isSelected ? Colors.white : Colors.deepPurple,
            // ),
            if (isSelected) const SizedBox(width: 8.0),
            if (isSelected)
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

}


