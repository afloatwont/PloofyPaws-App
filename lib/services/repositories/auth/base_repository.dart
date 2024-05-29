import 'package:restoe/services/networking/api_provider.dart';

abstract class BaseRepository {
  final ApiProvider provider = ApiProvider();
}

typedef PostData = Map<String, dynamic>;
