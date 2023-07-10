import 'package:flutter/material.dart';

import 'recipe_model.dart';
import 'recipe_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecipeListScreen(),
    );
  }
}

class RecipeListScreen extends StatefulWidget {
  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final RecipeService recipeService = RecipeService();
  late Future<List<Recipe>> futureRecipes;

  @override
  void initState() {
    super.initState();
    futureRecipes = recipeService.fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Recipes'),

      ),
      body: Center(
        child: FutureBuilder<List<Recipe>>(


          future: futureRecipes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final recipes = snapshot.data!;
              return ListView.builder(

                itemCount: recipes.length,
                itemBuilder: (context, index) {

                  final recipe = recipes[index];
                  return ListTile(
                    leading: Icon(Icons.no_food_rounded),
                    title: Text(recipe.title),
                    subtitle: Text(recipe.description),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Handle recipe item tap
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
