import 'package:flutter/material.dart';

import '../../data/data_sources/shared_pref.dart';

class ProductProvider extends ChangeNotifier {
  List<Map<String, dynamic>> productList = [];

  initProductProvider() async {
    productList = await SharedPref.getProduct();
    notifyListeners();
  }

  void addProduct(Map<String, dynamic> product) {
    productList.add(product);
    notifyListeners();
    SharedPref.setProduct(productList);
  }

  void deleteProduct(int index) {
    productList.removeAt(index);
    notifyListeners();
    SharedPref.setProduct(productList);
  }
}
