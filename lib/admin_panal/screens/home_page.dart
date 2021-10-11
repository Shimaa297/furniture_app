import 'package:flutter/material.dart';
import 'package:untitled/admin_panal/screens/addProduct_screen.dart';
import 'package:untitled/admin_panal/screens/editProduct.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';

class HomeAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            helpButton(
              width: 200,
              text: 'ADD PRODUCT',
              function: () {
                helpNavigateTo(context, AddProduct());
              },
              background: ColorsApp.primaryColor,
              textColor: ColorsApp.defTextColor,
              radius: 30.0,
            ),
            helpButton(
              width: 200,
              text: 'EDIT PRODUCT',
              function: () {
                helpNavigateTo(context, EditProductScreen());
              },
              background: ColorsApp.primaryColor,
              textColor: ColorsApp.defTextColor,
              radius: 30.0,
            ),
            helpButton(
              width: 200,
              text: 'ADD PRODUCT',
              function: () {},
              background: ColorsApp.primaryColor,
              textColor: ColorsApp.defTextColor,
              radius: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
