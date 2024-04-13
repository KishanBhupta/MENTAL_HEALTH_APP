class ApiUrls {

  /*
  * Authentication Api Urls Starts
  * */

  static const String baseUrl = "http://10.0.2.2:8000/api";
  // static const String baseUrl = "http://192.168.4.207:8000/api";
  static String registerPath = "$baseUrl/register";
  static String loginPath = "$baseUrl/login";
  static String getCurrentUserPath = "$baseUrl/getLoggedInUser";
  // post urls

  static String getPostPath = "$baseUrl/posts/getpost";
  static String createPostPath = "$baseUrl/posts/createPost";
  static String addPostLikePath = "$baseUrl/posts/addLike";
  static String removePostLikePath = "$baseUrl/posts/removeLike";
  static String savePostUrl = "$baseUrl/posts/savePost";
  static String removeSavedPostUrl = "$baseUrl/posts/unsavePost";
  static String getPostCommentsPath = "$baseUrl/posts/comments/getcomment";
  static String reportPostPath = "$baseUrl/reports/post";
  static String deleteUserPostPath = "$baseUrl/posts/deletePost";

  // comment paths
  static String addCommentLikePath = "$baseUrl/posts/comments/like";
  static String removeCommentLikePath = "$baseUrl/posts/comments/dislike";
  static String reportCommentPath = "$baseUrl/reports/comment";
  static String addCommentPath = "$baseUrl/posts/comments/add";
  static String deleteCommentPath = "$baseUrl/posts/comments/delete";

  static String getMyProfilePostsPath = "$baseUrl/profile/myProfile/posts";
  static String searchProfilesPath = "$baseUrl/users/search";

  static String updateUserProfilePath = "$baseUrl/profile/myProfile/updateMyProfile";

  /*
  * Authentication Api Urls Ends
  * */

}