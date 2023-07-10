import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'recipe_model.dart';

class RecipeService {
  Future<List<Recipe>> fetchRecipes() async {
    final jsonString = await rootBundle.loadString('assets/recipelist.json');
    final jsonData = json.decode(jsonString);
    final List<dynamic> recipesData = jsonData['recipes'];
    return recipesData.map((recipeData) => Recipe.fromJson(recipeData)).toList();
  }
}
