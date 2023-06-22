// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:zeazeoshop/models/product_model/product_item_model.dart';

class CartItemModel {
  ProductItemModel? productItemModel;
  int? quantity;

  CartItemModel({
    this.productItemModel,
    this.quantity,
  });

  

  CartItemModel copyWith({
    ProductItemModel? productItemModel,
    int? quantity,
  }) {
    return CartItemModel(
      productItemModel: productItemModel ?? this.productItemModel,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productItemModel': productItemModel?.toMap(),
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productItemModel: map['productItemModel'] != null ? ProductItemModel.fromMap(map['productItemModel'] as Map<String,dynamic>) : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
    );
  }

  @override
  String toString() => 'CartItemModel(productItemModel: $productItemModel, quantity: $quantity)';
}
