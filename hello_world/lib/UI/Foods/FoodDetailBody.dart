import 'package:flutter/material.dart';
import '../../Theme.dart' as Theme;
import '../../MODEL/Food.dart';
// import '../../DAO/IngredientsListDao.dart';
import 'FoodRow.dart';

class FoodDetailBody extends StatelessWidget {
  final Food food;

  FoodDetailBody(this.food);

  @override
  Widget build(BuildContext context) {
    final foodThumbnail = Container(
      alignment: Alignment.topCenter,
      child: Hero(
        tag: 'food-icon-${food.name}',
        child: Image(
          image: AssetImage(food.image),
          height: Theme.Dimens.foodHeightDetail,
          width: Theme.Dimens.foodWidthDetail,
        ),
      ),
    );

    final foodCard = Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      decoration: BoxDecoration(
        color: Theme.Colors.foodCard,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black, blurRadius: 10.0, offset: Offset(0.0, 10.0))
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 75.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(food.name, style: Theme.TextStyles.foodTitleDetail),
            Text(food.calorie.toString() + " kcal",
                style: Theme.TextStyles.foodLocationDetail),
            Container(
              color: FoodRow.healthPointColor(food.healthPoint),
              width: 48.0,
              height: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Karbonhidrat",
                          style: Theme.TextStyles.foodDistance),
                      Text(food.carb.toString(),
                          style: Theme.TextStyles.foodDistanceDetail),
                    ],
                  ),
                  Container(width: 24.0),
                  Column(
                    children: <Widget>[
                      Text("Protein", style: Theme.TextStyles.foodDistance),
                      Text(food.protein.toString(),
                          style: Theme.TextStyles.foodDistanceDetail),
                    ],
                  ),
                  Container(width: 24.0),
                  Column(
                    children: <Widget>[
                      Text("Yağ", style: Theme.TextStyles.foodDistance),
                      Text(food.fat.toString(),
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

    final double barHeight = 50.0;
    final double statusbarHeight = MediaQuery.of(context).padding.bottom + 10;

    final double paddingBottom = barHeight + statusbarHeight;

    final foodDescription = Container(
      margin: EdgeInsets.only(right: 30.0, left: 30.0, bottom: paddingBottom),
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Tanım", style: Theme.TextStyles.foodTitle),
            Container(
              color: FoodRow.healthPointColor(food.healthPoint),
              width: 48.0,
              height: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        food.description,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    final top = MediaQuery.of(context).viewInsets.top + 40;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.only(top: top),
          child: Stack(
            children: <Widget>[
              foodCard,
              foodThumbnail,
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2.1,
          child: foodDescription,
        ),
      ],
    );
  }
}
