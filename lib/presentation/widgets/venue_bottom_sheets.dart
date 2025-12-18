import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// Features bottom sheet that slides from bottom
class FeaturesBottomSheet extends StatelessWidget {
  final List<String> features;

  const FeaturesBottomSheet({
    super.key,
    this.features = const [
      'Stage Setup',
      'Lighting Design',
      'Sound Engineering',
      'Rehearsal Schedule',
      'Led Screens',
      'Lawn + Indoor Halls',
      'Custom Decor',
      'Catering Services',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xff4F4F4F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Title
              Text(
                'Features',
                style: GoogleFonts.lexend(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff181818),
                ),
              ),
              const SizedBox(height: 15),
              // Features list
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: features.map((feature) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffF9F9F9).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                      child: Text(
                        feature,
                        style: GoogleFonts.lexend(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff4F4F4F),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context, {List<String>? features}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => FeaturesBottomSheet(
        features:
            features ??
            const [
              'Stage Setup',
              'Lighting Design',
              'Sound Engineering',
              'Rehearsal Schedule',
              'Led Screens',
              'Lawn + Indoor Halls',
              'Custom Decor',
              'Catering Services',
            ],
      ),
    );
  }
}

/// Live Events bottom sheet with date chips
class LiveEventsBottomSheet extends StatelessWidget {
  final List<String> events;

  const LiveEventsBottomSheet({
    super.key,
    this.events = const [
      "17 Sep '25\n7 PM Onwards",
      "18 Sep '25\n7 PM Onwards",
      "19 Sep '25\n7 PM Onwards",
      "20 Sep '25\n7 PM Onwards",
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.77),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xff4F4F4F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Title
              Text(
                'Live Events',
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff070707),
                ),
              ),
              const SizedBox(height: 15),
              // Events list
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: events.map((event) {
                  return Stack(
                    children: [
                      // Background SVG rectangle
                      SvgPicture.asset(
                        'assets/images/Rectangle.svg',
                        width: 109,
                        height: 50,
                      ),
                      // Event text
                      Container(
                        width: 109,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          event,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lexend(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context, {List<String>? events}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => LiveEventsBottomSheet(
        events:
            events ??
            const [
              "17 Sep '25\n7 PM Onwards",
              "18 Sep '25\n7 PM Onwards",
              "19 Sep '25\n7 PM Onwards",
              "20 Sep '25\n7 PM Onwards",
            ],
      ),
    );
  }
}
