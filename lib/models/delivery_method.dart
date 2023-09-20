class DeliveryMethod {
  final String id;
  final String name;
  final String days;
  final String imgUrl;
  final double price;

  DeliveryMethod({
    required this.id,
    required this.name,
    required this.days,
    required this.imgUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'days': days,
      'imgUrl': imgUrl,
      'price': price,
    };
  }

  factory DeliveryMethod.fromMap(Map<String, dynamic> map, documentId) {
    return DeliveryMethod(
      id: documentId as String,
      name: map['name'] as String,
      days: map['days'] as String,
      imgUrl: map['imgUrl'] as String,
      price: map['price'].toDouble(),
    );
  }
}

List<DeliveryMethod> deliveryMethodDummy = [
  DeliveryMethod(
    id: '9vL65pivmqIey5LK8nUX',
    name: 'DHL',
    days: '7-10',
    imgUrl: 'https://companieslogo.com/img/orig/DHL.DE-8c515c8f.png?t=1693297848',
    price: 10.50,
  ),

  DeliveryMethod(
    id: 'DDeA9omBWUzb2aUkiJBG',
    name: 'FedEx',
    days: '2-3',
    imgUrl: 'https://w7.pngwing.com/pngs/443/269/png-transparent-logo-brand-fedex-product-desktop-hermes-staff-text-orange-logo.png',
    price: 20.99,
  ),
];
