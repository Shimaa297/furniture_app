import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/admin_panal/constants.dart';
import 'package:untitled/admin_panal/model/product.dart';
import 'package:untitled/admin_panal/service/store.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import '../constants.dart';
class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProduct(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return helpLoading();
          }
          if(snapshot.hasData){
            List<Product> productList = [];
            for (var doc in snapshot.data.docs) {
              Map<String, dynamic> data = doc.data();
              productList.add(Product(
                  pName: data[kProductName],
                  pCategory: data[kProductCategory],
                  pDescription: data[kProductDescription],
                  pPrice: data[kProductPrice],
                  pImage: data[kProductImage]));
            }
            return  ListView.builder(
                     itemCount: productList.length,
                     itemBuilder : (context, index)=> Container(
                       height: 300,
                         width: 300,
                         child: helpImage('${productList[index].pImage}', 0.0))
                         // Text(productList[index].pImage)
            );

          }
          return Center(child: Text('Something Error !'));
          // return GridView.count(
          //     crossAxisCount: 2,
          //     children: snapshot.data.docs.map((DocumentSnapshot document) {
          //       return Container(
          //         child: ,
          //       );
          //     }).toList(),
          // );
        },
      ),
    );
  }
  Widget buildProduct(index, Product productList) => Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: ColorsApp.col,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  helpImage('${productList.pImage}', 0.0),
                  Text(
                    productList.pName,
                    style: SubtitleTextStyle,
                  ),
                  Text(
                    productList.pCategory,
                    style: SubtitleTextStyle,
                  ),
                  // Text(
                  //   productList[index].pPrice,
                  //   style: SubtitleTextStyle,
                  // ),
                  // Text(
                  //   productList[index].pDescription,
                  //   textAlign: TextAlign.center,
                  //   style: BodyTextStyle,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
}
