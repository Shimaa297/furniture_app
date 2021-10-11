import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/admin_panal/constants.dart';
import 'package:untitled/admin_panal/model/product.dart';

import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../constants.dart';
import '../model/product.dart';
import '../model/product.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductCollection).add({
      kProductName: product.pName,
      kProductCategory: product.pCategory,
      kProductDescription: product.pDescription,
      kProductPrice: product.pPrice,
      kProductImage: product.pImage,
    });
  }

  Future<List<Product>> loadProduct() async {
    List<Product> productList = [];

    await for (var snapshot
        in _firestore.collection(kProductCollection).snapshots()) {
      for (var doc in snapshot.docs) {
        var data = doc.data();
        productList.add(Product(
            pName: data[kProductName],
            pCategory: data[kProductCategory],
            pDescription: data[kProductDescription],
            pPrice: data[kProductPrice],
            pImage: data[kProductImage]));
      }
    }
    // must be outside
    return productList;
  }
}
