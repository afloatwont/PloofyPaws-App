import 'package:flutter/cupertino.dart';

abstract class PlatformAppBar {
  PreferredSizeWidget android(BuildContext context);
  Widget ios(BuildContext context);
}
