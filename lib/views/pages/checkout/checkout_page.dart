import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_bloc/models/delivery_method.dart';

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

    //
    final shippingAddress = shippingAdressDummy.last;

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

              ShippingAddressComponent(
                shippingAdress: shippingAddress,
              ),
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
              PaymentComponent(),
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
                    child: DeliveryMethodItem(
                        deliveryMethod: deliveryMethods[i]),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              CheckoutOrderDetails(),
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