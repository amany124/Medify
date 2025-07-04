// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medify/features/social/data/repos/social_repo.dart';

// import '../../../data/models/create_post_request_model.dart';
// import 'create_post_cubit_state.dart';

// class CreatePostCubit extends Cubit<CreatePostCubitState> {
//   CreatePostCubit({
//     required this.socialRepo,
//   }) : super(CreatePostCubitInitial());

//   final SocialRepo socialRepo;

//   Future<void> createPost({
//     required CreatePostRequestModel requestModel,
//   }) async {
//     emit(CreatePostCubitLoading());
//     final result = await socialRepo.createPost(requestModel: requestModel);
//     result.fold(
//       (failure) {
//         emit(CreatePostCubitError(failure.message));
//       },
//       (response) {
//         print('object');
//         emit(CreatePostCubitSuccess());
//       },
//     );
//   }
// }



// /// add url Endpoints
// /// add models (request and response)
// /// add repo
// /// add cubit
// /// use cubit in the view