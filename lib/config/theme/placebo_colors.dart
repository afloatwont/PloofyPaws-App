import 'package:flutter/material.dart';

class Surface {
  final Color s50;
  final Color s100;
  final Color s200;
  final Color s300;
  final Color s500;

  const Surface({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s500,
  });
}

class ColorShades {
  final Color s50;
  final Color s100;
  final Color s200;
  final Color s300;
  final Color s400;
  final Color s500;
  final Color s600;
  final Color s700;
  final Color s800;
  final Color s900;

  const ColorShades({
    required this.s50,
    required this.s100,
    required this.s200,
    required this.s300,
    required this.s400,
    required this.s500,
    required this.s600,
    required this.s700,
    required this.s800,
    required this.s900,
  });
}

class Decorative {
  final DecorativeShades one;
  final DecorativeShades two;
  final DecorativeShades three;
  final DecorativeShades four;

  const Decorative({
    required this.one,
    required this.two,
    required this.three,
    required this.four,
  });
}

class DecorativeShades {
  final Color s50;
  final Color s100;
  final Color s200;

  const DecorativeShades({required this.s50, required this.s100, required this.s200});
}

class Common {
  final CommonShades? white;
  final CommonShades? black;

  const Common({required this.white, required this.black});
}

class CommonShades {
  final Color s200;
  final Color s300;
  final Color s400;
  final Color s500;
  final Color s600;
  final Color s700;

  const CommonShades({
    required this.s200,
    required this.s300,
    required this.s400,
    required this.s500,
    required this.s600,
    required this.s700,
  });
}

@immutable
class PlaceboColors extends ThemeExtension<PlaceboColors> {
  final Surface surface;
  final ColorShades onSurface;
  final ColorShades primary;
  final ColorShades secondary;
  final ColorShades success;
  final ColorShades warning;
  final ColorShades critical;
  final ColorShades highlight;
  final Decorative decorative;
  final Common common;

  const PlaceboColors({
    required this.surface,
    required this.onSurface,
    required this.primary,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.critical,
    required this.highlight,
    required this.decorative,
    required this.common,
  });

  @override
  PlaceboColors copyWith({
    Color? success,
    Color? info,
    Color? warning,
    Color? danger,
  }) {
    throw ErrorDescription('copyWith is not supported on Placebo');
  }

  // Controls how the properties change on theme changes
  @override
  PlaceboColors lerp(ThemeExtension<PlaceboColors>? other, double t) {
    // if (other is! PlaceboColors) {
    //   return this;
    // }
    return this;

    // return PlaceboColors(
    //   success: Color.lerp(success, other.success, t),
    //   info: Color.lerp(info, other.info, t),
    //   warning: Color.lerp(warning, other.warning, t),
    //   danger: Color.lerp(danger, other.danger, t),
    // );
  }

  @override
  toString() => 'PlaceboColors()';

  // the light theme
  static const light = PlaceboColors(
      surface: Surface(
        s50: Color(0xFFF8FAFC),
        s100: Color(0xFFF1F5F9),
        s200: Color(0xFFE2E8F0),
        s300: Color(0xFFCBD5E1),
        s500: Color(0xFFFFFFFF),
      ),
      onSurface: ColorShades(
        s50: Color(0xFFF8FAFC),
        s100: Color(0xFFF1F5F9),
        s200: Color(0xFFE2E8F0),
        s300: Color(0xFFCBD5E1),
        s400: Color(0xFF94A3B8),
        s500: Color(0xFF64748B),
        s600: Color(0xFF475569),
        s700: Color(0xFF334155),
        s800: Color(0xFF1E293B),
        s900: Color(0xFF0F172A),
      ),
      primary: ColorShades(
        s50: Color(0xFFEDF0FE),
        s100: Color(0xFFDAE0FD),
        //C9DFF5
        s200: Color(0xFFC9DFF5),
        s300: Color(0xFF90A3FA),
        s400: Color(0xFF6B85F8),
        s500: primaryColor,
        s600: Color(0xFF3852C5),
        s700: Color(0xFF2A3D94),
        s800: Color(0xFF1C2962),
        s900: Color(0xFF0E1431),
      ),
      secondary: ColorShades(
        s50: Color(0xFFF8FAFC),
        s100: Color(0xFFF1F5F9),
        s200: Color(0xFFE2E8F0),
        s300: Color(0xFFCBD5E1),
        s400: Color(0xFF94A3B8),
        s500: Color(0xFF64748B),
        s600: Color(0xFF475569),
        s700: Color(0xFF334155),
        s800: Color(0xFF1E293B),
        s900: Color(0xFF0F172A),
      ),
      success: ColorShades(
        s50: Color(0xFFECF6F4),
        s100: Color(0xFFDAEDE9),
        s200: Color(0xFFCAF0D8),
        s300: Color(0xFF70BAAC),
        s400: Color(0xFF42A491),
        s500: Color(0xFF138D75),
        s600: Color(0xFF0F715E),
        s700: Color(0xFF0B5446),
        s800: Color(0xFF094338),
        s900: Color(0xFF07332A),
      ),
      warning: ColorShades(
        s50: Color(0xFFFDF9EC),
        s100: Color(0xFFFCF3D8),
        s200: Color(0xFFFAEDCD),
        s300: Color(0xFFF2D16A),
        s400: Color(0xFFEEC239),
        s500: Color(0xffFBBC04),
        s600: Color(0xFFBB8F06),
        s700: Color(0xFF8B6B05),
        s800: Color(0xFF705604),
        s900: Color(0xFF544103),
      ),
      critical: ColorShades(
        s50: Color(0xFFFBF0F0),
        s100: Color(0xFFF7E1E1),
        s200: Color(0xFFEDB9B9),
        s300: Color(0xFFE18A8A),
        s400: Color(0xFFD86565),
        s500: Color(0xFFCE3E3E),
        s600: Color(0xFFA53232),
        s700: Color(0xFFB53B3B),
        s800: Color(0xFF991B1B),
        s900: Color(0xFF4A1616),
      ),
      highlight: ColorShades(
        s50: Color(0xFFEFF6FF),
        s100: Color(0xFFDBEAFE),
        s200: Color(0xFFBFDBFE),
        s300: Color(0xFF93C5FD),
        s400: Color(0xFF60A5FA),
        s500: Color(0xFF3B82F6),
        s600: Color(0xFF2563EB),
        s700: Color(0xFF1D4ED8),
        s800: Color(0xFF1E40AF),
        s900: Color(0xFF1E3A8A),
      ),
      decorative: Decorative(
        one: DecorativeShades(
          s50: Color(0xFFFDF1E7),
          s100: Color(0xFFE5A256),
          s200: Color(0xFF533A1F),
        ),
        two: DecorativeShades(
          s50: Color(0xFFF0E6F7),
          s100: Color(0xFF9A7BBA),
          s200: Color(0xFF382C43),
        ),
        three: DecorativeShades(
          s50: Color(0xFFE5F6F6),
          s100: Color(0xFF49B7CC),
          s200: Color(0xFF1A424A),
        ),
        four: DecorativeShades(
          s50: Color(0xFFF5F8EF),
          s100: Color(0xFF97BC62),
          s200: Color(0xFF364423),
        ),
      ),
      common: Common(
        white: CommonShades(
          s200: Color(0xFFFFFAF0),
          s300: Color(0xFFFFFAFA),
          s400: Color(0xFFFEFEFA),
          s500: Color(0xFFFFFFFF),
          s600: Color(0xFFF5F5F5),
          s700: Color(0xFFF8F8FF),
        ),
        black: CommonShades(
          s200: Color(0xFF171717),
          s300: Color(0xFF141414),
          s400: Color(0xFF0f0f0f),
          s500: Color(0xFF0a0a0a),
          s600: Color(0xFF080808),
          s700: Color(0xFF000000),
        ),
      ));
// // the dark theme
// static const dark = PlaceboColors(
//   success: const Color(0xff00bc8c),
//   info: const Color(0xff17a2b8),
//   warning: const Color(0xfff39c12),
//   danger: const Color(0xffe74c3c),
// );
}

const primaryColor = Color(0xFF1A24DE);
