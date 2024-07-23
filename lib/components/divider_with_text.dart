import 'package:flutter/material.dart';

Widget buildDividerWithText(BuildContext context, String text,
    {Color? color = Colors.black}) {
  return Row(
    children: [
      Expanded(
        child: Divider(
          indent: MediaQuery.sizeOf(context).width * 0.03,
          endIndent: MediaQuery.sizeOf(context).width * 0.03,
          thickness: 1,
          color: color ?? Colors.black,
        ),
      ),
      Text(
        text,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color ?? Colors.black),
      ),
      Expanded(
        child: Divider(
          indent: MediaQuery.sizeOf(context).width * 0.03,
          endIndent: MediaQuery.sizeOf(context).width * 0.03,
          thickness: 1,
          color: color ?? Colors.black,
        ),
      ),
    ],
  );
}
