import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'Routes.dart';
import 'Theme.dart' as Theme;
import 'UI/Login/login.dart';
import 'MyHomePage.dart';
import 'DAO/RecipeDao.dart';
import 'DAO/FoodDao.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TITLE = "Yemek Yemek";
String key = "111";

var cameras = List();

Future<void> main() async {
  FoodDao.getFoods();
  RecipeDao.getRecipes();
  // FavoritesDao.getFavorites();
  // FavoritesDao.getApirioriAdvices();
  cameras = await availableCameras();
  Routes.initRoutes();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String mail = "";

  @override
  void initState() {
    super.initState();
    _getMailPreference();
  }

  _getMailPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      mail = (prefs.getString(key) ?? null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: TITLE,
      theme: ThemeData(
        primaryColor: Theme.Colors.foodCard,
      ),
      // home: MyHomePage(),
      home: mail == null ? LoginPage() : MyHomePage(),
    );
  }
}
