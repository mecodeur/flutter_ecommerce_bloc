class ApiPath {
  static String products() => 'products/';
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid, String addToCartId) => 'users/$uid/cart/$addToCartId';
  static String myProductsCart(String uid) => 'users/$uid/cart/';
  static String deliveryMethods() => 'deliveryMethods/';
  static String userShippingAddress(String uid) => 'users/$uid/shippingAddresses/';
  static String newAddress(String uid, String addressId) => 'users/$uid/shippingAddresses/$addressId';
}
