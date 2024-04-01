class SubSavedPost {
  int? id;
  int? usersId;
  int? postsId;
  String? createdAt;
  String? updatedAt;

  SubSavedPost(
      {this.id, this.usersId, this.postsId, this.createdAt, this.updatedAt});

  SubSavedPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    postsId = json['posts_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['users_id'] = usersId;
    data['posts_id'] = postsId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}