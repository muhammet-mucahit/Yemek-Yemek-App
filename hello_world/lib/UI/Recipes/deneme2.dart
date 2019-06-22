import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'PageTransformer.dart';
import '../../MODEL/Recipe.dart';
import '../../Routes.dart';
import 'package:fluro/fluro.dart';
// import '../../DAO/FavoritesDao.dart';

class RecipeItem extends StatefulWidget {
  RecipeItem({
    @required this.recipe,
    @required this.pageVisibility,
  });

  final Recipe recipe;
  final PageVisibility pageVisibility;

  @override
  _RecipeItemState createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation =
        widget.pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: widget.pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  // Widget favorite(item) {
  //   final bool alreadySaved = FavoritesDao.saved.contains(item);
  //   return IconButton(
  //     icon: Icon(
  //       alreadySaved ? Icons.favorite : Icons.favorite_border,
  //       color: alreadySaved ? Colors.white : null,
  //     ),
  //     onPressed: () {
  //       setState(() {
  //         if (alreadySaved) {
  //           FavoritesDao.saved..remove(widget.recipe);
  //         } else {
  //           FavoritesDao.saved.add(widget.recipe);
  //         }
  //       });
  //     },
  //     color: Colors.white,
  //   );
  // }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        widget.recipe.name,
        style: textTheme.caption.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
          fontSize: 24.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Text(
          widget.recipe.calorie.toString() + " kcal",
          style: textTheme.title
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
          // favorite(widget.recipe),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      widget.recipe.image,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (widget.pageVisibility.pagePosition),
        0.5,
      ),
    );

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            const Color(0xF0000000),
            const Color(0x0F000000),
            const Color(0xFF000000),
          ],
        ),
      ),
    );

    _navigateTo(context, int id) {
      Routes.navigateTo(context, '/detailRecipe/$id',
          transition: TransitionType.fadeIn);
    }

    return FlatButton(
      onPressed: () => _navigateTo(context, widget.recipe.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              image,
              imageOverlayGradient,
              _buildTextContainer(context),
            ],
          ),
        ),
      ),
    );
  }
}
