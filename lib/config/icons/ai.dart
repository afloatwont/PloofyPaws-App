import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AIIcon extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;

  const AIIcon({super.key, this.color, this.width, this.height});

  @override
  Widget build(BuildContext context) => SvgPicture.string(
        '''
<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">
<g clip-path="url(#clip0_774_5174)">
<path d="M8.25008 3.6665L10.5417 8.70817L15.5834 10.9998L10.5417 13.2915L8.25008 18.3332L5.95841 13.2915L0.916748 10.9998L5.95841 8.70817L8.25008 3.6665ZM8.25008 8.094L7.33341 10.0832L5.34425 10.9998L7.33341 11.9165L8.25008 13.9057L9.16675 11.9165L11.1559 10.9998L9.16675 10.0832L8.25008 8.094ZM17.4167 8.24984L16.2617 5.73817L13.7501 4.58317L16.2617 3.43734L17.4167 0.916504L18.5626 3.43734L21.0834 4.58317L18.5626 5.73817L17.4167 8.24984ZM17.4167 21.0832L16.2617 18.5715L13.7501 17.4165L16.2617 16.2707L17.4167 13.7498L18.5626 16.2707L21.0834 17.4165L18.5626 18.5715L17.4167 21.0832Z" fill="url(#paint0_linear_774_5174)"/>
</g>
<defs>
<linearGradient id="paint0_linear_774_5174" x1="11.0001" y1="0.916504" x2="11.0001" y2="21.0832" gradientUnits="userSpaceOnUse">
<stop stop-color="#2828FF"/>
<stop offset="0.48" stop-color="#FBBC04"/>
</linearGradient>
<clipPath id="clip0_774_5174">
<rect width="22" height="22" fill="white"/>
</clipPath>
</defs>
</svg>
''',
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        width: width,
        height: height,
      );
}
