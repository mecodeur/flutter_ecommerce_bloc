import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_bloc/controllers/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_bloc/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../models/shipping_address.dart';
import '../../widgets/checkout/shipping_address_state_item.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final database = BlocProvider.of<AuthBloc>(context).database;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Addresses',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
          child: StreamBuilder<List<ShippingAddress>>(
              stream: database.getShippingAddresses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  final List<ShippingAddress> shippingAddresses =
                      snapshot.data!;
                  return Column(
                    children: shippingAddresses
                        .map(
                          (shippingAddress) => ShippingAddressStateItem(
                              shippingAddress: shippingAddress),
                        )
                        .toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GoRouter.of(context).push(AppRouter.kAddShippingAddressRoute),
        // Navigator.of(context).pushNamed(
        //           AppRoutes.addShippingAddressRoute,
        //           arguments: AddShippingAddressArgs(database: database),
        //         )
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
