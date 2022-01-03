import 'dart:convert';
import 'package:coins/src/utils/app_config.dart';
import 'package:coins/src/watchlist/model/watchlist_model.dart';
import 'package:http/http.dart' as http;

class WatchlistNetworkProvider{
  Future<WatchlistModel> fetchWatchlistData() async{
    try{
      final response = await http.get(Uri.parse("$URL$watchlist"));

      if(response.statusCode == 200){
        return WatchlistModel.fromJson(json.decode(response.body));
        //return WatchlistModel.fromJson({});
      }
      else{
        return WatchlistModel.fromJson({});
      }
    }
    catch(error){
      return WatchlistModel.fromJson({});
    }
  }
}