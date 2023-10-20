// import 'package:mealmate/util/recipe.dart';
// import 'package:sqflite/sqflite.dart';
// //import 'package:path/path.dart';

// class DB {
//   static const String TABLE_NAME = 'recipes';
//   Database? _db;

// //För att öppna databasen (init)
//   Future<void> init() async {
//     var databasesPath = getDatabasesPath();
//     var dbfilename = 'recipes.db';
//     var dbPath = ('$databasesPath/$dbfilename');

//     print('Database path: $dbPath');

//     _db = await openDatabase(
//       dbPath,
//       //  '$databasesPath/$dbfilename',
//       //skapa tabell i databas
//       onCreate: (db, version) {
//         db.execute('''CREATE $TABLE_NAME 
//         (
//           id INTEGER PRIMARY KEY,
//           title TEXT,
//           image TEXT,
//           )''');
//       },
//       version: 1,
//     );
//   }

// //Hämtar från databastabellen och skapar en lista med recepten
//   Future<List<Recipe>> getRecipes() async {
//     List<Map<String, dynamic>> results = await _db!.query(TABLE_NAME);
//     return results.map((result) => Recipe.fromMap(result)).toList();
//   }

// //Gör en insert i databasen
//   Future<void> saveToMyRecipes(String title) async {
//     var recipes = await getRecipes();
//     var recipe = Recipe(
//         id: recipes.length > 0 ? recipes.last.id + 1 : 0,
//         title: title,
//         image: '');
//     await _db!.insert(TABLE_NAME, recipe.toMap());
//   }

//   Future<void> removeFromMyRecipes(Recipe recipe) async {
//     await _db!.delete(TABLE_NAME, where: 'id = ?', whereArgs: [recipe.id]);
//   }
// }

// /*class DatabaseHelper {
//   DatabaseHelper.privatConstructor();
//   static final DatabaseHelper instance = DatabaseHelper.privatConstructor();
//   Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await intitDatabase();
//     return _database!;
//   }

//   Future<Database> intitDatabase() async {
//     final String path = join(await getDatabasesPath(), 'recipies.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         //define database schema and tables 
//         await db.execute('''
//         CREATE TABLE recipes(
//           id INTEGER PRIMARY KEY,
//           title TEXT,
//           description TEXT
//         )
//         ''');
//       },
//     );
//   }


// Future<void> insertRecipe(Recipe recipe) async {
//   final databaseHelper = DatabaseHelper.instance;
//   final db = await databaseHelper.database;
//   await db.insert(
//     'recipes',
//     recipe.toMap(), //conver recipe object to a map
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }

// Future<List<Recipe>> getRecipes() async {
//   final databaseHelper = DatabaseHelper.instance;
//   final db = await databaseHelper.database;
//   final List<Map<String, dynamic>> maps = await db.query('recipes');
//   return List.generate(maps.length, (i) {
//     return Recipe.fromMap(maps[i]);
//   });
// }

// }

// //Retrieve recipes
// //List<Recipe> savedRecipes = await databaseHelper.getRecipes();*/
