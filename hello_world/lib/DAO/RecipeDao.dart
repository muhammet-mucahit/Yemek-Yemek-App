import 'dart:convert';
import '../MODEL/Recipe.dart';
import 'package:http/http.dart' as http;
import 'UserDao.dart';
import 'DAO.dart';

class RecipeDao {
  static List<Recipe> recipes;

  static Future<List<Recipe>> getRecipes() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            '${UserDao.currentUser.mail}:${UserDao.currentUser.password}'));
    await http.get('http://' + DAO.host + ':' + DAO.port + '/api/v1/recipes',
        headers: {'authorization': basicAuth}).then((response) {
      List responseJson = jsonDecode(response.body);
      recipes = responseJson.map((m) => new Recipe.fromJson(m)).toList();
    });
    return recipes;
  }

  static Recipe getRecipeById(id) {
    return recipes.where((f) => f.id == int.parse(id)).first;
  }
}
