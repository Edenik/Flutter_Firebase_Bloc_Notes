part of 'login_bloc.dart';

// abstract class LoginState extends Equatable {
//   const LoginState();

//   @override
//   List<Object> get props => [];
// }

// class LoginInitial extends LoginState {}

@immutable
class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;

  bool get isFormValid => isEmailValid && isPasswordValid;

  const LoginState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.errorMessage,
  });

  factory LoginState.empty() {
    return LoginState(
        isEmailValid: false,
        isPasswordValid: false,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        errorMessage: '');
  }

  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
    );
  }

  factory LoginState.failure({
    @required String errorMessage,
  }) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      errorMessage: errorMessage,
    );
  }

  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      errorMessage: '',
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
    );
  }

  LoginState copyWith({
    bool isPasswordValid,
    bool isEmailValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    String errorMessage,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => '''LoginState {
    isEmailValid: $isEmailValid,
    isPasswordValid: $isPasswordValid,
    isSubmitting: $isSubmitting,
    isSuccess: $isSuccess,
    isFailure: $isFailure,
    errorMessage: $errorMessage,
  }''';
}
