import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/admin_panal/model/product.dart';
import 'package:untitled/admin_panal/service/store.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/help/image_picker_widget.dart';

class AddProduct extends StatelessWidget {
  @override
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController _description = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _price = TextEditingController();

  final _store = Store();
  File image = ImagePickerApp() as File;
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImagePickerApp(),
                        SizedBox(
                          height: 20,
                        ),
                        helpTextField(
                          controller: _name,
                          labelText: 'Product Name',
                          fillColor: ColorsApp.col,
                          prefixIcon: Icon(
                            Icons.drive_file_rename_outline,
                            color: ColorsApp.primaryColor,
                          ),
                          radius: 50.0,
                          textInputType: TextInputType.name,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'Name is Empty';
                            }
                            return null;
                          },
                          // onSave: (input)=> _email = input,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        helpTextField(
                          controller: _category,
                          labelText: 'Product category',
                          fillColor: ColorsApp.col,
                          prefixIcon: Icon(
                            Icons.category,
                            color: ColorsApp.primaryColor,
                          ),
                          radius: 50.0,
                          textInputType: TextInputType.emailAddress,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'category is Empty';
                            }
                            return null;
                          },
                          // onSave: (input)=> _email = input,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        helpTextField(
                          controller: _description,
                          labelText: 'Product description',
                          fillColor: ColorsApp.col,
                          prefixIcon: Icon(
                            Icons.description,
                            color: ColorsApp.primaryColor,
                          ),
                          radius: 50.0,
                          textInputType: TextInputType.visiblePassword,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'description is Empty';
                            }
                            return null;
                          },
                          // onSave: (input)=> _password = input,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        helpTextField(
                          controller: _price,
                          labelText: 'Product price',
                          fillColor: ColorsApp.col,
                          prefixIcon: Icon(
                            Icons.account_balance_wallet_sharp,
                            color: ColorsApp.primaryColor,
                          ),
                          radius: 50.0,
                          textInputType: TextInputType.number,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'price is Empty';
                            }
                            return null;
                          },
                          // onSave: (input)=> _email = input,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        helpButton(
                          text: 'ADD PRODUCT',
                          function: () {
                            if (_globalKey.currentState.validate()) {
                              _globalKey.currentState.save();
                              _store.addProduct(Product(
                                  pImage: image.path,
                                  pName: _name.text,
                                  pCategory: _category.text,
                                  pDescription: _description.text,
                                  pPrice: _price.text,
                              ));
                            }
                          },
                          // function: submitLogin(context),
                          textColor: ColorsApp.defTextColor,
                          radius: 50.0,
                          elevation: 20.0,
                          fontSize: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource source) {}
}
