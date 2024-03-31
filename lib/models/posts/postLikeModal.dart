class PostLike {
  int? id;
  int? postsId;
  int? usersId;
  String? createdAt;
  String? updatedAt;

  PostLike(
      {this.id, this.postsId, this.usersId, this.createdAt, this.updatedAt});

  PostLike.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postsId = json['posts_id'];
    usersId = json['users_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['posts_id'] = postsId;
    data['users_id'] = usersId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}