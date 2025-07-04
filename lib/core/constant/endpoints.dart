class Endpoints {
  static const String baseUrl =
      'https://medify-git-main-mostafaelshahat194-gmailcoms-projects.vercel.app';
  static const String register = '$baseUrl/api/auth/register';
  static const String login = '$baseUrl/api/auth/login';
  static const String createPost = '$baseUrl/api/doctors/posts';
  static String getPosts(String doctorId) =>
      '$baseUrl/api/doctors/public-profile/$doctorId';
  static String deletePost(String postId) =>
      '$baseUrl/api/doctors/posts/$postId';
  static String updatePost(String postId) =>
      '$baseUrl/api/doctors/posts/$postId';
  static const String sendMessage = '$baseUrl/api/messages';
  static const String getConversation = '$baseUrl/api/messages/conversations';
  static String getMessages(String userId) => '$baseUrl/api/messages/$userId';
}
