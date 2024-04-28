import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:ketub_platform/screens/html_viewer/cubit/html_viewer_cubit.dart';
import 'package:ketub_platform/utils/html_helper.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/html_viewer_state.dart';

class HtmlViewerScreen extends StatefulWidget {
  int? id;
  String? data;

  HtmlViewerScreen({super.key, this.id, this.data});

  @override
  State<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends State<HtmlViewerScreen> {
  @override
  void initState() {
    BlocProvider.of<HtmlViewerCubit>(context).loadText(widget.id);
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
                    double opacity =
                        (top - kToolbarHeight) / (200.0 - kToolbarHeight);
                    opacity = opacity < 0.17
                        ? 0
                        : opacity > 1
                            ? 1
                            : opacity;
                    double scale =
                        0 + (top - kToolbarHeight) / (200.0 - kToolbarHeight);
                    scale = scale < 0.5
                        ? 0.7
                        : scale > 1
                            ? 1
                            : scale;

                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        FlexibleSpaceBar(
                          background: Image.asset(
                            'assets/images/banner.png',
                            // Replace with your image asset
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 16,
                          right: 36,
                          bottom: 16,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getAppBarTitle(state),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .fontSize! *
                                            scale,
                                      ),
                                  maxLines: opacity > 0 ? null : 1,
                                  overflow: opacity > 0
                                      ? TextOverflow.visible
                                      : TextOverflow.ellipsis,
                                ),
                                opacity > 0.4
                                    ? Opacity(
                                        opacity: opacity,
                                        child: _getHeaderDetails(state))
                                    : SizedBox(),
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
      loaded: (article) => article.createdAt?.split('T')[0] ?? '',
      orElse: () => '',
    );
  }

  Widget _getAppBarDateIcon(HtmlViewerState state) {
    return state.maybeWhen(
      loaded: (article) {
        return SvgPicture.asset('assets/icons/calendar.svg');
      },
      orElse: () => const Text(''),
    );
  }

  String _getAppBarTitle(HtmlViewerState state) {
    return state.maybeWhen(
      loaded: (article) => article.name ?? '',
      orElse: () => '',
    );
  }

  Widget _buildBodyContent(HtmlViewerState state) {
    return state.when(
      initial: () => const Text('Initial State'),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Center(child: CircularProgressIndicator()),
      ),
      loaded: (article) => HtmlHelper.loadHtml(article.description ?? ''),
      error: (error) => Text(error ?? 'Error'),
    );
  }

  Widget _getHeaderDetails(HtmlViewerState state) {
    return state.maybeWhen(
      loaded: (article) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (article.docDownloadLink != null &&
                    article.docDownloadLink!.isNotEmpty)
                ? TextButton(
                    onPressed: () {
                      _downloadFile(article.docDownloadLink ?? '');
                    },
                    child: const Text('تحميل Word'),
                  )
                : SizedBox(),
            (article.pdfDownloadLink != null &&
                    article.pdfDownloadLink!.isNotEmpty)
                ? TextButton(
                    onPressed: (){
                      _downloadFile(article.pdfDownloadLink ?? '');
                    },
                    child: const Text('تحميل PDF'),
                  )
                : SizedBox(),
            Row(
              children: [
                Text(
                  article.createdAt?.split('T')[0] ?? '',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/icons/calendar.svg'),
                ),
              ],
            ),
          ],
        );
      },
      orElse: () => Text(''),
    );
  }

  Future<void> _downloadFile(String url) async {
    var googleDocsUrl = 'https://docs.google.com/gview?embedded=true&url=${Uri.encodeQueryComponent(url)}';
    final Uri uri = Uri.parse(googleDocsUrl);
    launchUrl(uri);
  }


}
