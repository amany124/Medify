import 'package:bloc/bloc.dart';
import 'package:medify/features/social/data/models/update_post_request_model.dart';
import 'package:medify/features/social/data/repos/social_repo.dart';
import 'package:meta/meta.dart';

import '../../../data/models/update_post_response_model.dart';

part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit(
    {
      required this.socialRepo,
    }
  ) : super(UpdatePostInitial());
 final SocialRepo socialRepo;

    Future<void> updatePost({
    required UpdatePostsRequestModel requestModel,
  }) async {
    emit(UpdatePostLoading());
    final result = await socialRepo.updatePost(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(UpdatePostError(failure.message));
      },
      (response) {
        emit(UpdatePostSuccess(response));
      },
    );
  }
  
}
