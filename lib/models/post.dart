import 'package:equatable/equatable.dart'; // to compare different instances of class

final class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  const Post({required this.id, required this.title, required this.body});

  @override
  List<Object> get props => [id, title, body];
}
