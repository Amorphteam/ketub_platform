import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                double opacity = (top - kToolbarHeight) / (200.0 - kToolbarHeight);
                opacity = opacity < 0.17 ? 0 : opacity > 1 ? 1 : opacity;

                debugPrint(opacity.toString());
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    FlexibleSpaceBar(
                      background: Image.asset(
                        'assets/images/banner.png', // Replace with your image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 16,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: opacity, // Apply opacity only to date and icon
                              child: Row(
                                children: [
                                  Text(_getAppBarDate(state), style: Theme.of(context).textTheme.labelLarge,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset('assets/icons/calendar.svg'),
                                  )
                                ],
                              ),
                            ),
                            Text(_getAppBarTitle(state), style: Theme.of(context).textTheme.titleLarge,), // Title remains always visible
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: _buildBodyContent(state),
            ),
          ),
        ],
      ),
    );
  },
);
  }

  String _getAppBarDate(HtmlViewerState state) {
    return state.maybeWhen(
      loaded: (_, __, date) => date.split('T')[0],
      orElse: () => '',
    );
  }
  String _getAppBarTitle(HtmlViewerState state) {
    return state.maybeWhen(
      loaded: (_, title, __) => title,
      orElse: () => '',
    );
  }

  Widget _buildBodyContent(HtmlViewerState state) {
    return state.when(
      initial: () => const Text('Initial State'),
      loading: () => const CircularProgressIndicator(),
      loaded: (data, _, __) => loadHtml(data),
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
            lineHeight: LineHeight.number(1.5),
            fontSize: FontSize.large,
            fontFamily: 'tajwal'),
        "h1,h2,h3": Style(
            textAlign: TextAlign.right,
            direction: TextDirection.rtl,
            padding: HtmlPaddings.only(top: 30),
            fontSize: FontSize.xLarge,
            fontWeight: FontWeight.bold,
            fontFamily: 'tajwal'),
      },
    ),
  );
}
