import 'package:flutter/material.dart';
import '../../MODEL/Food.dart';
import '../../Theme.dart' as Theme;
import '../../Routes.dart';
import 'package:fluro/fluro.dart';

class FoodRow extends StatelessWidget {
  final Food food;

  FoodRow(this.food);

  static Color healthPointColor(int healthPoint) {
    if (healthPoint > 4) {
      return Colors.green;
    } else if (healthPoint > 3) {
      return Colors.lightGreen;
    } else if (healthPoint > 2) {
      return Colors.yellow;
    } else if (healthPoint > 1) {
      return Colors.orange;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final foodThumbnail = Container(
      alignment: FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 8.0),
      child: Hero(
        tag: 'food-icon-${food.name}',
        child: Image(
          image: AssetImage(food.image),
          height: Theme.Dimens.foodWidth,
          width: Theme.Dimens.foodWidth,
        ),
      ),
    );

    final foodCard = Container(
      margin: const EdgeInsets.only(left: 48.0, right: 24.0),
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
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(food.name, style: Theme.TextStyles.foodTitle),
            Text(food.calorie.toString() + " kcal",
                style: Theme.TextStyles.foodLocation),
            Container(
              color: healthPointColor(food.healthPoint),
              width: 24.0,
              height: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
          ],
        ),
      ),
    );

    return Container(
      margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: FlatButton(
        onPressed: () => _navigateTo(context, food.name),
        child: Stack(
          children: <Widget>[
            foodCard,
            foodThumbnail,
          ],
        ),
      ),
    );
  }

  _navigateTo(context, String name) {
    Routes.navigateTo(context, '/detailFood/$name',
        transition: TransitionType.fadeIn);
  }
}
