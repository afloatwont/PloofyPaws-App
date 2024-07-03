import 'package:flutter/material.dart';

class Plan {
  final String title;
  final String price;
  final String originalPrice;
  final String description;
  final Gradient? gradient;

  Plan({
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.description,
    this.gradient,
  });
}

class SelectedPlanProvider extends ChangeNotifier {
  List<Plan> plans = [
    Plan(
      title: 'Trial Walk',
      price: 'Rs 99',
      originalPrice: 'Rs 199',
      description: '1 day, 1 time',
    ),
    Plan(
      title: 'Monthly Plan',
      price: 'Rs 4499',
      originalPrice: 'Rs 6099',
      description: 'Once every day for a month',
    ),
    Plan(
      title: 'Special Monthly Plan',
      price: 'Rs 8499',
      originalPrice: 'Rs 10099',
      description: 'Twice every day for a month',
    ),
    Plan(
      title: 'Quarterly Plan',
      price: 'Rs 10999',
      originalPrice: 'Rs 12999',
      description: 'Once every day for 90 days',
    ),
    Plan(
      title: 'Special Quarterly Plan',
      price: 'Rs 10999',
      originalPrice: 'Rs 12999',
      description: 'Once every day for 90 days',
    ),
  ];

  Plan _selectedPlan = Plan(
    title: 'Trial Walk',
    price: 'Rs 99',
    originalPrice: 'Rs 199',
    description: '1 day, 1 time',
  );

  Plan get selectedPlan => _selectedPlan;

  set selectedPlan(Plan plan) {
    _selectedPlan = plan;
    notifyListeners();
  }
}
