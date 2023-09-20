part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  const RegisterEvent({required this.email, required this.password});

  @override
  List<Object> get props => [];
}

class ToggleFormTypeEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LogOutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
