import 'package:flutter_ecommerce_bloc/models/product.dart';
import 'package:flutter_ecommerce_bloc/views/pages/bottom_navbar.dart';
import 'package:flutter_ecommerce_bloc/views/pages/checkout/add_shipping_address_page.dart';
import 'package:flutter_ecommerce_bloc/views/pages/checkout/checkout_page.dart';
import 'package:flutter_ecommerce_bloc/views/pages/checkout/shipping_addresses_page.dart';
import 'package:flutter_ecommerce_bloc/views/pages/product_details_page.dart';
import 'package:go_router/go_router.dart';

import '../../views/pages/auth_page.dart';
import '../../views/pages/landing_page.dart';

abstract class AppRouter {
  static const kLandingPageRoute = '/';
  static const kLoginPageRoute = '/login';
  static const kBottomNavBarRoute = '/navbar';
  static const kProductDetailsRoute = '/product-details';
  static const kCheckoutRoute = '/checkout';
  static const kShippingAddressesRoute = '/checkout/shipping-addresses';
  static const kAddShippingAddressRoute = '/checkout/add-shipping-address';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: kLandingPageRoute,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: kLoginPageRoute,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: kBottomNavBarRoute,
        builder: (context, state) => const BottomNavBar(),
      ),
      GoRoute(
          path: kProductDetailsRoute,
          builder: (context, state) {
            final Product product =
                state.extra as Product; // -> casting is important
            return ProductDetailsPage(product: product);
          }),
      GoRoute(
        path: kCheckoutRoute,
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        path: kShippingAddressesRoute,
        builder: (context, state) => const ShippingAddressesPage(),
      ),
      GoRoute(
        path: kAddShippingAddressRoute,
        builder: (context, state) => const AddShippingAddressPage(),
      ),
    ],
  );
}
