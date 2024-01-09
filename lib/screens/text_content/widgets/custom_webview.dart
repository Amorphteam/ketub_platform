import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../models/style_model.dart';
import '../../../utils/style_helper.dart';
import '../epub/cubit/epub_cubit.dart';

class CustomWebView extends StatefulWidget {
  final String content;
  final EpubCubit? epubCubit;

  const CustomWebView({Key? key, required this.content, this.epubCubit});

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  StyleHelper styleHelper = StyleHelper();
  FontSize fontSize = FontSize(15);

  @override
  void initState() {
    super.initState();
    _initContent();
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<EpubCubit, EpubState>(
      listener: (context, state) {
        if (state is FontSizeChangedState) {
          setState(() {
            fontSize = FontSize(33);
          });
        } else if (state is LineSpaceChangedState) {
          _changeLineSpace(state.lineSpace);
        } else if (state is FontFamilyChangedState) {
          _changeFontFamily(state.fontFamily);
        }
      },
      builder: (context, state) {
        if (state is EpubContentWithCssLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(color: Colors.white,
              child: SingleChildScrollView(
                child: Html(data: state.content
                ,),
              ),
            ),
          );
        } else if (state is ErrorState) {
          return Text(state.error.toString());
        } else {
          return const Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      buildWhen: (previousState, state) {
        return state is EpubContentWithCssLoadedState || state is EpubLoadingState;
      },
    );
  }


  void _initContent() {
    widget.epubCubit?.loadModifiedContent(widget.content);
  }

  // void _changeFontSize(FontSize fontSize) {
    // _webViewController.runJavaScript('changeFontSize("${fontSize.name}")');
  // }

  void _changeLineSpace(LineSpace lineSpace) {
    // _webViewController.runJavaScript('changeLineSpace("${lineSpace.name}")');
  }

  void _changeFontFamily(FontFamily fontFamily) {
    // _webViewController.runJavaScript('changeFontFamily("${fontFamily.name}")');
  }
}
