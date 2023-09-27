import '../core/utils/api_path.dart';
import '../models/add_to_cart_model.dart';
import '../models/delivery_method.dart';
import '../models/product.dart';
import '../models/shipping_address.dart';
import '../models/user_data.dart';
import '../services/firestore_services.dart';

abstract class Database {
  Stream<List<Product>> newProductsStream();

  Stream<List<Product>> salesProductsStream();

  Future<void> setUserData(UserData userData);

  Future<void> addToCart(AddToCartModel product);

  Stream<List<AddToCartModel>> myProductCart();

  Stream<List<DeliveryMethod>> deliveryMethodsStream();

  Stream<List<ShippingAddress>> getShippingAddresses();

  Stream<List<ShippingAddress>> getShippingAddressPrincipal();

  Future<void> saveAddress(ShippingAddress address);

  Future<void> deleteItemCart(AddToCartModel addToCartModel);
}

class FirestoreDatabase implements Database {
  final _service = FirestoreServices.instance;

  final String uid;

  FirestoreDatabase(this.uid);

  @override
  Stream<List<Product>> salesProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
        queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
      );

  @override
  Stream<List<Product>> newProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  @override
  Future<void> setUserData(UserData userData) async {
    return await _service.setData(
      path: ApiPath.user(userData.uid),
      data: userData.toMap(),
    );
  }

  @override
  Future<void> addToCart(AddToCartModel product) async {
    return await _service.setData(
      path: ApiPath.addToCart(uid, product.id),
      data: product.toMap(),
    );
  }

  @override
  Stream<List<AddToCartModel>> myProductCart() {
    return _service.collectionsStream(
      path: ApiPath.myProductsCart(uid),
      builder: (data, documentId) => AddToCartModel.fromMap(data!, documentId),
    );
  }

  @override
  Stream<List<DeliveryMethod>> deliveryMethodsStream() {
    return _service.collectionsStream(
        path: ApiPath.deliveryMethods(),
        builder: (data, documentId) =>
            DeliveryMethod.fromMap(data!, documentId));
  }

  @override
  Stream<List<ShippingAddress>> getShippingAddresses() {
    return _service.collectionsStream(
      path: ApiPath.userShippingAddress(uid),
      builder: (data, documentId) => ShippingAddress.fromMap(data!, documentId),
    );
  }

  @override
  Stream<List<ShippingAddress>> getShippingAddressPrincipal() {
    return _service.collectionsStream(
      path: ApiPath.userShippingAddress(uid),
      builder: (data, documentId) => ShippingAddress.fromMap(data!, documentId),
      queryBuilder: (query) => query.where('isDefault', isEqualTo: true),
    );
  }

  @override
  Future<void> saveAddress(ShippingAddress address) {
    return _service.setData(
      path: ApiPath.newAddress(
        uid,
        address.id,
      ),
      data: address.toMap(),
    );
  }

  @override
  Future<void> deleteItemCart(AddToCartModel addToCartModel) {
    return _service.deleteData(
      path: ApiPath.deleteFromCart(
        uid,
        addToCartModel.id,
      ),
    );
  }
}
