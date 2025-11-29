import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:partywitty/domain/entities/feed/feed_item.dart';
import 'package:partywitty/presentation/widgets/feed_card.dart/view.dart';
import '../../../gen/assets.gen.dart';
import '../../resources/image_assets.dart';
import '../../resources/style_manager.dart';
import '../../widgets/post_card.dart';
import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(HomeInitEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case HomeStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case HomeStatus.loaded:
              return HomeLoadedPage();
            case HomeStatus.error:
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

class HomeLoadedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE9EBDC).withOpacity(0.4),

      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   automaticallyImplyLeading: false,
      //   centerTitle: false,
      //   leading: Container(
      //     margin: const EdgeInsets.only(left: 10),
      //     child: Assets.appLogo.image(scale: 0.9),
      //   ),
      //   title: Transform.translate(
      //     offset: const Offset(-10, -4),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         TextButton(
      //           onPressed: () {},
      //           style: ElevatedButton.styleFrom(
      //             padding: const EdgeInsets.symmetric(horizontal: 5),
      //           ),
      //           child: Card(
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(0),
      //             ),
      //             child: Padding(
      //               padding: const EdgeInsets.symmetric(
      //                 vertical: 2.8,
      //                 horizontal: 8,
      //               ),
      //               child: Row(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   Assets.locationIc.image(),
      //                   const SizedBox(width: 8),
      //                   Text(
      //                     "Vasant Kunj",
      //                     style: GoogleFonts.lexend(
      //                         fontSize: 10,
      //                         color: Colors.black54
      //                     ),
      //                   ),
      //                   const SizedBox(width: 4),
      //                   Assets.arrowDownIc.image(),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),

      //         Transform.translate(
      //           offset: const Offset(0, -7),
      //           child: Padding(
      //             padding: const EdgeInsets.only(left: 10),
      //             child: Text(
      //               "Asant Kunj Comes Under ...",
      //               style: GoogleFonts.lexend(
      //                   fontSize: 10,
      //                   color: Colors.black54
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),

      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.only(right: 8.0),
      //       child: IconButton(
      //         onPressed: () {},
      //         icon: Transform.translate(
      //           offset: const Offset(0, -6), // ← Icon को ऊपर ले गया
      //           child: Container(
      //             padding: const EdgeInsets.all(8),
      //             decoration: BoxDecoration(color: Colors.white),
      //             child: Assets.bellIc.image(),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
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

                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
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
                                            color: Colors.black54,
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
                                      color: Colors.black54,
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
                                offset: const Offset(
                                  0,
                                  -6,
                                ), // ← Icon को ऊपर ले गया
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Assets.bellIc.image(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      body: PagingListener(
                        controller: state.paginationController!,
                        builder: (context, state, fetchNextPage) =>
                            PagedListView<int, HomeItemModel>(
                              physics: BouncingScrollPhysics(),
                              cacheExtent: 80000,
                              state: state,
                              fetchNextPage: fetchNextPage,
                              builderDelegate: PagedChildBuilderDelegate(
                                itemBuilder: (context, item, index) =>
                                    RepaintBoundary.wrap(
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 3,
                                        ), // reduced gap
                                        child: FeedCardPage(
                                          key: ValueKey(index),
                                          width: width,
                                          item: item,
                                        ),
                                      ),
                                      index,
                                    ),
                              ),
                            ),
                      ),
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

//  ListView.builder(
//                       // itemExtent: 700,
//                       itemCount: state.feedList!.length,
//                       itemBuilder: (context,index){
//                        return Padding(
//                                 padding: const EdgeInsets.only(
//                                   bottom: 3,
//                                 ), // reduced gap
//                                 child: FeedCardPage(
//                                   width: width,
//                                   item: state.feedList![index],
//                                 ),
//                               );
//                     })
