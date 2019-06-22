import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../MODEL/Recipe.dart';
import 'package:http/http.dart' as http;
import 'UserDao.dart';
import 'DAO.dart';
import 'IngredientsListDao.dart';

class AdviceDao {
  static List<Recipe> advices = List<Recipe>();

  static Future<List<Recipe>> getAdvices(Set ingredients) async {
    print(jsonEncode(IngredientsListDao.ingredients.toList()));
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            '${UserDao.currentUser.mail}:${UserDao.currentUser.password}'));
    Map<String, String> headers = {
      'Content-Type': new MediaType("application", "json").toString(),
      'authorization': basicAuth
    };

    await http
        .post('http://' + DAO.host + ':' + DAO.port + '/api/v1/recipe_food',
            body: json.encode(ingredients.toList()), headers: headers)
        .then((response) {
      List responseJson = jsonDecode(response.body);
      advices = responseJson.map((m) => new Recipe.fromJson(m)).toList();
    });
    return advices;
  }
}
