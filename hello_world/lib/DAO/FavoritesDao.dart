import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../MODEL/Recipe.dart';
import '../DAO/UserDao.dart';
import 'package:http/http.dart' as http;
import 'DAO.dart';

class FavoritesDao {
  static List<Recipe> favorites = new List();
  static List<Recipe> apirioriFavorites = new List();
  static List<int> favoritesIds = new List();

  static Future<List<Recipe>> getFavorites() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            '${UserDao.currentUser.mail}:${UserDao.currentUser.password}'));
    await http.get('http://' + DAO.host + ':' + DAO.port + '/api/v1/favorites',
        headers: {'authorization': basicAuth}).then((response) {
      // print(response.body);
      List responseJson = jsonDecode(response.body);
      favorites = responseJson.map((m) => new Recipe.fromJson(m)).toList();
    });
    for (int i = 0; i < favorites.length; i++)
      favoritesIds.add(favorites[i].id);
    return favorites;
  }

  static Future<List<Recipe>> getApirioriAdvices() async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode(
            '${UserDao.currentUser.mail}:${UserDao.currentUser.password}'));
    await http.get('http://' + DAO.host + ':' + DAO.port + '/api/v1/apriori',
        headers: {'authorization': basicAuth}).then((response) {
      print(response.body);
      print("asd");
      List responseJson = jsonDecode(response.body);
      apirioriFavorites =
          responseJson.map((m) => new Recipe.fromJson(m)).toList();
    });
    return apirioriFavorites;
  }

  static String basicAuth = 'Basic ' +
      base64Encode(utf8.encode(
          '${UserDao.currentUser.mail}:${UserDao.currentUser.password}'));

  static Map<String, String> headers = {
    'authorization': basicAuth,
    'content-type': new MediaType("application", "json").toString(),
  };

  static Future<void> postFavorites() async {
    print(json.encode(favoritesIds));
    await http
        .post('http://' + DAO.host + ':' + DAO.port + '/api/v1/favorites',
            headers: headers, body: json.encode(favoritesIds))
        .then((response) {
      print(response.body);
    });
  }

  static Recipe getRecipeById(id) {
    return favorites.where((f) => f.id == id).first;
  }
}
