import 'package:freezed_annotation/freezed_annotation.dart';

part 'slie_online.freezed.dart';
part 'slie_online.g.dart';


@freezed
class SlideOnline with _$SlideOnline {
  const factory SlideOnline({
    int? id,
    int? priority,
    String? title,
    String? description,
    String? url,
    String? link,
  }) = _SlideOnline;

  factory SlideOnline.fromJson(Map<String, dynamic> json) => _$SlideOnlineFromJson(json);
}
