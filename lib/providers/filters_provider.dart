import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>>{
  FiltersNotifier():super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  });

  void setFilters(Map<Filter , bool >choosenFilter){
    state= choosenFilter;
  }
  void setFilter(Filter filter, bool isActive){
    state={
      ...state,
      filter:isActive,
    };
  }
}

final filtersProvider = StateNotifierProvider<FiltersNotifier,Map<Filter,bool>>(
  (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final mealsAsyncValue = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return mealsAsyncValue.when(
    data: (List<Meal> meals) {
      return meals.where((meal) {
        if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (activeFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    },
    loading: () => [], // Return an empty list or handle loading state as needed
    error: (error, stackTrace) {
      // Handle error state, such as returning an empty list or showing an error message
      print('Error fetching meals: $error');
      return [];
    },
  );
});
