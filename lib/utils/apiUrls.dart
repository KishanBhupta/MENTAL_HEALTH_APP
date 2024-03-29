class ApiUrls {

  /*
  * Authentication Api Urls Starts
  * */

  static const String baseUrl = "http://10.0.2.2:8000/api";

  static String registerPath = "$baseUrl/register";
  static String loginPath = "$baseUrl/login";
  static String getCurrentUserPath = "$baseUrl/getLoggedInUser";

  // post urls
  static String getPostPath = "$baseUrl/posts/getpost";
  static String createPostPath = "$baseUrl/posts/createPost";
  static String addPostLikePath = "$baseUrl/posts/addLike";
  static String removePostLikePath = "$baseUrl/posts/removeLike";
  /*
  * Authentication Api Urls Ends
  * */

}