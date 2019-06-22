import 'package:flutter/material.dart';
import '../../Theme.dart' as Theme;
import '../../DAO/IngredientsListDao.dart';
import '../../DAO/AdviceDao.dart';
import '../Recipes/RecipeList.dart';
import '../../MODEL/Recipe.dart';

class Ingredients extends StatefulWidget {
  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: Theme.TextStyles.snackBar,
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İçindekiler",
          style: Theme.TextStyles.appBarTitle,
        ),
      ),
      body: Container(
        color: Theme.Colors.foodPageBackground,
        child: IngredientsListDao.ingredients.isEmpty
            ? Center(
                child: Text(
                  "İçindekiler Listesi Boş!",
                  style: Theme.TextStyles.appBarTitle,
                ),
              )
            : ListView.builder(
                itemExtent: 80.0,
                itemCount: IngredientsListDao.ingredients.length,
                itemBuilder: (_, index) {
                  final foodThumbnail = Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 32.0),
                    child: Hero(
                      tag:
                          'food-icon-${IngredientsListDao.ingredients.elementAt(index).name}',
                      child: Image(
                        image: AssetImage(IngredientsListDao.ingredients
                            .elementAt(index)
                            .image),
                        height: 35,
                        width: 35,
                      ),
                    ),
                  );

                  final foodCard = Container(
                    margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                    decoration: BoxDecoration(
                      color: Theme.Colors.foodCard,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 10.0,
                          offset: Offset(0.0, 10.0),
                        )
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 12.0),
                      constraints: BoxConstraints.expand(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            IngredientsListDao.ingredients
                                .elementAt(index)
                                .name,
                            style: Theme.TextStyles.foodTitle,
                          ),
                        ],
                      ),
                    ),
                  );

                  final deleteButton = Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(top: 8.0, right: 24.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        IngredientsListDao.ingredients.remove(
                            IngredientsListDao.ingredients.elementAt(index));
                        setState(() {});
                      },
                    ),
                  );

                  return Container(
                    margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Stack(
                      children: <Widget>[
                        foodCard,
                        foodThumbnail,
                        deleteButton,
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          if (IngredientsListDao.ingredients.isEmpty) {
            showInSnackBar(
                "İçindekiler listesinde en az bir besin bulunmalıdır!");
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return FutureBuilder(
                    future:
                        AdviceDao.getAdvices(IngredientsListDao.ingredients),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          color: Theme.Colors.foodCard,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        List<Recipe> advices = snapshot.data;
                        return RecipeList(advices, "Tavsiyeler");
                      }
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
