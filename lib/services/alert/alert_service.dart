import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/navigation/navigation.dart';

class AlertService {
  final GetIt getIt = GetIt.instance;

  late NavigationService _navigationService;

  AlertService() {
    _navigationService = getIt.get<NavigationService>();
  }

  void showToast({
    required String text,
    IconData icon = Icons.info,
    Color color = Colors.black,
  }) {
    try {
      DelightToastBar(
          autoDismiss: true,
          position: DelightSnackbarPosition.top,
          builder: (context) {
            return ToastCard(
                leading: Icon(
                  icon,
                  size: 28,
                  color: color,
                ),
                title: Text(
                  text,
                  style: TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700, color: color),
                ));
          }).show(_navigationService.navigatorKey!.currentContext!);
    } catch (e) {
      print(e);
    }
  }
}