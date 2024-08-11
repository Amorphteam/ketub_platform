import 'package:collection/collection.dart';
import 'package:ketub_platform/repositories/reference_database.dart';

import '../models/firestore_reference_model.dart';
import '../models/reference_model.dart';
import '../utils/auth_helper.dart';
import 'firestore_references_database.dart';

class SyncService {
  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;
  final FirestoreReferencesDatabase firestoreReferencesDatabase =
      FirestoreReferencesDatabase();

  Future<void> syncOfflineAndOnlineData() async {
    final localReferences = await referencesDatabase.getAllReferences();

    final onlineReferences =
        await firestoreReferencesDatabase.getAllReferences();

    for (var onlineReference in onlineReferences) {
      final existingLocal = localReferences.firstWhereOrNull(
        (local) =>
            local.bookPath == onlineReference.bookPath &&
            local.navIndex == onlineReference.navIndex,
      );

      if (existingLocal == null) {
        await referencesDatabase.addReference(ReferenceModel(
          title: onlineReference.title,
          bookName: onlineReference.bookName,
          bookPath: onlineReference.bookPath,
          navIndex: onlineReference.navIndex,
        ));
      }
    }

    for (var localReference in localReferences) {
      final existingOnline = onlineReferences.firstWhereOrNull(
        (online) =>
            online.bookPath == localReference.bookPath &&
            online.navIndex == localReference.navIndex,
      );

      if (existingOnline == null) {
        await firestoreReferencesDatabase
            .addOrUpdateReference(FirestoreReferenceModel(
          userId: AuthHelper.getAuthenticatedUser().uid,
          title: localReference.title,
          bookName: localReference.bookName,
          bookPath: localReference.bookPath,
          navIndex: localReference.navIndex,
        ));
      } else {
        await firestoreReferencesDatabase
            .addOrUpdateReference(FirestoreReferenceModel(
          userId: AuthHelper.getAuthenticatedUser().uid,
          title: localReference.title,
          bookName: localReference.bookName,
          bookPath: localReference.bookPath,
          navIndex: localReference.navIndex,
        ));
      }
    }
  }

  Future<void> syncOfflineDataWithFirestore() async {
    final localReferences = await referencesDatabase.getAllReferences();

    final userId = AuthHelper.getAuthenticatedUser().uid;
    final onlineReferences =
        await firestoreReferencesDatabase.getAllReferences();

    for (var onlineReference in onlineReferences) {
      final existingLocal = localReferences.firstWhereOrNull(
        (local) =>
            local.bookPath == onlineReference.bookPath &&
            local.navIndex == onlineReference.navIndex,
      );

      if (existingLocal == null) {
        await firestoreReferencesDatabase.deleteReference(
            onlineReference.bookPath, onlineReference.navIndex);
      }
    }

    for (var localReference in localReferences) {
      final existingOnline = onlineReferences.firstWhereOrNull(
        (online) =>
            online.bookPath == localReference.bookPath &&
            online.navIndex == localReference.navIndex,
      );

      if (existingOnline == null) {
        await firestoreReferencesDatabase
            .addOrUpdateReference(FirestoreReferenceModel(
          userId: userId,
          title: localReference.title,
          bookName: localReference.bookName,
          bookPath: localReference.bookPath,
          navIndex: localReference.navIndex,
        ));
      } else if (existingOnline.title != localReference.title ||
          existingOnline.bookName != localReference.bookName) {
        await firestoreReferencesDatabase
            .addOrUpdateReference(FirestoreReferenceModel(
          userId: userId,
          title: localReference.title,
          bookName: localReference.bookName,
          bookPath: localReference.bookPath,
          navIndex: localReference.navIndex,
        ));
      }
    }
  }
}
