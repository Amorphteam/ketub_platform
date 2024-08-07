import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firestore_reference_model.freezed.dart';
part 'firestore_reference_model.g.dart';

@freezed
class FirestoreReferenceModel with _$FirestoreReferenceModel {
  const factory FirestoreReferenceModel({
    required String userId,
    required String title,
    required String bookName,
    required String bookPath,
    required String navIndex,
  }) = _FirestoreReferenceModel;

  factory FirestoreReferenceModel.fromJson(Map<String, dynamic> json) =>
      _$FirestoreReferenceModelFromJson(json);

  factory FirestoreReferenceModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      return FirestoreReferenceModel.fromJson(data);
    } else {
      throw Exception('Document snapshot is null or does not exist');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'bookName': bookName,
      'bookPath': bookPath,
      'navIndex': navIndex,
    };
  }
}
