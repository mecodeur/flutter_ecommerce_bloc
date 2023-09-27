import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../controllers/auth_bloc/auth_bloc.dart';
import '../../controllers/database_controller.dart';
import '../../models/add_to_cart_model.dart';

@immutable
class CartMenu extends StatelessWidget {
  const CartMenu({super.key, required this.builder, required this.cartItem});

  final AddToCartModel cartItem;
  final PullDownMenuButtonBuilder builder;

  @override
  Widget build(BuildContext context) => PullDownButton(
        itemBuilder: (context) => [
          PullDownMenuItem(
            onTap: () {
              deleteCart(BlocProvider.of<AuthBloc>(context).database);
            },
            title: 'Delete',
            isDestructive: true,
            icon: CupertinoIcons.delete,
          ),
        ],
        animationBuilder: null,
        position: PullDownMenuPosition.automatic,
        buttonBuilder: builder,
      );

  Future<void> deleteCart(Database database) async {
    try {
      await database.deleteItemCart(cartItem);
    } catch (e) {
      print('error mmmm= $e');
    }
  }
}
