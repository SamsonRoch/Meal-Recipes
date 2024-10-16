import 'package:flutter/material.dart';
import'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
//import 'package:meals/data/dummy_data.dart';
//import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
//import 'package:meals/providers/meals_provider.dart';

import '../providers/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  //final List<Meal> _favoritesMeals = [];
  //Map<Filter,bool> _selectedFilters= kInitialFilters;
  

 
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async{
    Navigator.of(context).pop();
    if (identifier == 'filters') {

      await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) =>const FiltersScreen(),
        ),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals= ref.watch(filteredMealsProvider);


    Widget activePage = CategoriesScreen(
      //onToggleFavorite: _toggleMealFavovritesStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
        ),
        drawer: MainDrawer(
          onSelectScreen: _setScreen,
        ),
        body: activePage,
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ));
  }
}



//  // void _showInfoMessage(String message) {
//   //   ScaffoldMessenger.of(context).clearSnackBars();
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text(message),
//   //     ),
//   //   );
//   // }

//   // void _toggleMealFavovritesStatus(Meal meal) {
//   //   final isExisting = _favoritesMeals.contains(meal);

//   //   if (isExisting) {
//   //     setState(() {
//   //       _favoritesMeals.remove(meal);
//   //     });
//   //     _showInfoMessage("Meal is removed form favorite!");
//   //   } else {
//   //     setState(() {
//   //       _favoritesMeals.add(meal);
//   //     });
//   //     _showInfoMessage("Meals Added to Favorites!");
//   //   }
//   // }
// class _TabsScreenState extends ConsumerState<TabsScreen> {
//   int _selectedPageIndex = 0;

//   void _selectedPage(int index) {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//   }

//   void _setScreen(String identifier) async {
//     Navigator.of(context).pop();
//     if (identifier == 'filters') {
//       await Navigator.of(context).push<Map<Filter, bool>>(
//         MaterialPageRoute(
//           builder: (ctx) => const FiltersScreen(),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Access the filtered meals provider
//     final List<Meal> availableMeals = ref.watch(filteredMealsProvider);

//     Widget activePage = CategoriesScreen(
//       availableMeals: availableMeals,
//     );
//     var activePageTitle = 'Categories';

//     if (_selectedPageIndex == 1) {
//       activePage =  MealsScreen(title: '', meals: [],);
//       activePageTitle = 'Your Favorites';
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(activePageTitle),
//       ),
//       drawer: MainDrawer(
//         onSelectScreen: _setScreen,
//       ),
//       body: activePage,
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: _selectedPage,
//         currentIndex: _selectedPageIndex,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.set_meal),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//         ],
//       ),
//     );
//   }
// }
