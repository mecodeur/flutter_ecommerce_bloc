import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_bloc/controllers/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_bloc/core/utils/app_router.dart';
import 'package:flutter_ecommerce_bloc/models/delivery_method.dart';
import 'package:go_router/go_router.dart';

import '../../../models/shipping_address.dart';
import '../../widgets/checkout/checkout_order_details.dart';
import '../../widgets/checkout/delivery_method_item.dart';
import '../../widgets/checkout/payment_component.dart';
import '../../widgets/checkout/shipping_address_component.dart';
import '../../widgets/main_button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deliveryMethods = deliveryMethodDummy;
    final database = BlocProvider.of<AuthBloc>(context).database;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping address',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              StreamBuilder<List<ShippingAddress>>(
                  stream: database.getShippingAddressPrincipal(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final List<ShippingAddress>? shippingAdress =
                          snapshot.data;
                      if (shippingAdress == null || shippingAdress.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Text('No Shipping Addresses!'),
                              const SizedBox(height: 6.0),
                              InkWell(
                                onTap: () => GoRouter.of(context)
                                    .push(AppRouter.kAddShippingAddressRoute),
                                child: Text(
                                  'Add new one',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Colors.redAccent,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ShippingAddressComponent(
                        shippingAdress: shippingAdress.first,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Change',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.redAccent,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const PaymentComponent(),
              const SizedBox(height: 24.0),
              Text(
                'Delivery method',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                height: size.height * 0.13,
                child: ListView.builder(
                  itemCount: deliveryMethods.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        DeliveryMethodItem(deliveryMethod: deliveryMethods[i]),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              const CheckoutOrderDetails(),
              const SizedBox(height: 64.0),
              MainButton(
                text: 'Submit Order',
                onTap: () {},
                hasCircularBorder: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
