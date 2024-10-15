// import'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals/data/dummy_data.dart';

// final mealsProvider =Provider((ref) {
//   return dummyMeals;
// });
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

final mealsProvider = FutureProvider<List<Meal>>((ref) async {
  final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('meals').get();
  return snapshot.docs.map((doc) => Meal.fromJson(doc.data() as Map<String, dynamic>)).toList();
});
