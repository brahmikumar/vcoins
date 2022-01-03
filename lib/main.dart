import 'package:coins/src/profile/screens/profile.dart';
import 'package:coins/src/watchlist/screens/watchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coins',
      theme: ThemeData(
        primaryColor: const Color(0xff171734),
        scaffoldBackgroundColor: const Color(0xff171734),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          elevation:0,
          iconTheme: new IconThemeData(color: Color(0xff171734)),
          color: const Color(0xff171734),
          //titleSpacing: 0,
          titleTextStyle: const TextStyle(
              color:Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold
          ),
        ),
        fontFamily: 'TestFoundersGrotesk',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 18.0, color: Colors.white),
          caption: TextStyle(fontSize: 18.0, color: Color(0xffD2D2D2)),
          subtitle1: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Color(0xffA1A1A1)),
          fillColor: Color(0xffA1A1A1),
          focusColor: Color(0xffA1A1A1),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
          ),
          border: OutlineInputBorder(),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xff171734),
        ),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
            color: Theme.of(context).primaryColor
        ),
        backgroundColor: Theme.of(context).primaryColor,
        bottomAppBarColor: Theme.of(context).primaryColor,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
              color: Theme.of(context).primaryColor
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black87,
            primary: Color(0xffFFC700),
            minimumSize: Size(88, 56),
            padding: EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xff171734),
          unselectedItemColor:Color(0xff6A6A7D),
          selectedItemColor:Color(0xffFFB802),
          selectedLabelStyle: TextStyle(
              color: Color(0xffFFB802), fontSize: 18.0),
          unselectedLabelStyle: TextStyle(
              color: Color(0xff6A6A7D), fontSize: 18.0),
          elevation: 0,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color(0xff171734),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0)),
          ),
        ),
        cardTheme: CardTheme(
          color: const Color(0xff1E1E3D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            minimumSize: const Size(18, 10),
            textStyle: const TextStyle(
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Theme.of(context).primaryColor),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/' : (context) => const Watchlist(),
        Watchlist.routeName : (context) => const Watchlist(),
        Profile.routeName : (context) => const Profile(),
      },
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


