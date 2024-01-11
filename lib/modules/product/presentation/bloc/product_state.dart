part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductError extends ProductState {}

class ItemCount extends ProductState {
  final int itemCount;

  ItemCount({required this.itemCount});
}

class FetchedProducts extends ProductState with EquatableMixin {
  final List<ProductModel> products;

  FetchedProducts({required this.products});

  @override
  List<Object?> get props => [products];
}
