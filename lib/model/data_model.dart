import 'dart:convert';

RecipeModel recipeModelFromJson(String str) => RecipeModel.fromJson(json.decode(str));

String recipeModelToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
    List<Recipe> recipes;
    int total;
    int skip;
    int limit;

    RecipeModel({
        required this.recipes,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory RecipeModel.fromJson(Map<String, dynamic> json) {
        List<Recipe> parsedRecipes = [];
        if (json["recipes"] is List) {
            parsedRecipes = List<Recipe>.from(
                json["recipes"].map((x) => Recipe.fromJson(x))
            );
        }

        int parsedTotal = 0;
        if (json["total"] is int) {
            parsedTotal = json["total"];
        }

        int parsedSkip = 0;
        if (json["skip"] is int) {
            parsedSkip = json["skip"];
        }

        int parsedLimit = 0;
        if (json["limit"] is int) {
            parsedLimit = json["limit"];
        }

        return RecipeModel(
            recipes: parsedRecipes,
            total: parsedTotal,
            skip: parsedSkip,
            limit: parsedLimit,
        );
    }

    Map<String, dynamic> toJson() => {
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}

class Recipe {
    int id;
    String name;
    List<String> ingredients;
    List<String> instructions;
    int prepTimeMinutes;
    int cookTimeMinutes;
    int servings;
    String difficulty;
    String cuisine;
    int caloriesPerServing;
    List<String> tags;
    int userId;
    String image;
    double rating;
    int reviewCount;
    List<String> mealType;

    Recipe({
        required this.id,
        required this.name,
        required this.ingredients,
        required this.instructions,
        required this.prepTimeMinutes,
        required this.cookTimeMinutes,
        required this.servings,
        required this.difficulty,
        required this.cuisine,
        required this.caloriesPerServing,
        required this.tags,
        required this.userId,
        required this.image,
        required this.rating,
        required this.reviewCount,
        required this.mealType,
    });

    factory Recipe.fromJson(Map<String, dynamic> json) {
        int parsedId = 0;
        if (json["id"] is int) {
            parsedId = json["id"];
        }

        String parsedName = "";
        if (json["name"] is String) {
            parsedName = json["name"];
        }

        List<String> parsedIngredients = [];
        if (json["ingredients"] is List) {
            parsedIngredients = List<String>.from(json["ingredients"].map((x) => x.toString()));
        }

        List<String> parsedInstructions = [];
        if (json["instructions"] is List) {
            parsedInstructions = List<String>.from(json["instructions"].map((x) => x.toString()));
        }

        int parsedPrepTime = 0;
        if (json["prepTimeMinutes"] is int) {
            parsedPrepTime = json["prepTimeMinutes"];
        }

        int parsedCookTime = 0;
        if (json["cookTimeMinutes"] is int) {
            parsedCookTime = json["cookTimeMinutes"];
        }

        int parsedServings = 0;
        if (json["servings"] is int) {
            parsedServings = json["servings"];
        }

        String parsedDifficulty = "";
        if (json["difficulty"] is String) {
            parsedDifficulty = json["difficulty"];
        }

        String parsedCuisine = "";
        if (json["cuisine"] is String) {
            parsedCuisine = json["cuisine"];
        }

        int parsedCalories = 0;
        if (json["caloriesPerServing"] is int) {
            parsedCalories = json["caloriesPerServing"];
        }

        List<String> parsedTags = [];
        if (json["tags"] is List) {
            parsedTags = List<String>.from(json["tags"].map((x) => x.toString()));
        }

        int parsedUserId = 0;
        if (json["userId"] is int) {
            parsedUserId = json["userId"];
        }

        String parsedImage = "";
        if (json["image"] is String) {
            parsedImage = json["image"];
        }

        double parsedRating = 0.0;
        if (json["rating"] is num) {
            parsedRating = json["rating"].toDouble();
        }

        int parsedReviewCount = 0;
        if (json["reviewCount"] is int) {
            parsedReviewCount = json["reviewCount"];
        }

        List<String> parsedMealType = [];
        if (json["mealType"] is List) {
            parsedMealType = List<String>.from(json["mealType"].map((x) => x.toString()));
        }

        return Recipe(
            id: parsedId,
            name: parsedName,
            ingredients: parsedIngredients,
            instructions: parsedInstructions,
            prepTimeMinutes: parsedPrepTime,
            cookTimeMinutes: parsedCookTime,
            servings: parsedServings,
            difficulty: parsedDifficulty,
            cuisine: parsedCuisine,
            caloriesPerServing: parsedCalories,
            tags: parsedTags,
            userId: parsedUserId,
            image: parsedImage,
            rating: parsedRating,
            reviewCount: parsedReviewCount,
            mealType: parsedMealType,
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "prepTimeMinutes": prepTimeMinutes,
        "cookTimeMinutes": cookTimeMinutes,
        "servings": servings,
        "difficulty": difficulty,
        "cuisine": cuisine,
        "caloriesPerServing": caloriesPerServing,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "userId": userId,
        "image": image,
        "rating": rating,
        "reviewCount": reviewCount,
        "mealType": List<dynamic>.from(mealType.map((x) => x)),
    };
}