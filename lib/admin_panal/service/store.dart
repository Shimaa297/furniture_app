import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/admin_panal/constants.dart';
import 'package:untitled/admin_panal/model/product.dart';

import '../constants.dart';
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

  Stream<QuerySnapshot> loadProduct()  {

    return _firestore.collection(kProductCollection).snapshots();
  }
}
