import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/failures/failure.dart';
import '../../../../register/data/models/response_user_model.dart';
import '../../../data/models/login_user_model.dart';
import '../../../data/repos/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo loginRepo;
  LoginCubit(
    this.loginRepo,
  ) : super(LoginInitial());

  void login({required LoginUserModel loginUserModel}) async {
    emit(LoginLoading());
    final result = await loginRepo.login(
      loginUserModel: loginUserModel,
    );
    return result.fold(
      (failure) => emit(LoginFailure(failure)),
      (model) => emit(LoginSuccess(
        model,
      )),
    );
  }
}
