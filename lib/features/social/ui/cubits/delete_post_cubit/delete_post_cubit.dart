import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/social/data/models/delete_post_request_model.dart';
import 'package:medify/features/social/data/models/delete_post_response_model.dart';
import 'package:medify/features/social/data/repos/social_repo.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit({
    required this.socialRepo,
  }) : super(DeletePostInitial());
  final SocialRepo socialRepo;

  Future<void> deletepost({
    required DeletePostRequestModel requestModel,
  }) async {
    emit(DeletePostLoading());
    final result = await socialRepo.deletePost(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(DeletePostError(failure.message));
      },
      (response) {
        emit(DeletePostSuccess(response));
      },
    );
  }
}
