import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce_bloc/views/widgets/main_dialog.dart';

import '../../core/utils/RequestState.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/enums.dart';
import '../../models/user_data.dart';
import '../../services/auth.dart';
import '../database_controller.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthBase authBase;
  String? msg;

  // TODO: It's not a best practice thing but it's temporary
  final database = FirestoreDatabase('123');

  AuthBloc(this.authBase) : super(const AuthState()) {
    on<LoginEvent>((event, emit) async {
      try {
        await authBase.loginWithEmailAndPassword(event.email, event.password);
        emit(state.copyWith(
          loginStateUser: RequestState.success,
        ));
        debugPrint('>>> Success Login <<<');
      } catch (e) {
        msg = e.toString();
        emit(state.copyWith(
          loginStateUser: RequestState.failure,
          loginErrorMessageUser: msg,
        ));
        MainDialog(
                context: event.context!,
                title: 'Login failed',
                content:
                    'We were unable to log you in. Please double-check your email and password and try again. If you\'re having trouble, you can reset your password or contact support for assistance.')
            .showAlertDialog();
      }
    });

    on<RegisterEvent>((event, emit) async {
      try {
        final user = await authBase.signUpWithEmailAndPassword(
            event.email, event.password);
        await database.setUserData(UserData(
          uid: user?.uid ?? documentIdFromLocalData(),
          email: event.email,
        ));
        emit(state.copyWith(
          registerStateUser: RequestState.success,
        ));
        debugPrint('>>> Success Register <<<');
      } catch (e) {
        msg = e.toString();
        emit(state.copyWith(
          registerStateUser: RequestState.failure,
          registerErrorMessageUser: msg,
        ));
        MainDialog(
                context: event.context!,
                title: 'Register failed',
                content: 'Register failed, error: $msg')
            .showAlertDialog();
      }
    });

    on<ToggleFormTypeEvent>((event, emit) async {
      emit(state.copyWith(
        toggleFormTypeStateUser:
            state.toggleFormTypeStateUser == AuthFormType.login
                ? AuthFormType.register
                : AuthFormType.login,
      ));
    });

    on<LogOutEvent>((event, emit) async {
      try {
        authBase.logout();
        emit(state.copyWith(
          toggleFormTypeStateUser: AuthFormType.login,
          loginStateUser: RequestState.initial,
          registerStateUser: RequestState.initial,
        ));
      } catch (e) {
        rethrow;
      }
    });
  }
}
