
import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';
import 'meal_detail.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,  
  this.title, 
  required this.meals, 
  //required this.onToggleFavorite
  });

  final String? title;
  final List<Meal> meals;
  //final void Function (Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          //onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('No data..... here!',style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),),
            SizedBox(height: 16),
            Text(
              'Try different Category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            )
          ],
        ),
      );
    if  (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            selectMeal(context, meal);
          },
        ),
      );
    }
    if (title==null){
      return content;
    }
    return Scaffold(
      
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meals/models/meal.dart';
// import 'package:meals/providers/meals_provider.dart';
// import 'package:meals/screens/meal_detail.dart';

// class MealsScreen extends ConsumerWidget {
//   final String title;
//   final List<Meal> meals;

//   MealsScreen({
//     required this.title,
//     required this.meals,
//   });
  
  
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mealsAsyncValue = ref.watch(mealsProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Meals'),
//       ),
//       body: mealsAsyncValue.when(
//         data: (meals) {
//           if (meals.isEmpty) {
//             return Center(
//               child: Text(
//                 'No data...',
//                 style: Theme.of(context).textTheme.headline6,
//               ),
//             );
//           }
//           return ListView.builder(
//             itemCount: meals.length,
//             itemBuilder: (context, index) {
//               final meal = meals[index];
//               return ListTile(
//                 title: Text(meal.title),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => MealDetailsScreen(meal: meal),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }
