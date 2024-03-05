import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/main/shared_widgets/search_bar_widget.dart';
import 'package:ketub_platform/screens/main/toc_tab/widgets/toc_tree_list_widget.dart';

import '../../../utils/epub_helper.dart';
import 'cubit/toc_cubit.dart';


class TocScreen extends StatefulWidget {
  final String bookPath;

  const TocScreen({super.key, required this.bookPath});

  @override
  _TocScreenState createState() => _TocScreenState();
}

class _TocScreenState extends State<TocScreen> {
  @override
  void initState() {
    super.initState();
    _loadToc(context, null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBarWiget(),
      ),
      body: Column(
        children: [
          BlocConsumer<TocCubit, TocState>(
            listener: (context, state) {
              if (state is TocErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error.toString())));
              } else if (state is TocItemTappedState){
                final EpubChaptersWithBookPath chapterWithBookPath = EpubChaptersWithBookPath(state.toc, widget.bookPath);
                openEpub(context: context, toc: chapterWithBookPath);
              }
            },
            builder: (context, state) {
              if (state is TocLoadedState) {
                return Placeholder();
                  // EpubChapterListWidget(tocTreeList: state.tocTreeList);
              } else if (state is TocLoadingState) {
                return CircularProgressIndicator();
              } else {
                return const SizedBox.shrink();
              }
            },
            buildWhen: (previousState, state) {
              return state is TocLoadedState || state is TocLoadingState;
            },
          ),
        ],
      ),
    );
  }

  _loadToc(BuildContext context, String? query) {
    BlocProvider.of<TocCubit>(context).loadToc(query: query ?? '', bookPath: widget.bookPath);
  }

}
