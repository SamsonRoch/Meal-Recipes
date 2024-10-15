import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meals/data/dummy_data.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:meals/screens/tabs.dart';
import'package:flutter_riverpod/flutter_riverpod.dart';



final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));

  // Call uploadData after initializing Firebase
 // uploadData(); 
}



class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(
      ),
    );
  }
}
void uploadData() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    // Upload categories
    for (final category in availableCategories) {
      await firestore.collection('categories').doc(category.id).set(category.toJson());
    }

    // Upload meals
    for (final meal in dummyMeals) {
      await firestore.collection('meals').doc(meal.id).set(meal.toJson());
    }

    print('Data uploaded successfully!');
  } catch (e) {
    print('Error uploading data: $e');
  }
}

