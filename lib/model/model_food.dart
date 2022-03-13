import 'dart:convert';

List<Food> postFromJson(String str) =>
    List<Food>.from(json.decode(str).map((x) => Food.fromMap(x)));

class Food {
  Food({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
  });

  String id;
  String title;
  String thumbnailUrl;
  String description;

  factory Food.fromMap(Map<String, dynamic> json) => Food(
        id: json["idCategory"],
        title: json["strCategory"],
        thumbnailUrl: json["strCategoryThumb"],
        description: json["strCategoryDescription"],
      );
}