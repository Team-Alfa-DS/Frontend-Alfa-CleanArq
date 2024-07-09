import 'package:alpha_gymnastic_center/aplication/BLoC/search/search_bloc.dart';
import 'package:alpha_gymnastic_center/aplication/use_cases/search/search_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class InfiniteScrollingSearch extends StatefulWidget {
  final double scrollThreshold;
  final Axis scrollAxis;
  final List<Widget> widgetList;
  final int page;
  final int perpage;
  final List<String> tags;
  final String term;
  final bool noMoreContent;
  
  const InfiniteScrollingSearch(
    {
      super.key, 
      required this.widgetList,
      required this.scrollThreshold, 
      required this.scrollAxis,
      required this.page,
      required this.perpage,
      required this.tags,
      required this.term,
      required this.noMoreContent
    }
  );
  
  @override
  InfiniteScrollingSearchState createState() => InfiniteScrollingSearchState();
  
}

class InfiniteScrollingSearchState extends State<InfiniteScrollingSearch> {
  late final ScrollController _scrollController;
  late int _lastListLength;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _lastListLength = 0;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(searchUseCase: GetIt.instance<SearchUseCase>()),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return ListView.builder(
            controller: _scrollController,
            scrollDirection: widget.scrollAxis,
            itemCount: widget.widgetList.length + 1,
            itemBuilder: _itemBuilder);
            }
        ) 

       /* ListView(
        controller: _scrollController,
        scrollDirection: widget.scrollAxis,
        children: widget.widgetList,
      ), */  
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if(_lastListLength != widget.widgetList.length) {
        _lastListLength = widget.widgetList.length;
        if (!widget.noMoreContent) {
          BlocProvider.of<SearchBloc>(context).add(SearchSent(widget.page, widget.perpage, widget.tags, widget.term));
        }
      }
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (index == widget.widgetList.length) {
          if (state is SearchLoading) {
            return const Center(
              heightFactor: 1,
              widthFactor: 1,
              child: SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        } else {
          return widget.widgetList[index];
        }
      }
    );
  }
}