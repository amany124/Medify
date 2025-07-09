import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/booking/data/models/appointment_details.dart';
import 'package:medify/features/booking/data/models/appointment_request_model.dart';
import 'package:medify/features/booking/data/models/scheduled_appointment.dart';

import '../../../../core/constant/endpoints.dart';
import '../../../../core/features/availability_model.dart';
import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';

abstract class AppointmentRepo {
  Future<Either<Failure, AppointmentDetails>> createAppointment({
    required AppointmentRequestModel appointmentRequestModel,
  });
  //getdoctorAppointments
  Future<Either<Failure, List<ScheduledAppointment>>> getDoctorAppointments({
    String type = 'upcoming',
  });
  //getPatientAppointments
  Future<Either<Failure, List<ScheduledAppointment>>> getPatientAppointments({
    String type = 'upcoming',
  });
  //GetAVailablty
  Future<Either<Failure, List<Availability>>> getAvailability();
  //UpdateAvailability
  Future<Either<Failure, String>> updateAvailability({
    required List<Availability> availabilityList,
  });
//GetAVailablty by id
  Future<Either<Failure, List<Availability>>> getAvailabilityById({
    required String id,
  });
  Future<Either<Failure, String>> updatePatientAppointment({
    required String appointmentId,
    required String status,
  });
  //for doc
  Future<Either<Failure, String>> updateDocAppointment({
    required String appointmentId,
    required String status,
  });
}

class AppointmentRepoImpl implements AppointmentRepo {
  final ApiServices apiServices;
  AppointmentRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, AppointmentDetails>> createAppointment({
    required AppointmentRequestModel appointmentRequestModel,
  }) async {
    try {
      final Response response = await apiServices.postRequest(
          endpoint: Endpoints.appointment,
          data: appointmentRequestModel.toJson(),
          token: CacheManager.getData(
            key: Keys.token,
          ));
      print(response.data);
      return Right(AppointmentDetails.fromJson(response.data['appointment']));
    } on DioException catch (e) {
            print(e.toString());

      return Left(Failure(
          e.response?.data['message'] ?? 'An error occurred during login'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ScheduledAppointment>>> getDoctorAppointments(
      {String type = 'upcoming'}) async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: Endpoints.getDoctorAppointments,
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      return Right((response.data[type] as List)
          .map((e) => ScheduledAppointment.fromJson(e))
          .toList());
    } on DioException catch (e) {
      return Left(Failure(
          e.response?.data['message'] ?? 'An error occurred during login'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ScheduledAppointment>>> getPatientAppointments(
      {String type = 'upcoming'}) async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: Endpoints.getPatientAppointments,
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      return Right((response.data[type] as List)
          .map((e) => ScheduledAppointment.fromJson(e))
          .toList());
    } on DioException catch (e) {
      return Left(Failure(
          e.response?.data['message'] ?? 'An error occurred during login'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Availability>>> getAvailability() async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: Endpoints.getAvailability,
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      print(response.data);
      final List<Availability> availabilityList =
          (response.data as List).map((e) => Availability.fromJson(e)).toList();

      return Right(availabilityList);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred while fetching availability'));
    }
  }

  @override
  Future<Either<Failure, String>> updateAvailability(
      {required List<Availability> availabilityList}) async {
    try {
      final Response response = await apiServices.postRequest(
        data: {
          'availability': availabilityList.map((e) => e.toJson()).toList()
        },
        endpoint: Endpoints.getAvailability,
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred while updating availability'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Availability>>> getAvailabilityById({
    required String id,
  }) async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: '${Endpoints.getAvailability}/$id',
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      print(response.data);

      final List<Availability> availabilityList =
          (response.data['availability'] as List)
              .map((e) => Availability.fromJson(e))
              .toList();
      return Right(availabilityList);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred while fetching availability'));
    }
  }

  @override
  Future<Either<Failure, String>> updatePatientAppointment({
    required String appointmentId,
    required String status,
  }) async {
    try {
      final Response response = await apiServices.patchRequest(
        endpoint: '${Endpoints.appointment}/$appointmentId',
        data: {'status': status},
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      print(e.response?.data);
      print(e.message);
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred while updating appointment'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateDocAppointment({
    required String appointmentId,
    required String status,
  }) async {
    try {
      final Response response = await apiServices.patchRequest(
        endpoint: '${Endpoints.appointment}/doctor/$appointmentId/status',
        data: {'status': status},
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      return Right(response.data['message']);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred while updating appointment'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
