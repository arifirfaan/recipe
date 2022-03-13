import 'dart:convert';

List<Drink> postFromJson(String str) =>
    List<Drink>.from(json.decode(str).map((x) => Drink.fromMap(x)));

class Drink {
  Drink({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
  });

  String id;
  String title;
  String thumbnailUrl;
  String description;

  factory Drink.fromMap(Map<String, dynamic> json) => Drink(
        id: json["idCategory"],
        title: json["strCategory"],
        thumbnailUrl: json["strCategoryThumb"],
        description: json["strCategoryDescription"],
      );
}