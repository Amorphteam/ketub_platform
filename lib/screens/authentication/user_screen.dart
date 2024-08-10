import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/firestore_reference_model.dart';
import '../../repositories/firestore_references_database.dart';

class UserScreen extends StatefulWidget {
  final User user;

  const UserScreen({super.key, required this.user});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final FirestoreReferencesDatabase _firestoreReferencesDatabase = FirestoreReferencesDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _addSampleReference(),
              child: const Text('Add Sample Reference'),
            ),
            ElevatedButton(
              onPressed: () => _getAllReferences(),
              child: const Text('Get All References'),
            ),
            ElevatedButton(
              onPressed: () => _getCountOfAllReferences(),
              child: const Text('Get Count of All References'),
            ),
            ElevatedButton(
              onPressed: () => _updateReference(),
              child: const Text('Update Reference'),
            ),
            ElevatedButton(
              onPressed: () => _getReferenceByBookTitleAndPage(),
              child: const Text('Get Reference By Book Title and Page'),
            ),
            ElevatedButton(
              onPressed: () => _getFilterReference(),
              child: const Text('Filter Reference'),
            ),
            ElevatedButton(
              onPressed: () => _isBookmarkExist(),
              child: const Text('Check if Bookmark Exists'),
            ),
            ElevatedButton(
              onPressed: () => _deleteReference(),
              child: const Text('Delete Reference'),
            ),
            ElevatedButton(
              onPressed: () => _deleteReferenceByBookPathAndPageNumber(),
              child: const Text('Delete Reference By Book Path and Page Number'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addSampleReference() async {
    FirestoreReferenceModel referenceModel = FirestoreReferenceModel(
      userId: widget.user.uid,
      title: 'Sample Titleee',
      bookName: 'Sample Bookk',
      bookPath: 'sample/book/path/ojh',
      navIndex: '677',
    );

    await _firestoreReferencesDatabase.addOrUpdateReference(referenceModel);
  }

  Future<void> _getAllReferences() async {
    List<FirestoreReferenceModel> references = await _firestoreReferencesDatabase.getAllReferences();
    print('References: $references');
  }

  Future<void> _getCountOfAllReferences() async {
    int count = await _firestoreReferencesDatabase.getCountOfAllReferences();
    print('Count of References: $count');
  }

  Future<void> _updateReference() async {
    FirestoreReferenceModel referenceModel = FirestoreReferenceModel(
      userId: widget.user.uid,
      title: 'Updated Title',
      bookName: 'Updated Book',
      bookPath: 'updated/book/path/pp',
      navIndex: '30',
    );
    await _firestoreReferencesDatabase.updateReference(referenceModel);
  }

  Future<void> _getReferenceByBookTitleAndPage() async {
    List<FirestoreReferenceModel> references = await _firestoreReferencesDatabase.getReferenceByBookTitleAndPage( 'sample/book/path', '1');
    print('References: $references');
  }

  Future<void> _getFilterReference() async {
    List<FirestoreReferenceModel> references = await _firestoreReferencesDatabase.getFilterReference( 'sample');
    print('References: $references');
  }

  Future<void> _isBookmarkExist() async {
    bool exists = await _firestoreReferencesDatabase.isBookmarkExist( 'sample/book/path', '1');
    print('Bookmark exists: $exists');
  }

  Future<void> _deleteReference() async {
    await _firestoreReferencesDatabase.deleteReference( 'sample/book/path', '1');
  }

  Future<void> _deleteReferenceByBookPathAndPageNumber() async {
    await _firestoreReferencesDatabase.deleteReferenceByBookPathAndPageNumber('sample/book/path', '1');
  }
}
