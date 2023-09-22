import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce_bloc/core/utils/RequestState.dart';

part 'user_cart_event.dart';

part 'user_cart_state.dart';

class UserCartBloc extends Bloc<UserCartEvent, UserCartState> {
  UserCartBloc() : super(const UserCartState()) {
    on<GetTotalAmountEvent>((event, emit) {
      emit(state.copyWith(
        userCartState: RequestState.success,
        userCarttotalAmout: event.userCarttotalAmout,
      ));
    });
  }
}
