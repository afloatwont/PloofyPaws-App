import 'package:flutter/cupertino.dart';
import 'package:restoe/config/theme/theme.dart';

/// A widget to display section headers.
class SectionHeader extends StatelessWidget {
  /// The title of the section header.
  final String title;

  /// Creates a [SectionHeader] widget.
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: typography(context).title3.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
