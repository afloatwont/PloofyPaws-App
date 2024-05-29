import 'package:flutter/material.dart';
import 'package:restoe/components/button.dart';
import 'package:restoe/config/theme/theme.dart';

class PetRecordCard extends StatelessWidget {
  final Color? color;
  final Widget? leading;
  final Widget? trailing;
  final String? title;
  final String? subtitle;
  final VoidCallback? onAddRecord;
  final VoidCallback? onViewRecord;
  final bool? isViewRecordVisible;
  final TextStyle? titleStyle;

  const PetRecordCard(
      {super.key,
      this.leading,
      this.trailing,
      this.title,
      this.subtitle,
      this.onAddRecord,
      this.onViewRecord,
      this.color,
      this.isViewRecordVisible,
      this.titleStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: const Border.fromBorderSide(BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              trailing: Column(
                children: [
                  if (trailing != null) trailing!,
                  const Spacer(),
                ],
              ),
              leading: Column(
                children: [
                  leading!,
                  const Spacer(),
                ],
              ),
              title:
                  Text(title!, style: titleStyle ?? typography(context).strongSmallBody.copyWith(color: Colors.black)),
              subtitle: Text(subtitle!, style: typography(context).smallBody.copyWith(color: Colors.grey))),
          const SizedBox(height: 8),
          const Divider(
            color: Colors.grey,
            height: 0,
          ),
          ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (isViewRecordVisible ?? false)
                    Expanded(
                        child: Button(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                            ),
                            onPressed: onViewRecord,
                            buttonColor: Colors.black,
                            variant: 'text',
                            label: "View Records")),
                  Expanded(
                      child: Button(
                          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                          onPressed: onAddRecord,
                          variant: 'filled',
                          label: "Add")),
                ],
              ))
        ],
      ),
    );
  }
}
