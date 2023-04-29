import 'package:flutter/material.dart';
import '../model/item.dart';

class Cart with ChangeNotifier {
  List selectedProducts = [];

  add(Item product) {
    selectedProducts.add(product);
    notifyListeners()
  }
}
