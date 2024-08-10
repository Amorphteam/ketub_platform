import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/firestore_reference_model.dart';
import '../utils/auth_helper.dart';

class FirestoreReferencesDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> addOrUpdateReference(FirestoreReferenceModel referenceModel) async {
    User user = AuthHelper.getAuthenticatedUser();

    if (referenceModel.userId != user.uid) {
      throw Exception('User ID does not match the authenticated user.');
    }

    QuerySnapshot query = await _firestore.collection('references')
        .where('userId', isEqualTo: user.uid)
        .where('bookPath', isEqualTo: referenceModel.bookPath)
        .where('navIndex', isEqualTo: referenceModel.navIndex)
        .get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot doc = query.docs.first;
      await doc.reference.update(referenceModel.toJson());
    } else {
      await _firestore.collection('references').add(referenceModel.toJson());
    }
    return 1;
  }

  Future<List<FirestoreReferenceModel>> getAllReferences() async {
    User user = AuthHelper.getAuthenticatedUser();

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: user.uid)
        .get();

    return snapshot.docs.map((doc) {
      return FirestoreReferenceModel.fromFirestore(doc);
    }).toList();
  }

  Future<int> getCountOfAllReferences() async {
    User user = AuthHelper.getAuthenticatedUser();

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: user.uid)
        .get();

    return snapshot.size;
  }

  Future<void> updateReference(FirestoreReferenceModel referenceModel) async {
    User user = AuthHelper.getAuthenticatedUser();

    if (referenceModel.userId != user.uid) {
      throw Exception('User ID does not match the authenticated user.');
    }

    QuerySnapshot query = await _firestore.collection('references')
        .where('userId', isEqualTo: user.uid)
        .where('bookPath', isEqualTo: referenceModel.bookPath)
        .where('navIndex', isEqualTo: referenceModel.navIndex)
        .get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot doc = query.docs.first;
      await doc.reference.update(referenceModel.toJson());
    } else {
      throw Exception('Document not found');
    }
  }

  Future<List<FirestoreReferenceModel>> getReferenceByBookTitleAndPage(String bookPath, String pageNumber) async {
    User user = AuthHelper.getAuthenticatedUser();

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: user.uid)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: pageNumber)
        .get();

    return snapshot.docs.map((doc) {
      return FirestoreReferenceModel.fromFirestore(doc);
    }).toList();
  }

  Future<List<FirestoreReferenceModel>> getFilterReference(String query) async {
    User user = AuthHelper.getAuthenticatedUser();

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: user.uid)
        .get();

    List<FirestoreReferenceModel> filteredList = snapshot.docs.map((doc) {
      return FirestoreReferenceModel.fromFirestore(doc);
    }).toList();

    if (query.isNotEmpty) {
      filteredList = filteredList.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    return filteredList;
  }

  Future<bool> isBookmarkExist(String bookPath, String pageNumber) async {
    User user = AuthHelper.getAuthenticatedUser();

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: user.uid)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: pageNumber)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> deleteReference(String bookPath, String navIndex) async {
    User user = AuthHelper.getAuthenticatedUser();

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: user.uid)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: navIndex)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<int> deleteReferenceByBookPathAndPageNumber(String bookPath, String pageNumber) async {
    User user = AuthHelper.getAuthenticatedUser();

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: user.uid)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: pageNumber)
        .get();

    int deletedCount = 0;

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
      deletedCount++;
    }

    return deletedCount;
  }
}
