import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_notes/models/models.dart';
import 'package:flutter_bloc_notes/repositories/repositories.dart';
import 'package:meta/meta.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  AuthState get initialState => Unauthenticated();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is Login) {
      yield* _mapLoginToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      User currentUser = await _authRepository.getCurrentUser();
      if (currentUser == null) {
        currentUser = await _authRepository.loginAnonymously();
      }

      final isAnonymous = await _authRepository.isAnonymous();
      if (isAnonymous) {
        yield Anonymous(currentUser);
      } else {
        yield Authenticated(currentUser);
      }
    } catch (err) {
      print(err);

      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoginToState() async* {
    try {
      User currentUser = await _authRepository.getCurrentUser();
      yield Authenticated(currentUser);
    } catch (err) {
      print(err);
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLogoutToState() async* {
    try {
      await _authRepository.logout();
      yield* _mapAppStartedToState();
    } catch (err) {
      print(err);
      yield Unauthenticated();
    }
  }
}
