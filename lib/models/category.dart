import 'package:flutter/material.dart';

// class Category{
// const Category({required this.id, required this.title, 
// this.color = Colors.deepOrangeAccent});
//   final String id;
//    final String title;
//    final Color color;
// }

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'color': color.value,
      };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        title: json['title'],
        color: Color(json['color']),
      );
}
