import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
class HtmlHelper {
  static
 Widget loadHtml(String data) {
    return SingleChildScrollView(
      child: Html(
        data: data,
        style: {
          "html": Style(
              padding: HtmlPaddings.all(16),
              textAlign: TextAlign.justify,
              direction: TextDirection.rtl,
              lineHeight: LineHeight.number(1.5),
              fontSize: FontSize.large,
              fontFamily: 'tajwal'),
          "h1,h2,h3": Style(
              textAlign: TextAlign.right,
              direction: TextDirection.rtl,
              padding: HtmlPaddings.only(top: 30),
              fontSize: FontSize.xLarge,
              fontWeight: FontWeight.bold,
              fontFamily: 'tajwal'),
        },
      ),
    );
  }}