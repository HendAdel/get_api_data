import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_api_data/bloc/posts_bloc.dart';
import 'package:get_api_data/posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollerController = ScrollController();
  @override
  void initState(){
    super.initState();
    _scrollerController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsEvent>(
    builder: (context, state){
      switch (state.status) {
        case PostStatus.failure:
          return const Center(child: Text('Failed to fetch Posts'),);
        case PostStatus.success:
          if(state.posts.isEmpty){
            return const Center(child: Text('no posts'),);
          }
          return ListView.builder(itemBuilder: (BuildContext context, int index) {
            return index => state.posts.length ? const BottomLoader() : 
            PostListItem(post: state.posts[index]);
          },
          itemCount: state.hasReachedMax ? state.posts.length
          : state.posts.length + 1,
          controller: _scrollerController,
          );
          case PostStatus.initial:
          return const Center(child: CircularProgressIndicator());         
       
      }
    },
    );
  }

  @override
  void dispose(){
    _scrollerController ..removeListener(_onScroll)
    ..dispose();
    super.dispose();
  }

  void _onScroll(){
    if(_isBottom) context.read<PostsBloc>().add(PostFetched());
  }

  bool get _isBottom{
    if(!_scrollerController.hasClients) return false;
    final maxScroll = _scrollerController.position.maxScrollExtent;
    final currentScroll = _scrollerController.offset;
    return currentScroll >= (maxScroll * 0.9);

  }
}
