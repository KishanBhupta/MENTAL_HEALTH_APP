class CommentLike {
  int? id;
  int? commentId;
  int? usersId;
  String? createdAt;
  String? updatedAt;

  CommentLike(
      {this.id, this.commentId, this.usersId, this.createdAt, this.updatedAt});

  CommentLike.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['comment_id'];
    usersId = json['users_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comment_id'] = commentId;
    data['users_id'] = usersId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}