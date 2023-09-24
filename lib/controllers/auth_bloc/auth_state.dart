part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthFormType toggleFormTypeStateUser;

  final RequestState loginStateUser;
  final String loginErrorMessageUser;

  final RequestState registerStateUser;
  final String registerErrorMessageUser;

  const AuthState(
      {this.toggleFormTypeStateUser = AuthFormType.login,
      this.loginStateUser = RequestState.initial,
      this.loginErrorMessageUser = '',
      this.registerStateUser = RequestState.initial,
      this.registerErrorMessageUser = ''});

  AuthState copyWith({
    AuthFormType? toggleFormTypeStateUser,
    RequestState? loginStateUser,
    String? loginErrorMessageUser,
    RequestState? registerStateUser,
    String? registerErrorMessageUser,
  }) {
    return AuthState(
      toggleFormTypeStateUser:
          toggleFormTypeStateUser ?? this.toggleFormTypeStateUser,
      loginStateUser: loginStateUser ?? this.loginStateUser,
      loginErrorMessageUser:
          loginErrorMessageUser ?? this.loginErrorMessageUser,
      registerStateUser: registerStateUser ?? this.registerStateUser,
      registerErrorMessageUser:
          registerErrorMessageUser ?? this.registerErrorMessageUser,
    );
  }

  @override
  List<Object?> get props => [
        toggleFormTypeStateUser,
        loginStateUser,
        loginErrorMessageUser,
        registerStateUser,
        registerErrorMessageUser,
      ];
}
