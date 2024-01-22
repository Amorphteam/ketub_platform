import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ketub_platform/screens/html_viewer/cubit/html_viewer_cubit.dart';

import 'cubit/html_viewer_state.dart';

class HtmlViewerScreen extends StatefulWidget {
  const HtmlViewerScreen({super.key});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
  @override
  void initState() {
    BlocProvider.of<HtmlViewerCubit>(context).loadText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HtmlViewerCubit, HtmlViewerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_getAppBarTitle(state), style: const TextStyle(fontFamily: 'font4'),),
          ),
          body: Center(
            child: _buildBodyContent(state),
          ),
        );
      },
    );
  }

  String _getAppBarTitle(HtmlViewerState state) {
    return state.maybeWhen(
      loaded: (_, title) => title,
      orElse: () => '',
    );
  }

  Widget _buildBodyContent(HtmlViewerState state) {
    return state.when(
      initial: () => const Text('Initial State'),
      loading: () => const CircularProgressIndicator(),
      loaded: (data, _) => loadHtml(data),
      error: (error) => Text(error ?? 'Error'),
    );
  }
}

Widget loadHtml(String data) {
  return SingleChildScrollView(
    child: Html(
      data: data,
      style: {
        "html": Style(
            textAlign: TextAlign.justify,
            direction: TextDirection.rtl,
            fontSize: FontSize.large,
            fontFamily: 'font1'),
        "h1,h2,h3": Style(
            textAlign: TextAlign.justify,
            direction: TextDirection.rtl,
            padding: HtmlPaddings.only(top: 30),
            fontSize: FontSize.xLarge,
            fontWeight: FontWeight.bold,
            fontFamily: 'font3'),
      },
    ),
  );
}
