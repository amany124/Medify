class Endpoints {
  static const String baseUrl =
      'https://medify-git-main-mostafaelshahat194-gmailcoms-projects.vercel.app';
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
}
