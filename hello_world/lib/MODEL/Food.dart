class Food {
  final String name;
  final String image;
  final int calorie;
  final double carb;
  final double protein;
  final double fat;
  final int healthPoint;
  final String description;
  final int category;

  const Food(
      {this.name,
      this.image,
      this.calorie,
      this.carb,
      this.protein,
      this.fat,
      this.healthPoint,
      this.description,
      this.category});

  Food.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        image = json["image"],
        calorie = json["calorie"],
        carb = json["carb"],
        protein = json["protein"],
        fat = json["fat"],
        healthPoint = json["health_point"],
        description = json["description"],
        category = json["category"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "calorie": calorie,
        "carb": carb,
        "protein": protein,
        "fat": fat,
        "health_point": healthPoint,
        "description": description,
        "category": category,
      };
}
