import 'package:flutter/material.dart';
import '../../DAO/FoodDao.dart';
import 'FoodRow.dart';
import '../../Theme.dart' as Theme;
import '../../MODEL/Food.dart';
import '../Ingredients/ingredients.dart';

class FoodList extends StatefulWidget {
  final List<Food> foods;

  FoodList(this.foods);
  @override
  _FoodList createState() => _FoodList();
}

class _FoodList extends State<FoodList> {
  Widget tab(int category) {
    return Container(
      color: Theme.Colors.foodPageBackground,
      child: ListView.builder(
        itemExtent: 120.0,
        itemCount: FoodDao.getFoodsByCategory(category).length,
        itemBuilder: (_, index) =>
            FoodRow(FoodDao.getFoodsByCategory(category)[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Besinler",
            style: Theme.TextStyles.appBarTitle,
          ),
          actions: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Ingredients()),
                    );
                  },
                ),
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: "Temel",
              ),
              Tab(
                text: "Meyve",
              ),
              Tab(
                text: "Sebze",
              ),
              Tab(
                text: "Baklagil",
              ),
              Tab(
                text: "Et",
              ),
              Tab(
                text: "Süt",
              ),
              Tab(
                text: "Çerez",
              ),
              Tab(
                text: "Yağ",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            tab(0),
            tab(1),
            tab(2),
            tab(3),
            tab(4),
            tab(5),
            tab(6),
            tab(7),
          ],
        ),
      ),
    );
  }
}
