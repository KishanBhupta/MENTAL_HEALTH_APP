class Post {
  int? id;
  int? usersId;
  String? imageUrl;
  String? postText;
  String? postDescription;
  int? likes;
  int? postStatus;
  int? isAnonymous;
  String? createdAt;
  String? updatedAt;

  Post(
      {this.id,
        this.usersId,
        this.imageUrl,
        this.postText,
        this.postDescription,
        this.likes,
        this.postStatus,
        this.isAnonymous,
        this.createdAt,
        this.updatedAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    usersId = json['users_id'];
    imageUrl = json['imageUrl'];
    postText = json['postText'];
    postDescription = json['postDescription'];
    likes = json['likes'];
    postStatus = json['postStatus'];
    isAnonymous = json['isAnonymous'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['users_id'] = usersId;
    data['imageUrl'] = imageUrl;
    data['postText'] = postText;
    data['postDescription'] = postDescription;
    data['likes'] = likes;
    data['postStatus'] = postStatus;
    data['isAnonymous'] = isAnonymous;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}