import 'package:flutter/material.dart';
import 'package:restoe/config/icons/cities/cities.dart';

class Cities {
  final int id;
  final String? cityName;
  final Widget? cityyIcon;

  Cities({required this.id, required this.cityName, required this.cityyIcon});
}

final List<Cities> citiesItems = [
  // Cities(id: 1, cityName: 'New Delhi', cityyIcon: const Delhi()),
  Cities(id: 2, cityName: 'Mumbai', cityyIcon: const Mumbai()),
  Cities(id: 3, cityName: 'Kolkata', cityyIcon: const Kolkata()),
  Cities(id: 4, cityName: 'Chennai', cityyIcon: const Chennai()),
  Cities(id: 5, cityName: 'Pune', cityyIcon: const Pune()),
  Cities(id: 6, cityName: 'Rajasthan', cityyIcon: const Rajasthan()),
  Cities(id: 7, cityName: 'Gujarat', cityyIcon: const Gujarat()),
  Cities(id: 8, cityName: 'Kashmir', cityyIcon: const Kashmir()),
  Cities(id: 9, cityName: 'Agra', cityyIcon: const TajMahal()),
  Cities(id: 10, cityName: 'Kashmir', cityyIcon: const Kashmir()),
];
