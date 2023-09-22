part of 'user_cart_bloc.dart';

abstract class UserCartEvent extends Equatable {
  const UserCartEvent();
}

class GetTotalAmountEvent extends UserCartEvent {
  final double userCarttotalAmout;

  const GetTotalAmountEvent({required this.userCarttotalAmout});

  @override
  List<Object> get props => [];
}
