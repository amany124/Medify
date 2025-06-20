import 'package:bloc/bloc.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/authentication/register/data/models/auth_response_model.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/failures/failure.dart';
import '../../../../register/data/models/user_model.dart';
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
      (responseModel) {
        LocalData.setAuthResponseModel(responseModel);
        LocalData.setIsLogin(true);
        emit(LoginSuccess(responseModel.user));
      },
    );
  }
}
