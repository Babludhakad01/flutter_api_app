import 'package:equatable/equatable.dart';
import 'package:youtub_flutter_project/data/models/user_model.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class AuthState extends Equatable{

  final AuthStatus status;
  final UserModel? user;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.error,
});

  AuthState copyWith({
    AuthStatus? status, UserModel? user, String? error,
}){
    return AuthState(
      status: status?? this.status,
      user: user?? this.user,
      error: error?? this.error,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [status, user, error];


}