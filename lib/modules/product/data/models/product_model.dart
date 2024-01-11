import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String discountValue;
  final String discountFlag;
  final int productId;
  final String productName;
  final String productSmallImg;
  final String productDescription;
  final List<PriceList> priceList;
  int selectedQuantity;

  ProductModel({
    required this.discountValue,
    required this.discountFlag,
    required this.productId,
    required this.productName,
    required this.productSmallImg,
    required this.productDescription,
    required this.priceList,
    this.selectedQuantity = 0,
  });

  factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        discountValue: json["DiscountValue"],
        discountFlag: json["DiscountFlag"],
        productId: json["product_id"],
        productName: json["product_name"],
        productSmallImg: json["product_small_img"],
        productDescription: json["ProductDescription"],
        priceList: List<PriceList>.from(json["PriceList"].map((x) => PriceList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "DiscountValue": discountValue,
        "DiscountFlag": discountFlag,
        "product_id": productId,
        "product_name": productName,
        "product_small_img": productSmallImg,
        "ProductDescription": productDescription,
        "PriceList": List<dynamic>.from(priceList.map((x) => x.toMap())),
      };

  @override
  List<Object?> get props => [selectedQuantity];
}

class PriceList {
  int prodPriceId;
  int proId;
  String productMrp;
  String mrpValue;
  String productWeight;
  String productWeightType;

  PriceList({
    required this.prodPriceId,
    required this.proId,
    required this.productMrp,
    required this.mrpValue,
    required this.productWeight,
    required this.productWeightType,
  });

  factory PriceList.fromJson(String str) => PriceList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PriceList.fromMap(Map<String, dynamic> json) => PriceList(
        prodPriceId: json["prod_price_id"],
        proId: json["Pro_id"],
        productMrp: json["product_MRP"],
        mrpValue: json["MRPValue"],
        productWeight: json["product_weight"],
        productWeightType: json["product_weight_type"],
      );

  Map<String, dynamic> toMap() => {
        "prod_price_id": prodPriceId,
        "Pro_id": proId,
        "product_MRP": productMrp,
        "MRPValue": mrpValue,
        "product_weight": productWeight,
        "product_weight_type": productWeightType,
      };
}
