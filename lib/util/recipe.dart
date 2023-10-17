class Recipe {
  final id;
  final title;
  final image;

  Recipe({
    this.id,
    required this.title,
    required this.image,
  });

  factory Recipe.fromMap(Map<String, dynamic> data) {
    return Recipe(
      id: data['id'],
      title: data['title'],
      image: data['image'],
    );
  }
}
