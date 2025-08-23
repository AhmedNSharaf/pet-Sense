class CommentModel {
  final String name;
  final String image;
  final String comment;
  final int numberOfLikes;
  final String time;
  CommentModel({
    required this.image,
    required this.name,
    required this.comment,
    required this.numberOfLikes,
    required this.time,
  });
}
