import 'package:mental_helth_wellness/models/posts/postLikeModal.dart';
import 'package:mental_helth_wellness/models/posts/subSavedPostModal.dart';
import 'package:mental_helth_wellness/models/userModel.dart';

class Post {
  int? id;
  int? usersId;
  String? imageUrl;
  String? postText;
  String? postDescription;
  int? likes;
  int? postStatus;
  int? isAnonymous;
  int? comments;
  String? createdAt;
  String? updataedAt;
  UserModel? postUser;
  List<PostLike> postLikes = [];
  List<SubSavedPost> postSave = [];

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
        this.comments,
        this.updataedAt});

  Post.fromJson(Map<String, dynamic> json) {
    print("JAIODJAOISJOIASDJOAIS : ${json['post_user']}");
    id = json['id'];
    usersId = json['users_id'];
    imageUrl = json['imageUrl'];
    postText = json['postText'];
    postDescription = json['postDescription'];
    likes = json['likes'];
    postStatus = json['postStatus'];
    isAnonymous = json['isAnonymous'];
    createdAt = json['created_at'];
    updataedAt = json['updated_at'];
    comments = json['comments'];
    postUser = UserModel.fromJSON(json['post_user']);
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
    data['updated_at'] = updataedAt;
    data['comments'] = comments;
    return data;
  }
}