import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_bloc/core/utils/app_router.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

import '../../models/product.dart';

class ListItemHome extends StatelessWidget {
  final Product product;
  final bool isNew;
  final VoidCallback? addToFavorites;
  bool isFavorite;

  ListItemHome({
    super.key,
    required this.product,
    required this.isNew,
    this.addToFavorites,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () => GoRouter.of(context).push(
        AppRouter.kProductDetailsRoute,
        extra: product,
      ),
      child: Stack(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.network(
                    product.imgUrl,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  height: 25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: isNew ? Colors.black : Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          isNew ? 'NEW' : '${product.discountValue}%',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // TODO: Create one component for the favorite button
          Positioned(
            left: size.width * 0.40,
            bottom: size.height * 0.11,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey[300]!,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.0,
                child: InkWell(
                  onTap: addToFavorites,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    size: 20.0,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                      itemSize: 25.0,
                      rating: product.rate?.toDouble() ?? 4.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '(100)',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  product.category,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6.0),
                isNew
                    ? Text(
                        '${product.price}\$',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                            ),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${product.price}\$  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '  ${product.price * (product.discountValue) / 100}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.red,
                                  ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
