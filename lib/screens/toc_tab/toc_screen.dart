import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/toc_tab/cubit/toc_cubit.dart';
import 'package:ketub_platform/screens/toc_tab/widgets/toc_tree_list_widget.dart';
import '../../utils/epub_helper.dart';

class TocScreen extends StatefulWidget {
  const TocScreen({super.key});

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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextField(
            onChanged: (value) => _loadToc(context, value),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        BlocConsumer<TocCubit, TocState>(
          listener: (context, state) {
            if (state is TocErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.toString())));
            } else if (state is TocItemTappedState){
              openEpub(context, null, null, state.toc);
            }
          },
          builder: (context, state) {
            if (state is TocLoadedState) {
              return Expanded(
                child: TocTreeListWidget(tocList: state.tocTreeList),
              );
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
    );
  }

  _loadToc(BuildContext context, String? query) {
    BlocProvider.of<TocCubit>(context).loadToc(query: query ?? '');
  }

}
