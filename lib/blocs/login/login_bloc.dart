import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc_notes/blocs/blocs.dart';
import 'package:flutter_bloc_notes/helpers/validators.dart';
import 'package:flutter_bloc_notes/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthBloc _authBloc;
  AuthRepository _authRepository;

  LoginBloc({
    @required AuthBloc authBloc,
    @required AuthRepository authRepository,
  })  : _authBloc = authBloc,
        _authRepository = authRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event);
    } else if (event is LoginPressed) {
      yield* _mapLoginPressedToState(event);
    } else if (event is SignupPressed) {
      yield* _mapSignupPressedToState(event);
    }
  }

  Stream<LoginState> _mapEmailChangedToState(EmailChanged event) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(event.email));
  }

  Stream<LoginState> _mapPasswordChangedToState(PasswordChanged event) async* {
    yield state.update(
        isPasswordValid: Validators.isValidPassword(event.password));
  }

  Stream<LoginState> _mapLoginPressedToState(LoginPressed event) async* {
    yield LoginState.loading();
    try {
      await _authRepository.loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      _authBloc.add(Login());
      yield LoginState.success();
    } on PlatformException catch (err) {
      yield LoginState.failure(errorMessage: err.message);
    }
  }

  Stream<LoginState> _mapSignupPressedToState(SignupPressed event) async* {
    yield LoginState.loading();
    try {
      await _authRepository.signupWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      _authBloc.add(Login());
      yield LoginState.success();
    } on PlatformException catch (err) {
      yield LoginState.failure(errorMessage: err.message);
    }
  }
}
