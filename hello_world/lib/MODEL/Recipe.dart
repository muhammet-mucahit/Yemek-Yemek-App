class Recipe {
  final int id;
  final String name;
  final String image;
  final int rating;
  final int calorie;
  final double carb;
  final double protein;
  final double fat;
  final int cookingMinutes;
  final String description;
  final String userMail;

  const Recipe(
      {this.id,
      this.name,
      this.image,
      this.rating,
      this.calorie,
      this.carb,
      this.protein,
      this.fat,
      this.cookingMinutes,
      this.description,
      this.userMail});

  Recipe.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        image = json["image"],
        rating = json["rating"],
        calorie = json["calorie"],
        carb = json["carb"],
        protein = json["protein"],
        fat = json["fat"],
        cookingMinutes = json["cooking_minutes"],
        description = json["description"],
        userMail = json["user_mail"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "rating": rating,
        "calorie": calorie,
        "carb": carb,
        "protein": protein,
        "fat": fat,
        "cooking_minutes": cookingMinutes,
        "description": description,
        "user_mail": userMail,
      };
}
