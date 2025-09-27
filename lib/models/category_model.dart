import 'package:evently_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  int id;
  String title;
  IconData icon;
  String? image;
  CategoryModel({
    this.image,
    required this.id,
    required this.title,
    required this.icon,
  });
  static List<CategoryModel> get categories => [
    CategoryModel(id: 1, title: 'All', icon: Icons.explore),
    CategoryModel(
      id: 2,
      title: 'Sport',
      image: Assets.image.sportCard.path,
      icon: Icons.pedal_bike,
    ),
    CategoryModel(
      id: 3,
      title: 'BirthDay',
      image: Assets.image.birthdayCard.path,
      icon: Icons.cake,
    ),
    CategoryModel(
      id: 4,
      title: 'Meeting',
      image: Assets.image.meetingCard.path,
      icon: Icons.meeting_room,
    ),
    CategoryModel(
      id: 5,
      title: 'Workshop',
      image: Assets.image.workShop.path,
      icon: Icons.handyman,
    ),
    CategoryModel(
      id: 6,
      title: 'Eating',
      image: Assets.image.eating.path,
      icon: Icons.dining,
    ),
  ];
}
