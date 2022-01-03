import 'package:coins/src/utils/app_config.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  int tabIndex;
  BottomNavigation(this.tabIndex, {Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  void selectPage(int index) {
    if(index == Tabs.WATCHLIST && (ModalRoute.of(context)?.settings.name != "/")){
      Navigator.pop(context);
    }
    else if(index == Tabs.PROFILE){
      if(ModalRoute.of(context)?.settings.name != "/profile") {
        Navigator.pushNamed(context, "/profile" );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        currentIndex: widget.tabIndex,
        type: BottomNavigationBarType.fixed,// this will be set when a new tab is tapped
        iconSize: 30.0,
        onTap: selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
