import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/placebo_colors.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final String variant;
  final String? label;
  final bool loading;
  final EdgeInsets? padding;
  final double? size;
  final bool disabled;
  final Widget? iconAsset;
  final Icon? buttonIcon;
  final Color? buttonColor;
  final Color? foregroundColor;
  final Color? disabledColor;
  final BorderRadius? borderRadius;

  const Button({
    super.key,
    this.padding,
    this.loading = false,
    this.disabled = false,
    required this.onPressed,
    required this.variant,
    this.size = 12.0,
    this.iconAsset,
    this.buttonIcon,
    this.label,
    this.borderRadius,
    this.foregroundColor,
    this.buttonColor = primaryColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    // Check if both iconAsset and buttonIcon are provided
    assert(!(iconAsset != null && buttonIcon != null), 'You cannot use both iconAsset and buttonIcon');

    if (variant == 'text') {
      return _buildIosTextButton(context);

      //
      // return _buildAndroidTextButton(context);
    }

    if (variant == 'outlined') {
      return _buildIosOutlinedButton(context);

      // return _buildAndroidOutlinedButton(context);
    }

    if (variant == 'filled') {
      return _buildIosFilledButton(context);

      // return _buildAndroidFilledButton(context);
    }

    return const Text('Variant not handled');
  }

  Widget _buildAndroidTextButton(BuildContext context) {
    final text = _buildLabel();
    final loader = _buildLoader(context);

    final style = TextButton.styleFrom(foregroundColor: buttonColor, padding: padding);

    if (iconAsset != null && buttonIcon != null) {
      return const Text('You cannot use both iconAsset and buttonIcon');
    }

    // Button with text and asset icon
    if (label != null && iconAsset != null) {
      return TextButton.icon(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        icon: loading ? loader : iconAsset!,
        label: text,
      );
    }

    //Button with text and button icon
    if (label != null && buttonIcon != null) {
      return TextButton.icon(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        icon: loading ? loader : buttonIcon!,
        label: text,
      );
    }

    // Button with only asset icon
    if (label == null && iconAsset != null) {
      return TextButton.icon(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        icon: loading ? loader : iconAsset!,
        label: const Text(''), // Provide an empty label
      );
    }

    // Button with only button icon
    if (label == null && buttonIcon != null) {
      return TextButton(
          style: style, onPressed: (disabled || loading) ? null : onPressed, child: loading ? loader : buttonIcon!);
    }

    // Button with only text
    if (label != null && iconAsset == null && buttonIcon == null) {
      return TextButton(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        child: loading ? loader : text,
      );
    }
    // Return an empty container if neither label nor iconAsset is provided
    return Container();
  }

  Widget _buildAndroidFilledButton(BuildContext context) {
    final text = _buildLabel();
    final loader = _buildLoader(context);

    final style = ElevatedButton.styleFrom(
      disabledBackgroundColor: disabledColor,
      elevation: 0,
      padding: padding,
      shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(8)),
      backgroundColor: buttonColor,
      foregroundColor: foregroundColor ?? Colors.white,
    );

    if (iconAsset != null && buttonIcon != null) {
      return const Text('You cannot use both iconAsset and buttonIcon');
    }

    // Button with text and icon
    if (label != null && buttonIcon != null) {
      return ElevatedButton.icon(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        icon: loading ? loader : buttonIcon!,
        label: text,
      );
    }

    //Button with text and asset icon
    if (label != null && iconAsset != null) {
      return ElevatedButton.icon(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        icon: loading ? loader : iconAsset!,
        label: text,
      );
    }

    // Button with only asset icon
    if (label == null && iconAsset != null) {
      return ElevatedButton(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        child: loading ? loader : iconAsset!,
      );
    }

    // Button with only button icon
    if (label == null && buttonIcon != null) {
      return ElevatedButton(
          style: style, onPressed: (disabled || loading) ? null : onPressed, child: loading ? loader : buttonIcon!);
    }

    //button with only text
    if (label != null && buttonIcon == null && iconAsset == null) {
      return ElevatedButton(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        child: loading ? loader : text,
      );
    }

    // Return an empty container if neither label nor iconAsset is provided
    return Material(child: Container());
  }

  Widget _buildAndroidOutlinedButton(BuildContext context) {
    final text = _buildLabel();
    final loader = _buildLoader(context);
    final isDisabled = loading || disabled;
    final color = _getColor(context, isDisabled);

    final style = OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: borderRadius ?? BorderRadius.circular(8)),
      minimumSize: const Size(double.infinity, 45),
      elevation: 0,
      padding: padding,
      foregroundColor: foregroundColor ?? color,
      side: BorderSide(
        color: color,
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w400,
      ),
    );

    if (iconAsset != null && buttonIcon != null) {
      return const Text('You cannot use both iconAsset and buttonIcon');
    }

    // Button with text and icon
    if (label != null && buttonIcon != null) {
      return OutlinedButton.icon(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        icon: loading ? loader : buttonIcon!,
        label: text,
      );
    }

    //Button with text and asset icon
    if (label != null && iconAsset != null) {
      return OutlinedButton.icon(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        icon: loading ? loader : iconAsset!,
        label: text,
      );
    }

    // Button with only asset icon
    if (label == null && iconAsset != null) {
      return OutlinedButton(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        child: loading ? loader : iconAsset!,
      );
    }

    // Button with only button icon
    if (label == null && buttonIcon != null) {
      return OutlinedButton(
          style: style, onPressed: (disabled || loading) ? null : onPressed, child: loading ? loader : buttonIcon!);
    }

    //button with only text
    if (label != null && buttonIcon == null && iconAsset == null) {
      return OutlinedButton(
        style: style,
        onPressed: (disabled || loading) ? null : onPressed,
        child: loading ? loader : text,
      );
    }

    // Return an empty container if neither label nor iconAsset is provided
    return Container();
  }

  Widget _buildIosTextButton(BuildContext context) {
    final isDisabled = loading || disabled;
    final color = _getColor(context, isDisabled);
    final text = _buildLabel(TextStyle(color: color));
    final loader = _buildLoader(context);
    var display = loading ? [loader] : [text];

    if (iconAsset != null && buttonIcon != null) {
      return const Text('You cannot use both iconAsset and buttonIcon');
    }

    // Button with only button icon
    if (label == null && buttonIcon != null) {
      final styledIcon = buttonIcon!;
      display = loading ? [loader] : [styledIcon];
    }

    //button with text and button icon
    if (label != null && buttonIcon != null) {
      final styledIcon = buttonIcon!;
      const spacer = SizedBox(width: 8);
      display = loading ? [loader, spacer, text] : [styledIcon, spacer, text];
    }

    // Button with text and asset icon
    if (label != null && iconAsset != null) {
      final styledIcon = iconAsset!;
      const spacer = SizedBox(width: 8);
      display = loading ? [loader, spacer, text] : [styledIcon, spacer, text];
    }

    return CupertinoButton(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      onPressed: (isDisabled) ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: display,
      ),
    );
  }

  Widget _buildIosFilledButton(BuildContext context) {
    final isDisabled = loading || disabled;
    final color = _getColor(context, isDisabled);
    final iosDisabledColor = isDisabled ? disabledColor : foregroundColor;

    final text = Flexible(child: _buildLabel(TextStyle(color: iosDisabledColor)));
    final loader = _buildLoader(context);

    var display = loading ? [loader] : [text];

    if (iconAsset != null && buttonIcon != null) {
      return const Text('You cannot use both iconAsset and buttonIcon');
    }

    // Button with only button icon
    if (label == null && buttonIcon != null) {
      final styledIcon = buttonIcon!;
      display = loading ? [loader] : [styledIcon];
    }

    //button with text and button icon
    if (label != null && buttonIcon != null) {
      final styledIcon = buttonIcon!;
      const spacer = SizedBox(width: 8);
      display = loading ? [loader, spacer, text] : [styledIcon, spacer, text];
    }

    // Button with text and asset icon
    if (label != null && iconAsset != null) {
      final styledIcon = iconAsset!;
      const spacer = SizedBox(width: 8);
      display = loading ? [loader, spacer, text] : [styledIcon, spacer, text];
    }

    return CupertinoButton(
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      color: color,
      padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      onPressed: (isDisabled) ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: display,
      ),
    );
  }

  Widget _buildIosOutlinedButton(BuildContext context) {
    final isDisabled = loading || disabled;
    final color = _getColor(context, isDisabled);
    final disabledColor = isDisabled ? Theme.of(context).disabledColor : color;

    // iOS has not very good styling of disabled button. So we manually fix it
    final text = Flexible(child: _buildLabel(TextStyle(color: disabledColor)));
    final loader = _buildLoader(context);

    // Button with text
    var display = loading ? [loader] : [text];

    if (iconAsset != null && buttonIcon != null) {
      return const Text('You cannot use both iconAsset and buttonIcon');
    }

    // Button with only button icon
    if (label == null && buttonIcon != null) {
      final styledIcon = buttonIcon!;
      display = loading ? [loader] : [styledIcon];
    }

    //button with text and button icon
    if (label != null && buttonIcon != null) {
      final styledIcon = buttonIcon!;
      const spacer = SizedBox(width: 8);
      display = loading ? [loader, spacer, text] : [styledIcon, spacer, text];
    }

    // Button with text and asset icon
    if (label != null && iconAsset != null) {
      final styledIcon = iconAsset!;
      const spacer = SizedBox(width: 8);
      display = loading ? [loader, spacer, text] : [styledIcon, spacer, text];
    }

    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: color), borderRadius: borderRadius ?? BorderRadius.circular(50)),
      child: CupertinoButton(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        onPressed: (isDisabled) ? null : onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: display,
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : CircularProgressIndicator(
              strokeWidth: 2,
              color: Theme.of(context).disabledColor,
            ),
    );
  }

  Text _buildLabel([TextStyle? overrideStyle]) {
    assert(!(label == null && buttonIcon == null && iconAsset == null),
        'Label and icon or icon Asset cannot both be empty');

    final style = TextStyle(fontSize: size, fontWeight: FontWeight.bold).merge(overrideStyle);
    if (label != null) return Text(label!, style: style);

    return Text(
      '',
      style: style,
    );
  }

  Color _getColor(BuildContext context, bool isDisabled) {
    return isDisabled ? Theme.of(context).disabledColor : buttonColor ?? Colors.white;
  }
}
