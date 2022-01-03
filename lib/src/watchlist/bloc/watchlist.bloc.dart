import 'package:coins/src/watchlist/model/watchlist_model.dart';
import 'package:coins/src/watchlist/provider/watchlist_provider.dart';
import 'package:rxdart/rxdart.dart';

class WatchlistBloc{
  final watchlistProvider = WatchlistNetworkProvider();
  final _watchlistController = PublishSubject<WatchlistModel>();

  Stream<WatchlistModel> get allWatchlistData => _watchlistController.stream;

  fetchAllWatchlistData() async{
    WatchlistModel watchlistModel = await watchlistProvider.fetchWatchlistData();
    _watchlistController.sink.add(watchlistModel);
  }

  dispose(){
    _watchlistController.close();
  }
}

final watchlistBloc = WatchlistBloc();