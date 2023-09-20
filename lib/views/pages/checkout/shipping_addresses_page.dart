import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_bloc/core/utils/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../models/shipping_address.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final shippingAddresses = shippingAdressDummy;

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
          child: Column(
            // Content ShippingAdesses
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).push(AppRouter.kAddShippingAddressRoute),
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
