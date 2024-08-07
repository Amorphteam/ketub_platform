import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/firestore_reference_model.dart';

class FirestoreReferencesDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOrUpdateReference(FirestoreReferenceModel referenceModel) async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot query = await _firestore.collection('references')
        .where('userId', isEqualTo: referenceModel.userId)
        .where('bookPath', isEqualTo: referenceModel.bookPath)
        .where('navIndex', isEqualTo: referenceModel.navIndex)
        .get();

    if (query.docs.isNotEmpty) {
      DocumentSnapshot doc = query.docs.first;
      await doc.reference.update(referenceModel.toJson());
    } else {
      await _firestore.collection('references').add(referenceModel.toJson());
    }
  }

  Future<List<FirestoreReferenceModel>> getAllReferences(String userId) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc) {
      return FirestoreReferenceModel.fromFirestore(doc);
    }).toList();
  }

  Future<int> getCountOfAllReferences(String userId) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.size;
  }

  Future<void> updateReference(FirestoreReferenceModel referenceModel) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot query = await _firestore.collection('references')
        .where('userId', isEqualTo: referenceModel.userId)
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

  Future<List<FirestoreReferenceModel>> getReferenceByBookTitleAndPage(String userId, String bookPath, String pageNumber) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: userId)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: pageNumber)
        .get();

    return snapshot.docs.map((doc) {
      return FirestoreReferenceModel.fromFirestore(doc);
    }).toList();
  }

  Future<List<FirestoreReferenceModel>> getFilterReference(String userId, String query) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: userId)
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

  Future<bool> isBookmarkExist(String userId, String bookPath, String pageNumber) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: userId)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: pageNumber)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<void> deleteReference(String userId, String bookPath, String navIndex) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: userId)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: navIndex)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> deleteReferenceByBookPathAndPageNumber(String userId, String bookPath, String pageNumber) async {
    // Check if the user is authenticated
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('User is not authenticated');
    }

    QuerySnapshot snapshot = await _firestore
        .collection('references')
        .where('userId', isEqualTo: userId)
        .where('bookPath', isEqualTo: bookPath)
        .where('navIndex', isEqualTo: pageNumber)
        .get();

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
