class Endpoints {
  static const String baseUrl = 'https://medify4u-production.up.railway.app';
  static const String register = '$baseUrl/api/auth/register';
  static const String login = '$baseUrl/api/auth/login';
  static const String patientProfile = '$baseUrl/api/patients/profile';
  static const String doctorProfile = '$baseUrl/api/doctors/profile';
  //create appointment
  static const String appointment = '$baseUrl/api/appointments';

  //get doctor appointments /api/doctor
  static const String getDoctorAppointments = '$baseUrl/api/doctor';
  //get patient appointments /api/patient
  static const String getPatientAppointments = '$baseUrl/api/patient';
  //get availability /api/availability
  static const String getAvailability = '$baseUrl/api/doctors/availability';
  //update Availability
  static const String updateAvailability =
      '$baseUrl/api/doctors/availability/update';
  static const String updateDoctorProfile = '$baseUrl/api/doctors/profile';

  // Password reset endpoints
  static const String requestResetPassword =
      '$baseUrl/api/auth/request-reset-password';
  static const String resetPassword = '$baseUrl/api/auth/reset-password';
  //favorite doctors
  static const String patientFavorites = '$baseUrl/api/patients/favorites';
  //search doctors
  static const String searchDoctors = '$baseUrl/api/search/doctors';

  //doctor public profile
  static const String doctorsPublicProfile =
      '$baseUrl/api/doctors/public-profile';

  ///api/reviews/
  static const String doctorReviews = '$baseUrl/api/reviews';
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
