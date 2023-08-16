import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';

import '../models/book_model.dart';
import '../screens/epub/cubit/epub_cubit.dart';
import '../screens/epub/epub_screen.dart';

//TODO: Change it
void openEpub(BuildContext context, BookModel? book, ReferenceModel? reference, TreeTocModel? toc) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          BlocProvider(
            create: (context) => EpubCubit(),
            child: EpubScreen(bookModel: book, referenceModel: reference, tocModel: toc,),
          ),
    ),
  );
}