import '../Theme.dart' as Theme;
import 'package:flutter/material.dart';

class DetailAppBar extends StatefulWidget {
  const DetailAppBar({Key key}) : super(key: key);

  @override
  _DetailAppBar createState() => _DetailAppBar();
}

class _DetailAppBar extends State<DetailAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(color: Theme.Colors.appBarIconColor),
        ],
      ),
    );
  }
}
