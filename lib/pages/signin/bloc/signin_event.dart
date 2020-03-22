import 'package:equatable/equatable.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();
}

class SigninUser extends SigninEvent {
  SigninUser(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
