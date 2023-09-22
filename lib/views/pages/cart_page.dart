import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_bloc/controllers/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_bloc/controllers/user_cart_bloc/user_cart_bloc.dart';
import 'package:flutter_ecommerce_bloc/core/utils/RequestState.dart';
import 'package:flutter_ecommerce_bloc/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../models/add_to_cart_model.dart';
import '../widgets/cart_list_item.dart';
import '../widgets/main_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userCartBloc = BlocProvider.of<UserCartBloc>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: StreamBuilder<List<AddToCartModel>>(
              stream: authBloc.database.myProductCart(),
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox.shrink(),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search)),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'My Cart',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                    ),
                    const SizedBox(height: 16.0),
                    StreamBuilder<List<AddToCartModel>>(
                        stream: authBloc.database.myProductCart(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            final List<AddToCartModel>? cartItems =
                                snapshot.data;
                            totalAmount = 0;
                            if (cartItems == null || cartItems.isEmpty) {
                              return Center(
                                child: Text(
                                  'No Data Available!',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cartItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                final cartItem = cartItems[index];
                                totalAmount += cartItem.price;
                                userCartBloc.add(GetTotalAmountEvent(
                                    userCarttotalAmout: totalAmount));
                                return CartListItem(
                                  cartItem: cartItem,
                                );
                              },
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        BlocConsumer<UserCartBloc, UserCartState>(
                          listener: (context, state) {
                            switch (state.userCartTotalAmoutState) {
                              case RequestState.success:
                                totalAmount =
                                    userCartBloc.state.userCarttotalAmout;
                                break;
                              case RequestState.loading:
                                totalAmount = 0;
                                break;
                              case RequestState.initial:
                                totalAmount = 0;
                                break;
                              case RequestState.failure:
                                totalAmount = 0;
                                break;
                            }
                          },
                          builder: (context, state) {
                            return Text(
                              '${userCartBloc.state.userCarttotalAmout} \$',
                              // '${totalAmount.toString().substring(0, 5)}\$',
                              style: Theme.of(context).textTheme.titleLarge,
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    MainButton(
                      text: 'Checkout',
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kCheckoutRoute);
                        //Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.checkoutPageRoute, arguments: database
                      },
                      hasCircularBorder: true,
                    ),
                    const SizedBox(height: 32.0),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
