import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/social/data/models/get_posts_request_model.dart';
import 'package:medify/features/social/data/models/get_posts_response_model.dart';
import 'package:medify/features/social/data/repos/social_repo.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit({
    required this.socialRepo,
  }) : super(GetPostsInitial());

  final SocialRepo socialRepo;

  Future<void> getAllPosts({
    required GetPostsRequestModel requestModel,
  }) async {
    emit(GetPostsLoading());
    final result = await socialRepo.getAllPosts(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(GetPostsError(failure.message));
      },
      (response) {
        emit(GetPostsSuccess(response));
      },
    );
  }
}
