// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:meals/data/dummy_data.dart';
// import 'package:meals/models/category.dart';
// import 'package:meals/screens/meals.dart';
// import 'package:meals/widgets/category_grid_item.dart';

// import '../models/meal.dart';

// class CategoriesScreen extends StatefulWidget {
//   const CategoriesScreen({
//     Key? key,
//     required this.availableMeals,
//   }) : super(key: key);

//   final List<Meal> availableMeals;

//   @override
//   State<CategoriesScreen> createState() => _CategoriesScreenState();
// }

// class _CategoriesScreenState extends State<CategoriesScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late List<Category> _categories; // New

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//       lowerBound: 0,
//       upperBound: 1,
//     );
//     _animationController.forward();
//     _fetchCategories(); // Fetch categories from Firebase
//   }

//   Future<void> _fetchCategories() async {
//   final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();
//   setState(() {
//     _categories = snapshot.docs.map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>)).toList();
//   });
// }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _selectCategory(BuildContext context, Category category) {
//     final filteredMeals = widget.availableMeals
//         .where((meal) => meal.categories.contains(category.id))
//         .toList();

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (ctx) => MealsScreen(
//           title: category.title,
//           meals: filteredMeals,
//           //onToggleFavorite: onToggleFavorite,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: _animationController,
//         child: GridView(
//           padding: const EdgeInsets.all(14),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 3 / 2,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//           ),
//           children: [
//             //avacat.map((categor)=>CategoryGridItem(category: category)).toList
//             for (final category in availableCategories)
//               CategoryGridItem(
//                 category: category,
//                 onSelectCategory: () {
//                   _selectCategory(context, category);
//                 },
//               )
//           ],
//         ),
//         builder: (context, child) => SlideTransition(
//               position: Tween(
//                 begin: const Offset(0, 0.3),
//                 end: Offset(0, 0),
//               ).animate(
//                 CurvedAnimation(
//                     parent: _animationController, curve: Curves.easeInOut),
//               ),
//               child: child,
//             ));
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('categories').get();
      final List<Category> categories = snapshot.docs
          .map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      setState(() {
        _categories = categories;
      });
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: _categories
            .map((category) => CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    _selectCategory(context, category);
                  },
                ))
            .toList(),
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
