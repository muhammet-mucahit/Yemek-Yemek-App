import 'package:flutter/material.dart';
import 'drawer.dart';
import 'DAO/RecipeDao.dart';
import 'Routes.dart';
import 'package:fluro/fluro.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

Widget logo() {
  return Image(
    width: 200.0,
    image: AssetImage("lib/assets/logo.png"),
  );
}

class HomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Anasayfa"),
      ),
      drawer: MyDrawer(),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  final randomRecipe = RecipeDao.recipes[1];
  @override
  Widget build(BuildContext context) {
    Widget _applyTextEffects({
      @required double translationFactor,
      @required Widget child,
    }) {
      final double xTranslation = 10.0;

      return Opacity(
        opacity: 0.6,
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

    _buildTextContainer(BuildContext context) {
      var textTheme = Theme.of(context).textTheme;
      var categoryText = _applyTextEffects(
        translationFactor: 300.0,
        child: Text(
          randomRecipe.name,
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
            randomRecipe.calorie.toString() + " kcal",
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
          ],
        ),
      );
    }

    var image = Image.asset(
      randomRecipe.image,
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5,
        0.5,
      ),
    );

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            const Color(0xFF000000),
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
      onPressed: () => _navigateTo(context, randomRecipe.id),
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
