import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partywitty/presentation/resources/image_assets.dart';
import 'package:partywitty/presentation/resources/style_manager.dart';
import 'package:partywitty/presentation/widgets/post_card.dart';

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
        listener: (context, state) {
        },
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case HomeStatus.loaded:
              return HomeLoadedPage(state1: state);
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
  HomeState state1;
  HomeLoadedPage({super.key, required this.state1});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FlutterLogo(),
        ),

        title: Column(
          children: [
            TextButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 5),
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 10),
                  child: Row(
                    mainAxisSize: .min,
                    children: [
                      Icon(Icons.location_pin, color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        "Vasant Kunj",
                        style: getRegular10Style(color: Colors.black),
                      ),
                      SizedBox(width: 5),
                  
                      Icon(Icons.arrow_drop_down, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "Vasant Kunj Comes Under ...",
              style: getRegular10Style(color: Colors.black),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton.outlined(
              onPressed: () {},
              icon: Container(
                padding: EdgeInsets.all(5),

                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), 
                      spreadRadius: 5, 
                      blurRadius: 7, 
                      offset: Offset(0, 3), 
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.notifications),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      
      child: CustomScrollView(
        
        slivers: <Widget>[
          
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                
                if (index < (state.feedList?.length ?? 0)) {
                  
                  return PostCard(width: width, data: state.feedList![index]);
                }
                return null; 
              },
              
              childCount: state.feedList?.length ?? 0,
            ),
          ),

          
          SliverToBoxAdapter(
            child: Container(
              
              height: 400.0, 
              color: Colors.white, 
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: .spaceBetween,
                     children: [
                       Text(
                        'Party Packages',
                        style: getBold16Style(color: Colors.black),
                                         ),
                                         TextButton(onPressed: (){}, child: Text(
                        'View All ->',
                        style: getBold16Style(color: Colors.black),))
                     ],
                   ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: ListView.builder(
                      
                      scrollDirection: Axis.horizontal,
                      itemCount: 10, 
                      itemBuilder: (context, index) {
                       
                        return Container(
                          width: 170.0, 
                          margin: const EdgeInsets.only(right: 10.0,),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage(ImgAssets.drinks),fit: .cover)
                            // borderRadius: BorderRadius.circular(8.0),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: .min,
                            children: [
                              Text('Imported Drinks Food',style: getRegular14Style(color: Colors.white)),
                              Text('(199+)',style: getRegular14Style(color: Colors.white)),
                            ],
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
    )
    );
  }
}
