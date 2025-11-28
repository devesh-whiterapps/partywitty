import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../gen/assets.gen.dart';
import '../../resources/image_assets.dart';
import '../../resources/style_manager.dart';
import '../../widgets/post_card.dart';
import 'bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    final width = MediaQuery.of(context).size.width;

    const bgUrl =
        "https://images.pexels.com/photos/207983/pexels-photo-207983.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";

    return Scaffold(
      backgroundColor: const Color(0xFFE9EBDC).withOpacity(0.4),

      appBar: AppBar(
        backgroundColor: Colors.white.withAlpha(10),
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Assets.appLogo.image(scale: 0.9),
        ),
        title: Transform.translate(
          offset: const Offset(-10, -4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                ),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.8,
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.locationIc.image(),
                        const SizedBox(width: 8),
                        Text(
                          "Vasant Kunj",
                          style: GoogleFonts.lexend(
                              fontSize: 10,
                              color: Colors.black54
                          ),
                        ),
                        const SizedBox(width: 4),
                        Assets.arrowDownIc.image(),
                      ],
                    ),
                  ),
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -7),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Asant Kunj Comes Under ...",
                    style: GoogleFonts.lexend(
                        fontSize: 10,
                        color: Colors.black54
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Transform.translate(
                offset: const Offset(0, -6), // ← Icon को ऊपर ले गया
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Assets.bellIc.image(),
                ),
              ),
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          Positioned.fill(child: Assets.bgImg.image(fit: .fill)),

          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.only(bottom: 18),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.30),
                        width: 1.2,
                      ),
                    ),

                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            if (index < (state.feedList?.length ?? 0)) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 3,
                                ), // reduced gap
                                child: PostCard(
                                  width: width,
                                  data: state.feedList![index],
                                ),
                              );
                            }
                            return null;
                          }, childCount: state.feedList?.length ?? 0),
                        ),

                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Party Packages',
                                      style: GoogleFonts.lexend(
                                        fontSize: 16,
                                        color: Colors.black
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          Text(
                                            'View all',
                                           style: GoogleFonts.lexend(fontSize: 14,
                                           color: Colors.black
                                           ),
                                          ),
                                          const SizedBox(width: 4),
                                         Assets.arrowRight2Ic.image()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                SizedBox(
                                  height: 170,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          right: 6,
                                        ),
                                        child: Container(
                                          width: 170,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              0,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                ImgAssets.drinks,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Imported Drinks Food',
                                                style: getRegular14Style(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '(199+)',
                                                style: getRegular14Style(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
