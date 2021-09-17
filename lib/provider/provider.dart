
import 'package:flutter/material.dart';

class ProviderApp extends ChangeNotifier {

  int select = 0;

  selectCategory(index) {
    select = index;
    notifyListeners();
  }


  // addProduct(Items model)
  // {
  //   products.add(model);
  //   notifyListeners();
  }
