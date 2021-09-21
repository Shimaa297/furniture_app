
import 'package:flutter/material.dart';

class ProviderApp extends ChangeNotifier {

  int select = 0;
  int selectHome = 0;
  selectCategory(index) {
    select = index;
    notifyListeners();
  }

  selectCategoryHome(index) {
    selectHome = index;
    notifyListeners();
  }

  bool isPassword = true;
  isVisibility(){
    isPassword =! isPassword;
    notifyListeners();
  }
  // addProduct(Items model)
  // {
  //   products.add(model);
  //   notifyListeners();
  }
