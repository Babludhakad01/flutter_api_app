import 'package:bloc/bloc.dart';
import 'package:youtub_flutter_project/data/repositories/auth_repository.dart';
import 'package:youtub_flutter_project/logic/Blocs/Auth/auth_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/Auth/auth_state.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();

  AuthBloc() : super(AuthState()) {
    on<LoginRequest>(_onLoginApi);
  }

  void _onLoginApi(LoginRequest event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = await authRepository.login(event.email, event.password);
      emit(state.copyWith(status: AuthStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, error: e.toString()));
    }
  }
}
