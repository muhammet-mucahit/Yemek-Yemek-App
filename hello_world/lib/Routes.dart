import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'UI/Foods/FoodDetailPage.dart';
import 'UI/Recipes/RecipeDetailPage.dart';

class Routes {
  static final Router _router = Router();

  static var foodDetailHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    // debugPrint(params["name"]
    //     .toString()
    //     .substring(1, params["name"].toString().length - 1));
    return FoodDetailPage(params["name"]
        .toString()
        .substring(1, params["name"].toString().length - 1));
  });

  static var recipeDetailHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return RecipeDetailPage(params["id"]
        .toString()
        .substring(1, params["id"].toString().length - 1));
  });

  static void initRoutes() {
    _router.define("/detailFood/:name", handler: foodDetailHandler);
    _router.define("/detailRecipe/:id", handler: recipeDetailHandler);
  }

  static void navigateTo(context, String route, {TransitionType transition}) {
    _router.navigateTo(context, route, transition: transition);
  }
}
