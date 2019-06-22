import 'package:flutter/material.dart';
import '../../MODEL/Recipe.dart';
import '../../Theme.dart' as Theme;
import '../../Routes.dart';
import 'package:fluro/fluro.dart';
import '../../DAO/FoodDao.dart';

class RecipeDetailBody extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailBody(this.recipe);

  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      recipe.image,
      fit: BoxFit.cover,
    );

    var imageOverlay = Opacity(
      opacity: 0.8,
      child: Container(
        color: Colors.black,
      ),
    );

    final recipeCard = Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.white),
      ),
      child: Container(
        alignment: Alignment.topCenter,
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text(
              recipe.name,
              style: Theme.TextStyles.foodTitle,
              textAlign: TextAlign.center,
            ),
            Text(recipe.calorie.toString() + " kcal",
                style: Theme.TextStyles.foodLocationDetail),
            Container(
              color: const Color(0xFF00C6FF),
              width: 48.0,
              height: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Karbonhidrat",
                          style: Theme.TextStyles.foodDistance),
                      Text(recipe.carb.toString(),
                          style: Theme.TextStyles.foodDistanceDetail),
                    ],
                  ),
                  Container(width: 24.0),
                  Column(
                    children: <Widget>[
                      Text("Protein", style: Theme.TextStyles.foodDistance),
                      Text(recipe.protein.toString(),
                          style: Theme.TextStyles.foodDistanceDetail),
                    ],
                  ),
                  Container(width: 24.0),
                  Column(
                    children: <Widget>[
                      Text("Yağ", style: Theme.TextStyles.foodDistance),
                      Text(recipe.fat.toString(),
                          style: Theme.TextStyles.foodDistanceDetail),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: const Color(0xFF00C6FF),
                      ),
                      Text(recipe.cookingMinutes.toString() + "dk",
                          style: Theme.TextStyles.foodDistanceDetail),
                    ],
                  ),
                  Container(width: 24.0),
                  Column(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        color: const Color(0xFF00C6FF),
                      ),
                      Text(recipe.rating.toString(),
                          style: Theme.TextStyles.foodDistanceDetail),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final recipeDescription = Container(
      margin: EdgeInsets.only(left: 22.5, right: 22.5, bottom: 90.0),
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("Hazırlanış", style: Theme.TextStyles.foodTitle),
            Container(
              color: const Color(0xFF00C6FF),
              width: 96.0,
              height: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      recipe.description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    _navigateTo(context, String name) {
      Routes.navigateTo(context, '/detailFood/$name',
          transition: TransitionType.fadeIn);
    }

    final recipeIngredients = Container(
      height: 80.0,
      child: new FutureBuilder(
          future: FoodDao.getIngredients(recipe.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Center(
                child: new CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }
            List ingredients = snapshot.data;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemExtent: 85.0,
              itemCount: ingredients.length,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.white54),
                  ),
                  child: ListTile(
                    title: Image(
                      image: AssetImage(ingredients[index].image),
                    ),
                    onTap: () => _navigateTo(context, ingredients[index].name),
                  ),
                );
              },
            );
          }),
    );

    final top = MediaQuery.of(context).viewInsets.top + 50;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        image,
        imageOverlay,
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2.4,
              margin: EdgeInsets.only(top: top),
              child: recipeCard,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.0,
              child: recipeDescription,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: recipeIngredients,
        ),
      ],
    );
  }
}
