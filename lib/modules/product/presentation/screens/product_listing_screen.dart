import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/modules/product/data/models/product_model.dart';
import 'package:product_cart/modules/product/presentation/bloc/product_bloc.dart';
import 'package:product_cart/modules/product/presentation/screens/product_details_screen.dart';
import 'package:product_cart/modules/product/presentation/widgets/quantity_modifier.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<ProductModel> products = [];

    return BlocProvider<ProductBloc>.value(
      value: BlocProvider.of<ProductBloc>(context)
        ..add(
          FetchProducts(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Products",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.shopping_cart),
                  Positioned(
                    right: -4,
                    top: -4,
                    child: CircleAvatar(
                      radius: 8,
                      child: FittedBox(
                        child: BlocBuilder<ProductBloc, ProductState>(
                          buildWhen: (prev, curr) => curr is ItemCount,
                          builder: (context, state) {
                            int itemCount = 0;
                            if (state is ItemCount) {
                              itemCount = state.itemCount;
                            }
                            return Text(
                              "$itemCount",
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is FetchedProducts) {
              products = state.products;
            }
          },
          builder: (context, state) {
            // print(state);
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductError) {
              return const Center(
                child: Text("Something went wrong."),
              );
            }
            return GridView.builder(
              itemCount: products.length,
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 340,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
              ),
              itemBuilder: (context, index) {
                final item = products[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(
                          productModel: item,
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              item.productSmallImg,
                              height: size.height * 0.15,
                              width: size.width,
                              fit: BoxFit.scaleDown,
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              item.productName,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "₹${item.priceList.first.productMrp}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                if (item.priceList.first.mrpValue.isNotEmpty)
                                  Text(
                                    "₹${item.priceList.first.mrpValue}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      height: 1.0,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              margin: const EdgeInsets.all(8.0),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Colors.green,
                              ),
                              child: Text(
                                "${item.priceList.first.productWeight} ${item.priceList.first.productWeightType}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            QuantityModifier(
                              quantity: item.selectedQuantity,
                              onQuantityChanged: (val) {
                                item.selectedQuantity = val;
                                BlocProvider.of<ProductBloc>(context).add(
                                  UpdateQuantity(),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 12.0,
                            ),
                          ],
                        ),
                      ),
                      if (item.discountFlag == "1")
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: Colors.red,
                          ),
                          child: Text(
                            "${item.discountValue}% OFF",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
