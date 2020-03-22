import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './bloc.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc({this.firebaseAuth});

  final FirebaseAuth firebaseAuth;

  @override
  SigninState get initialState => InitialSigninState();

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is SigninUser) {
      try {
        final result = await firebaseAuth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        yield SigninSuccess(firebaseUser: result.user);
      } on Exception {
        yield SigninFailed();
      }
    }
  }
}
