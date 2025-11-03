

import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{

}

class LoginRequest extends AuthEvent {

  final String email;
  final String password;


  LoginRequest({ required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}
