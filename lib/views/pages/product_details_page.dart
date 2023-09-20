import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../widgets/drop_down_menu.dart';
import '../widgets/main_button.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isFavorite = true;
  late String dropdownValue;

  /*Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        size: dropdownValue,
      );
      await database.addToCart(addToCartProduct);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t adding to the cart, please try again!: $e',
      ).showAlertDialog();
    }
  }*/

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          widget.product.title,
          style: Theme.of(context).textTheme.titleLarge,
        )),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.5,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 65.0,
                          child: DropDownMenuComponent(
                            items: const ['S', 'M', 'L', 'XL', 'XXL'],
                            hint: 'Size',
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 65.0,
                        width: 50.0,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.product.title}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),

                      SizedBox(
                        width: 90.0,
                        child: Text(
                          '${widget.product.price} \$ ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(widget.product.category,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.grey)),
                  const SizedBox(height: 16.0),
                  Text(
                    'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                  style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16.0),
                  MainButton(text: 'Add to Cart',
                    onTap: (){
                      //_addToCart(database);
                    },
                    hasCircularBorder: true,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
