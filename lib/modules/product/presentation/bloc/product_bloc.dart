import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:product_cart/modules/product/data/models/product_model.dart';
import 'package:product_cart/modules/product/data/repository/iproduct_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductRepository _productRepository;
  int itemCount = 0;
  List<ProductModel> products = [];

  ProductBloc(
    this._productRepository,
  ) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<UpdateQuantity>(_onUpdateQuantity);
  }

  FutureOr<void> _onUpdateQuantity(UpdateQuantity event, emit) {
    _calculateItemCount();
    emit(
      ItemCount(itemCount: itemCount),
    );
    emit(
      FetchedProducts(products: products),
    );
  }

  FutureOr<void> _onFetchProducts(FetchProducts event, emit) async {
    emit(ProductLoading());
    final result = await _productRepository.fetchProducts();
    if (result != null) {
      products = result;
      _calculateItemCount();
      emit(
        FetchedProducts(products: products),
      );
      emit(
        ItemCount(itemCount: itemCount),
      );
    } else {
      ProductError();
    }
  }

  void _calculateItemCount() {
    itemCount = 0;
    for (var element in products) {
      itemCount += element.selectedQuantity;
    }
  }
}
