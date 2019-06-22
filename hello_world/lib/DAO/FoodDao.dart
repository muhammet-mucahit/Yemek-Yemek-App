import 'dart:convert';
import '../MODEL/Food.dart';
import 'package:http/http.dart' as http;
import 'UserDao.dart';
import 'DAO.dart';

class FoodDao {
  static List<Food> foods;
  static List<Food> ingredients;

  static var recipeIngredientList = Set<Food>();

  static Future<List> getFoods() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            '${UserDao.currentUser.mail}:${UserDao.currentUser.password}'));
    await http.get('http://' + DAO.host + ':' + DAO.port + '/api/v1/foods',
        headers: {'authorization': basicAuth}).then((response) {
      print(response.body);
      List responseJson = jsonDecode(response.body);
      foods = responseJson.map((m) => new Food.fromJson(m)).toList();
    });
    return foods;
  }

  static Future<List<Food>> getIngredients(int id) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            '${UserDao.currentUser.mail}:${UserDao.currentUser.password}'));
    await http.get(
        'http://' + DAO.host + ':' + DAO.port + '/api/v1/recipe_food/$id',
        headers: {'authorization': basicAuth}).then((response) {
      List responseJson = jsonDecode(response.body);
      ingredients = responseJson.map((m) => new Food.fromJson(m)).toList();
    });
    return ingredients;
  }

  static Food getFoodByName(name) {
    return foods.where((f) => f.name == name).first;
  }

  static List<Food> getFoodsByCategory(category) {
    return foods.where((f) => f.category == category).toList();
  }
}
