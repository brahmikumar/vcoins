import 'package:coins/src/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:coins/src/watchlist/bloc/watchlist.bloc.dart';
import 'package:coins/src/watchlist/model/watchlist_model.dart';
import 'package:coins/src/widgets/bottomnavigation.dart';
import 'package:coins/src/utils/app_config.dart';

class Watchlist extends StatefulWidget {
  static const routeName = '/watchlist';
  const Watchlist({Key? key}) : super(key: key);

  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watchlistBloc.fetchAllWatchlistData();
  }

  Future<void> _updateWatchList() async{
    watchlistBloc.fetchAllWatchlistData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Watchlist"),
      ),
      body: RefreshIndicator(
        onRefresh: _updateWatchList,
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: watchlistBloc.allWatchlistData,
            builder: (context, AsyncSnapshot<WatchlistModel>snapshot){
              if(snapshot.hasData){
                return (snapshot.data!.results.isNotEmpty) ?
                 Column(
                  children: [
                    ListView.builder(
                      itemCount: snapshot.data?.results.length,
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${snapshot.data?.results[index].stockName}", style: Theme.of(context).textTheme.subtitle1,),
                                      const SizedBox(height:10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Price", style: Theme.of(context).textTheme.caption),
                                          Text("${snapshot.data?.results[index].price}")
                                        ],
                                      ),
                                      const SizedBox(height:5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Day gain", style: Theme.of(context).textTheme.caption),
                                          //Text("${snapshot.data?.results[index].dayGain}")
                                          Text("${snapshot.data?.results[index].price} - ${snapshot.data?.results[index].lastPrice}")
                                        ],
                                      ),
                                      const SizedBox(height:5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Last trade", style: Theme.of(context).textTheme.caption),
                                          Text("${snapshot.data?.results[index].lastTrade}")
                                        ],
                                      ),
                                      const SizedBox(height:5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Extended hrs", style: Theme.of(context).textTheme.caption),
                                          Text("${snapshot.data?.results[index].extendedHours}")
                                        ],
                                      ),
                                      const SizedBox(height:5),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("% Change", style: Theme.of(context).textTheme.caption),
                                          Row(
                                            children: [
                                              (snapshot.data?.results[index].isLose == true) ?
                                                const Icon(Icons.arrow_drop_down_sharp, color: Colors.red,)
                                              :
                                              const Icon( Icons.arrow_drop_up, color: Colors.green),
                                              Text("${snapshot.data?.results[index].change}%",
                                              style: TextStyle(color: (snapshot.data?.results[index].isLose == true) ? Colors.red : Colors.green )),
                                            ],
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  ],
                )
                :
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: Center(
                    child: Text("No Data Available",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    ListView.builder(
                        itemCount: 8,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ShimmerBlock(200, 10),
                                        const SizedBox(height:15),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ShimmerBlock(100, 10),
                                            ShimmerBlock(100, 10),
                                          ],
                                        ),
                                        const SizedBox(height:15),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ShimmerBlock(100, 10),
                                            ShimmerBlock(100, 10),                                          ],
                                        ),
                                        const SizedBox(height:15),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ShimmerBlock(100, 10),
                                            ShimmerBlock(100, 10),                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),

        ),
      ),
      bottomNavigationBar: BottomNavigation(Tabs.WATCHLIST),
    );
  }
}
