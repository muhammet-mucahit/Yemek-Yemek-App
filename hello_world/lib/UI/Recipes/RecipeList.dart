import 'package:flutter/material.dart';
import "RecipeItem.dart";
// import "PageTransformer.dart";
import '../../MODEL/Recipe.dart';
import '../../Theme.dart' as Theme;
import '../../DAO/FavoritesDao.dart';

class RecipeList extends StatefulWidget {
  final List<Recipe> recipes;
  final title;

  RecipeList(this.recipes, this.title);

  @override
  RecipeListState createState() => RecipeListState();
}

class RecipeListState extends State<RecipeList> {
  @override
  void dispose() {
    FavoritesDao.postFavorites();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: Theme.TextStyles.appBarTitle,
        ),
      ),
      body: Container(
        color: Theme.Colors.foodPageBackground,
        child: widget.recipes.length == 0
            ? Center(
                child: Text(
                  widget.title + " Boş!",
                  style: Theme.TextStyles.appBarTitle,
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                ),
                padding: EdgeInsets.symmetric(vertical: 5.0),
                itemCount: widget.recipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecipeItem(
                    recipe: widget.recipes[index],
                    parent: this,
                  );
                },
              ),
        // Center(
        //   child: SizedBox.fromSize(
        //     size: const Size.fromHeight(750.0),
        //     child: PageTransformer(
        //       pageViewBuilder: (context, visibilityResolver) {
        //         return PageView.builder(
        //           controller: PageController(viewportFraction: 1.0),
        //           itemCount: widget.recipes.length,
        //           itemBuilder: (context, index) {
        //             final recipe = widget.recipes[index];
        //             final pageVisibility =
        //                 visibilityResolver.resolvePageVisibility(index);

        //             return RecipeItem(
        //               recipe: recipe,
        //               pageVisibility: pageVisibility,
        //             );
        //           },
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
