import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart/modules/product/data/models/product_model.dart';
import 'package:product_cart/modules/product/presentation/bloc/product_bloc.dart';
import 'package:product_cart/modules/product/presentation/widgets/quantity_modifier.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product Details",
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
                          return Text(
                            "${BlocProvider.of<ProductBloc>(context).itemCount}",
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.network(
            productModel.productSmallImg,
            height: size.height * 0.2,
            width: size.width,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            productModel.productName,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.green,
              ),
              child: Text(
                "${productModel.priceList.first.productWeight} ${productModel.priceList.first.productWeightType}",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text(
                "₹${productModel.priceList.first.productMrp}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              if (productModel.priceList.first.mrpValue.isNotEmpty)
                Text(
                  "₹${productModel.priceList.first.mrpValue}",
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.0,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
          if (productModel.discountFlag == "1")
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                margin: const EdgeInsets.only(top: 8.0),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  color: Colors.red,
                ),
                child: Text(
                  "${productModel.discountValue}% OFF",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 20.0,
          ),
          QuantityModifier(
            quantity: productModel.selectedQuantity,
            onQuantityChanged: (val) {
              productModel.selectedQuantity = val;
              BlocProvider.of<ProductBloc>(context).add(
                UpdateQuantity(),
              );
            },
          ),
          const SizedBox(
            height: 36.0,
          ),
          const Text(
            "Product Description",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            productModel.productDescription,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
