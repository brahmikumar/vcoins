import 'package:intl/intl.dart';

class WatchlistModel{
  List<_Watchlist> _results = [];

  WatchlistModel.fromJson(Map<dynamic, dynamic> parsedJson){
    List<_Watchlist> temp = [];
    if (parsedJson.isNotEmpty) {
      for (int i = 0; i < parsedJson["data"].length; i++) {
        _Watchlist result = _Watchlist(parsedJson["data"][i]);
        temp.add(result);
      }
      _results = temp;
    }
  }
  List<_Watchlist> get results => _results;
}


class _Watchlist{
  late String _stockName;
  late double  _price;
  late double _dayGain;
  late double _lastPrice;
  late String _lastTrade;
  late String _extendedHours;
  late String _change;
  late bool _isLose;

  _Watchlist(results){
    _price = results['price']??0.0;
    _dayGain = results['dayGain']??0.0;
    _lastPrice = results['lastPrice']??0.0;
    _lastTrade = getTimeFormMilliSeconds(results['lastTrade']??"");
    _extendedHours = getTimeFormMilliSeconds(results['extendedHours']??"");
    _stockName = results['stockName']??"";
    _change = percentageChange(results['price']??0, results['lastPrice']??0);
    _isLose = (results['price']-results['lastPrice']).isNegative;
  }

  double get price => _price;
  double get dayGain => _dayGain;
  double get lastPrice => _lastPrice;
  String get lastTrade => _lastTrade;
  String get extendedHours => _extendedHours;
  String get stockName => _stockName;
  String get change => _change;
  bool get isLose => _isLose;
}

getTimeFormMilliSeconds(date){
  try{
    return DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(int.parse(date))).toString();
  }
  catch(error){
    return "";
  }
}

percentageChange(newVal, oldVal){
  return (((newVal-oldVal)/oldVal)*100).toStringAsFixed(2);
}
