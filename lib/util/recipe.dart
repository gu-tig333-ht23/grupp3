class Recipe {
  final id;
  final title;
  final image;

  Recipe({
    this.id,
    required this.title,
    required this.image,
  });

//necessary for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }

//takes a map and converts it to a Recipe object.
  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(
      id: data['id'],
      title: data['title'],
      image: data['image'],
    );
  }
}
