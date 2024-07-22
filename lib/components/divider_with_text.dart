import 'package:flutter/material.dart';

Widget buildDividerWithText(BuildContext context, String text) {
  return Row(
    children: [
      Expanded(
        child: Divider(
          indent: MediaQuery.sizeOf(context).width * 0.03,
          endIndent: MediaQuery.sizeOf(context).width * 0.03,
          thickness: 1,
          color: Colors.black,
        ),
      ),
      Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      Expanded(
        child: Divider(
          indent: MediaQuery.sizeOf(context).width * 0.03,
          endIndent: MediaQuery.sizeOf(context).width * 0.03,
          thickness: 1,
          color: Colors.black,
        ),
      ),
    ],
  );
}
