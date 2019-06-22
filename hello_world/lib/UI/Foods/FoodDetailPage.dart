import 'package:flutter/material.dart';
import '../../MODEL/Food.dart';
import '../../DAO/FoodDao.dart';
import '../DetailAppBar.dart';
import 'FoodDetailBody.dart';
import '../../Theme.dart' as Theme;
import '../../DAO/IngredientsListDao.dart';

const MAX_INGREDIENTS = 10;

class FoodDetailPage extends StatelessWidget {
  final Food food;

  FoodDetailPage(String name) : food = FoodDao.getFoodByName(name);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final String title = "Tarif Listesine Ekle";
    final double barHeight = 50.0;
    final double statusbarHeight = MediaQuery.of(context).padding.bottom;

    List<Color> healthPointButtonColor() {
      if (food.healthPoint > 4)
        return [Colors.green[700], Colors.green];
      else if (food.healthPoint > 3)
        return [Colors.lightGreen, Colors.lightGreen[500]];
      else if (food.healthPoint > 2)
        return [Colors.yellow, Colors.yellow[700]];
      else if (food.healthPoint > 1)
        return [Colors.orange, Colors.orangeAccent];
      return [Colors.red, Colors.redAccent];
    }

    void showInSnackBar(String value, Color color) {
      FocusScope.of(context).requestFocus(new FocusNode());
      _scaffoldKey.currentState?.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(
        new SnackBar(
          content: new Text(
            value,
            textAlign: TextAlign.center,
            style: Theme.TextStyles.snackBar,
          ),
          backgroundColor: color,
          duration: Duration(seconds: 3),
        ),
      );
    }

    final addButton = new Container(
      alignment: Alignment.bottomCenter,
      height: statusbarHeight + barHeight,
      child: new Center(
        child: FlatButton(
          onPressed: () {
            for (int i = 0; i < IngredientsListDao.ingredients.length; i++) {
              print(IngredientsListDao.ingredients.elementAt(i).name);
            }
            print("");
            if (IngredientsListDao.ingredients.contains(food)) {
              showInSnackBar(
                  food.name + ', zaten tarif listesinde!', Colors.red);
            } else {
              if (IngredientsListDao.ingredients.length >= MAX_INGREDIENTS) {
                showInSnackBar(
                  'Tarif listesine en fazla ' +
                      MAX_INGREDIENTS.toString() +
                      ' besin eklenebilir!',
                  Colors.red,
                );
              } else {
                IngredientsListDao.ingredients.add(food);
                showInSnackBar(
                    food.name + ', tarif listesine eklendi.', Colors.green);
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0,
                ),
              ),
              new Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
              ),
              new Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: healthPointButtonColor(),
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.Colors.foodPageBackground,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              FoodDetailBody(food),
            ],
          ),
          DetailAppBar(),
          Align(
            alignment: Alignment.bottomCenter,
            child: addButton,
          ),
        ],
      ),
    );
  }
}
