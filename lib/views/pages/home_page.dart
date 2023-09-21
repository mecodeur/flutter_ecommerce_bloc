import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_bloc/controllers/database_controller.dart';
import 'package:flutter_ecommerce_bloc/models/product.dart';

import '../../core/utils/assets.dart';
import '../widgets/header_of_list.dart';
import '../widgets/list_item_home.dart';

class HomePage extends StatelessWidget {
  final FirestoreDatabase database;

  const HomePage({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomePageAsset,
                width: double.infinity,
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.2,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                HeaderOfList(
                  title: 'Sale',
                  subTitle: 'Super Summer Sale!!',
                  onTap: () {},
                ),
                const SizedBox(height: 8.0),
                StreamBuilder<List<Product>>(
                    stream: database.salesProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final List<Product>? salesProducts = snapshot.data;
                        if (salesProducts == null) {
                          return const Center(
                              child: SizedBox(
                                  height: 300,
                                  child: Text('No Data Available')));
                        }
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: salesProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListItemHome(
                                product: salesProducts[index],
                                isNew: false,
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()));
                    }),
                const SizedBox(height: 16.0),
                HeaderOfList(
                  onTap: () {},
                  title: 'New',
                  subTitle: "You've never seen it before!",
                ),
                const SizedBox(height: 8.0),
                StreamBuilder<List<Product>>(
                    stream: database.newProductsStream(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        final List<Product>? newProducts = snapshot.data;
                        if (newProducts == null) {
                          return const Center(
                              child: SizedBox(
                                  height: 300,
                                  child: Text('No Data Available')));
                        }
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: newProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListItemHome(
                                product: newProducts[index],
                                isNew: true,
                              );
                            },
                          ),
                        );
                      }
                      return const SizedBox(
                          height: 300,
                          child: Center(child: CircularProgressIndicator()));
                    }),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
