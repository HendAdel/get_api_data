part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class PostFetched extends PostsEvent {}
