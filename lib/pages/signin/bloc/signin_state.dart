import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SigninState extends Equatable {
  const SigninState();
}

class InitialSigninState extends SigninState {
  @override
  List<Object> get props => [];
}

class SigninSuccess extends SigninState {
  SigninSuccess({this.firebaseUser});

  final FirebaseUser firebaseUser;

  @override
  List<Object> get props => [firebaseUser];
}

class SigninFailed extends SigninState {
  @override
  List<Object> get props => [];
}
