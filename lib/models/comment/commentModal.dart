import 'package:mental_helth_wellness/models/comment/commentLikeModal.dart';
import 'package:mental_helth_wellness/models/userModel.dart';

class Comment {
  int? id;
  int? postsId;
  int? usersId;
  int? isAnonymous;
  int? likes;
  String? commentDescription;
  int? commentStatus;
  String? createdAt;
  String? updatedAt;
  UserModel? commentUser;
  List<CommentLike> commentLikes = [];

  Comment(
      {this.id,
        this.postsId,
        this.usersId,
        this.isAnonymous,
        this.likes,
        this.commentDescription,
        this.commentStatus,
        this.createdAt,
        this.updatedAt,
        this.commentUser});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postsId = json['posts_id'];
    usersId = json['users_id'];
    isAnonymous = json['isAnonymous'];
    likes = json['likes'];
    commentDescription = json['commentDescription'];
    commentStatus = json['commentStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['posts_id'] = postsId;
    data['users_id'] = usersId;
    data['isAnonymous'] = isAnonymous;
    data['likes'] = likes;
    data['commentDescription'] = commentDescription;
    data['commentStatus'] = commentStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}