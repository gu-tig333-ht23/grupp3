// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//flytta klassen sen typ?? dublett just nu bara för att leka runt med providern

class Recipe {
  final double? id;
  final String title;
  final String image;
  final int readyInMinutes;
  //final List<String> dishtypes;
  //final List expectedIngidients;

  Recipe({
    this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    //required this.dishtypes,
    //required this.expectedIngidients,
  });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
      id: json['id'] as double,
      title: json['title'] as String,
      image: json['image'] as String,
      readyInMinutes: json['readyInMinutes'] as int,
      //dishtypes: (json['dishtypes'] as List <dynamic>).cast()<String>(),
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  /*@override
  String toString() {
    return 'Recipe {title: $title, image: $image, readyinMinutes: $readyInMinutes}';
  }*/
}
