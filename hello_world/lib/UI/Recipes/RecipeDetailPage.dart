import 'package:flutter/material.dart';
import '../../MODEL/Recipe.dart';
import '../../DAO/RecipeDao.dart';
import 'RecipeDetailBody.dart';
import '../../Theme.dart' as Theme;
import '../DetailAppBar.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage(String id) : recipe = RecipeDao.getRecipeById(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.Colors.foodPageBackground,
      body: Stack(
        children: <Widget>[
          RecipeDetailBody(recipe),
          DetailAppBar(),
        ],
      ),
    );
  }
}
