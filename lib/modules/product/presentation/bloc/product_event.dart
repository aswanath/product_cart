part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class UpdateQuantity extends ProductEvent {}
