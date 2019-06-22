import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/Foods/FoodList.dart';
import 'Theme.dart' as Theme;
import 'UI/Recipes/RecipeList.dart';
import 'DAO/RecipeDao.dart';
import 'DAO/FoodDao.dart';
import 'UI/Login/login.dart';
import 'UI/Camera/camera.dart';
import 'UI/Ingredients/ingredients.dart';
import 'DAO/FavoritesDao.dart';
import 'main.dart';

class MyDrawer extends StatelessWidget {
  Widget logo() {
    return Image(
      image: AssetImage("lib/assets/logo.png"),
    );
  }

  _saveMailPreference(String mail) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, mail);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: logo(),
            ),
            decoration: BoxDecoration(
              color: Theme.Colors.foodCard,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, size: 24.0),
            title: Text(
              'Anasayfa',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_camera, size: 24.0),
            title: Text(
              'Akıllı Tarama',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Camera()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood, size: 24.0),
            title: Text(
              'Besinler',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              // FoodDao.getFoods();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FoodList(FoodDao.foods);
                    // if (foods.isNotEmpty)
                    //   return FoodList(FoodDao.foods);
                    // else
                    //   return FutureBuilder(
                    //     future: FoodDao.getFoods(),
                    //     builder: (context, snapshot) {
                    //       if (!snapshot.hasData)
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       List foods = snapshot.data;
                    //       return FoodList(foods);
                    //     },
                    //   );
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_dining, size: 24.0),
            title: Text(
              'Tarifler',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RecipeList(RecipeDao.recipes, "Yemek Tarifleri");
                    // return RecipeList(RecipeDao.recipes);
                    // if (recipes.isNotEmpty)
                    //   return new RecipeList(RecipeDao.recipes);
                    // else
                    // return new FutureBuilder(
                    //   future: RecipeDao.getRecipes(),
                    //   builder: (context, snapshot) {
                    //     if (!snapshot.hasData)
                    //       return new Center(
                    //         child: new CircularProgressIndicator(),
                    //       );
                    //     List recipes = snapshot.data;
                    //     return RecipeList(recipes);
                    //   },
                    // );
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list, size: 24.0),
            title: Text(
              'İçindekiler',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Ingredients();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, size: 24.0),
            title: Text(
              'Favoriler',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return RecipeList(FavoritesDao.favorites, "Favoriler");
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.grade, size: 24.0),
            title: Text(
              'Size Özel',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              // Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) {
              //       return Container(
              //         color: Theme.Colors.foodCard,
              //         child: Center(
              //           child: CircularProgressIndicator(),
              //         ),
              //       );
              //     },
              //   ),
              // );
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FutureBuilder(
                      future: FavoritesDao.getApirioriAdvices(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            color: Theme.Colors.foodCard,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          List apriori = snapshot.data;
                          return RecipeList(apriori, "Size Özel");
                        }
                      },
                    );
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new, size: 24.0),
            title: Text(
              'Çıkış',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
            onTap: () {
              FavoritesDao.favorites = List();
              FavoritesDao.favoritesIds = List();
              FavoritesDao.apirioriFavorites = List();
              _saveMailPreference(null);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
