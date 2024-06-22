import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ploofypaws/services/repositories/auth/auth.dart';
import 'package:ploofypaws/services/repositories/auth/model.dart' as models;

final profileProvider = FutureProvider.autoDispose<models.UserData?>((ref) {
  final authApi = ref.watch(authRepositoryProvider);
  return authApi.userData;
});
