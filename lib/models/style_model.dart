import 'package:flutter_html/flutter_html.dart';

enum FontSizeCustom {
  xxSmall(7.875),
  xSmall(8.75),
  small(11.375),
  medium(14.0),
  large(15.75),
  xLarge(21.0),
  xxLarge(28.0);

  final double size;
  const FontSizeCustom(this.size);
}


enum LineHeightCustom {
  xxSmall(0.9),
  xSmall(1.1),
  small(1.3),
  medium(1.5),
  large(1.7),
  xLarge(1.9),
  xxLarge(2.1);

  final double size;
  const LineHeightCustom(this.size);
}

enum FontFamily{
  font1,
  font2,
  font3,
  font4,
  font5
}

