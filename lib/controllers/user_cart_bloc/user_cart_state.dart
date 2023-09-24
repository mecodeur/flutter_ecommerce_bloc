part of 'user_cart_bloc.dart';

class UserCartState extends Equatable {
  final RequestState userCartTotalAmoutState;
  final double userCarttotalAmout;

  const UserCartState({
    this.userCartTotalAmoutState = RequestState.loading,
    this.userCarttotalAmout = 0,
  });

  UserCartState copyWith({
    RequestState? userCartState,
    double? userCarttotalAmout,
  }) {
    return UserCartState(
      userCartTotalAmoutState: userCartState ?? userCartTotalAmoutState,
      userCarttotalAmout: userCarttotalAmout ?? this.userCarttotalAmout,
    );
  }

  @override
  List<Object> get props => [
        userCartTotalAmoutState,
        userCarttotalAmout,
      ];
}
