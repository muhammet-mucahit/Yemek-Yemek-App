import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../MODEL/Recipe.dart';
import '../../Routes.dart';
import 'package:fluro/fluro.dart';
import '../../DAO/FavoritesDao.dart';
import '../../DAO/RecipeDao.dart';
import 'RecipeList.dart';

class RecipeItem extends StatefulWidget {
  RecipeItem({
    @required this.recipe,
    @required this.parent,
  });

  final Recipe recipe;
  final RecipeListState parent;

  @override
  _RecipeItemState createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  // @override
  // void dispose() {
  //   // FavoritesDao.postFavorites();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      widget.recipe.image,
      fit: BoxFit.cover,
      alignment: Alignment.center,
    );

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            const Color(0x0F000000),
            const Color(0xA0000000),
          ],
        ),
      ),
    );

    _navigateTo(context, int id) {
      Routes.navigateTo(context, '/detailRecipe/$id',
          transition: TransitionType.fadeIn);
    }

    Widget favorite(Recipe item) {
      final bool alreadySaved = FavoritesDao.favoritesIds.contains(item.id);
      return IconButton(
        icon: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.white : null,
        ),
        onPressed: () {
          widget.parent.setState(() {});
          setState(
            () {
              if (alreadySaved) {
                FavoritesDao.favoritesIds.remove(item.id);
                FavoritesDao.favorites
                    .remove(FavoritesDao.getRecipeById(item.id));
                for (int i = 0; i < FavoritesDao.favoritesIds.length; i++)
                  print(FavoritesDao.favoritesIds[i]);
                print("");
                for (int i = 0; i < FavoritesDao.favorites.length; i++)
                  print(FavoritesDao.favorites[i].name);
                print("");
              } else {
                FavoritesDao.favoritesIds.add(item.id);
                FavoritesDao.favorites
                    .add(RecipeDao.getRecipeById(item.id.toString()));
                for (int i = 0; i < FavoritesDao.favoritesIds.length; i++)
                  print(FavoritesDao.favoritesIds[i]);
                print("");
              }
              // FavoritesDao.asd();
            },
          );
        },
        color: Colors.white,
      );
    }

    return FlatButton(
      onPressed: () => _navigateTo(context, widget.recipe.id),
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            image,
            imageOverlayGradient,
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                widget.recipe.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: favorite(widget.recipe),
            ),
          ],
        ),
      ),
    );
  }
}
