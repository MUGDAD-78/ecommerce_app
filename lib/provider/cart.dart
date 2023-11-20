import 'package:ecommerce_app/Shared/allproducts.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List productscart = [
  ];
double prices = 0;
  add(Product product) {
    productscart.add(product);
    prices += product.price.round();
    notifyListeners();
  }

  delete(Product product){
    productscart.remove(product);
    prices -= product.price.round();
    notifyListeners();
  }
}
