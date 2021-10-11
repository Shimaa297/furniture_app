import 'dart:io';

class Product {
  String pName;
  String pDescription;
  String pPrice;
  String pCategory;
  File pImage;

  Product(
      {this.pName,
      this.pCategory,
      this.pDescription,
      this.pImage,
      this.pPrice});
}
