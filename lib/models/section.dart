import 'package:freezed_annotation/freezed_annotation.dart';

part 'section.freezed.dart';
part 'section.g.dart';

@freezed
class Section with _$Section {
  const factory Section({
    int? id,
    required String title,
    required String bookPath,
    required String bookName,
    required int sectionIndex,
  }) = _Section;

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
}
