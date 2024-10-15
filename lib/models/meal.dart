// // enum Complexity {
// //   simple,
// //   challenging,
// //   hard,
// // }

// // enum Affordability {
// //   affordable,
// //   pricey,
// //   luxurious,
// // }
// // class Meal{
// //   const Meal({
// //     required this.id,
// //     required this.categories,
// //     required this.title,
// //     required this.imageUrl,
// //     required this.ingredients,
// //     required this.steps,
// //     required this.duration,
// //     required this.complexity,
// //     required this.affordability,
// //     required this.isGlutenFree,
// //     required this.isLactoseFree,
// //     required this.isVegan,
// //     required this.isVegetarian,
// //   });

// //    final String id;
// //   final List<String> categories;
// //   final String title;
// //   final String imageUrl;
// //   final List<String> ingredients;
// //   final List<String> steps;
// //   final int duration;
// //   final Complexity complexity;
// //   final Affordability affordability;
// //   final bool isGlutenFree;
// //   final bool isLactoseFree;
// //   final bool isVegan;
// //   final bool isVegetarian;
// // }
import 'package:flutter/material.dart';

enum Affordability { affordable, pricey, luxurious }
enum Complexity { simple, challenging, hard }

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final Affordability affordability;
  final Complexity complexity;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.affordability,
    required this.complexity,
    required this.imageUrl,
    required this.duration,
    required this.ingredients,
    required this.steps,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'categories': categories,
        'title': title,
        'affordability': affordability.index,
        'complexity': complexity.index,
        'imageUrl': imageUrl,
        'duration': duration,
        'ingredients': ingredients,
        'steps': steps,
        'isGlutenFree': isGlutenFree,
        'isVegan': isVegan,
        'isVegetarian': isVegetarian,
        'isLactoseFree': isLactoseFree,
      };

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['id'],
        categories: List<String>.from(json['categories']),
        title: json['title'],
        affordability: Affordability.values[json['affordability']],
        complexity: Complexity.values[json['complexity']],
        imageUrl: json['imageUrl'],
        duration: json['duration'],
        ingredients: List<String>.from(json['ingredients']),
        steps: List<String>.from(json['steps']),
        isGlutenFree: json['isGlutenFree'],
        isVegan: json['isVegan'],
        isVegetarian: json['isVegetarian'],
        isLactoseFree: json['isLactoseFree'],
      );
}
// class Meal {
//   final String id;
//   final String title;
//   final String imageUrl;
//   final List<String> ingredients;
//   final List<String> steps;
//   final bool isGlutenFree;
//   final bool isLactoseFree;
//   final bool isVegetarian;
//   final bool isVegan;

//   Meal({
//     required this.id,
//     required this.title,
//     required this.imageUrl,
//     required this.ingredients,
//     required this.steps,
//     required this.isGlutenFree,
//     required this.isLactoseFree,
//     required this.isVegetarian,
//     required this.isVegan,
//   });

//   factory Meal.fromFirestore(Map<String, dynamic> data) {
//     return Meal(
//       id: data['id'] as String,
//       title: data['title'] as String,
//       imageUrl: data['imageUrl'] as String,
//       ingredients: List<String>.from(data['ingredients']),
//       steps: List<String>.from(data['steps']),
//       duration: data['duration'] as int, // Add duration parameter
//       complexity: Complexity.simple, // Add default value for complexity
//       affordability: Affordability.affordable, // Add default value for affordability
//       isGlutenFree: data['isGlutenFree'] as bool,
//       isLactoseFree: data['isLactoseFree'] as bool,
//       isVegetarian: data['isVegetarian'] as bool,
//       isVegan: data['isVegan'] as bool,
//       categories: data['categories'] != null ? List<String>.from(data['categories']) : [], // Add categories parameter with default value
//     );
// }

// }

