import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';

int idRemove = -1;
class CartScreen extends StatelessWidget {
  Items get products => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, _)=> cItem2(products, 5, context)
      ),
    );
  }
  Widget cItem2(Items products, int idRestaurant, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: helpContainerShadow(
        idRemove == products.id
            ? Container(
            height: 150,
            padding: const EdgeInsets.all(6.0),
            child: Image.asset('assets/remove.gif'))
            : Padding(
          padding:
          EdgeInsets.symmetric(horizontal: helpWidth(context) * .02),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
                width: 100,
                child: Hero(
                  tag:
                  '${products.id}${products.product}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        width: 100,
                        child: helpImage(
                            'https://edge.thesofaandchair.co.uk/23/157517/2.jpg', 20)),
                  ),
                ),
              ),
              SizedBox(
                width: helpWidth(context) * .02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      print(helpWidth(context) * .04);
                    },
                    // child: Text(
                    //   helpEn()
                    //       ? products.product.titleAr
                    //       : products.product.titleEn,
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 1,
                    //   style: TextStyle(
                    //     fontSize: helpWidth(context) * .04,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      // Text(LocaleKeys.Size.tr()),
                      SizedBox(width: helpWidth(context) * .03),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: helpWidth(context) * .03,
                            vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightGreen[100],
                        ),
                        alignment: Alignment.center,
                        // child: Text(
                        //   helpEn()
                        //       ? products.size.sizeNameAr
                        //       : products.size.sizeNameEn,
                        //   textAlign: TextAlign.center,
                        // ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  // Text(products.addons.length == 0
                  //     ? ''
                  //     : LocaleKeys.Addons.tr()),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      ...List.generate(
                        // products.addons.length,
                        5,
                            (index) => Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: ColorsApp.primaryColor,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Column(
                                children: [
                                  // Text(
                                  //   helpEn()
                                  //       ? products
                                  //       .addons[index].addon.titleAr
                                  //       : products
                                  //       .addons[index].addon.titleEn,
                                  //   style:
                                  //     BodyTextStyle
                                  // ),
                                  // products.addons[index].addon.price
                                  //     .price ==
                                  //     0
                                  //     ? SizedBox()
                                  //     : helpCurrencySmall(
                                  //     "${products.addons[index].addon.price.price}",
                                  //     Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      // idRemove = products.id;
                      // setState(() {
                      //   idRemove = products.id;
                      // });
                      // await ApiCart.instance.removeFromCart(
                      //     itemId: products.id, restaurant: idRestaurant);
                      // cartModel.items.removeWhere(
                      //         (element) => element.id == products.id);
                      // calculateTotal();
                      // setState(() {});
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 14,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(height: 2),
                          products.product.discount == 0
                              ? SizedBox()
                              : Text(
                            '${products.product.discount}%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 2),
                          products.product.discount == 0
                              ? SizedBox()
                              : Row(
                            children: [
                              Text("${products.quantity}"),
                              Text(" x "),
                              helpCurrency(
                                  '${(products.price - products.price * products.product.discount / 100.0).toStringAsFixed(2)}',
                                  Colors.red,
                                  14),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              products.product.discount != 0
                                  ? SizedBox()
                                  : Text("${products.quantity}"),
                              products.product.discount != 0
                                  ? SizedBox()
                                  : Text(" x "),
                              helpCurrency(
                                  '${products.price ?? 0}',
                                  products.product.discount == 0
                                      ? Colors.black
                                      : Colors.grey,
                                  15),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: helpWidth(context) * .02,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Items {
  int id;
  int cartId;
  int productId;
  int sizeId;
  int quantity;
  int price;
  String specialRequest;
  Product product;
  Size size;
  //List<Addons> addons;

  Items(
      {this.id,
        this.cartId,
        this.productId,
        this.sizeId,
        this.quantity,
        this.price,
        this.specialRequest,
        this.product,
        this.size,
        //this.addons
      });

  // Items.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   cartId = json['cart_id'];
  //   productId = json['product_id'];
  //   sizeId = json['size_id'];
  //   quantity = json['quantity'];
  //   price = json['price'];
  //   specialRequest = json['special_request'];
  //
  //   product =
  //   json['product'] != null ? new Product.fromJson(json['product']) : null;
  //   size = json['size'] != null ? new Size.fromJson(json['size']) : null;
  //   if (json['addons'] != null) {
  //     // addons = <Addons>[];
  //     // json['addons'].forEach((v) {
  //     //   addons.add(new Addons.fromJson(v)
  //     //   );
  //     // });
  //   }
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['cart_id'] = this.cartId;
  //   data['product_id'] = this.productId;
  //   data['size_id'] = this.sizeId;
  //   data['quantity'] = this.quantity;
  //   data['price'] = this.price;
  //   data['special_request'] = this.specialRequest;
  //
  //   if (this.product != null) {
  //     data['product'] = this.product.toJson();
  //   }
  //   if (this.size != null) {
  //     data['size'] = this.size.toJson();
  //   }
  //   if (this.addons != null) {
  //     data['addons'] = this.addons.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Product {
  int id;
  String titleEn;
  String titleAr;
  String descriptionEn;
  String descriptionAr;
  String slug;
  String lang;
  int authId;
  int status;
  int type;
  int count;
  int discount;
  String createdAt;
  String updatedAt;
 // Preview preview;

  Product(
      {this.id,
        this.titleEn,
        this.titleAr,
        this.descriptionEn,
        this.descriptionAr,
        this.slug,
        this.lang,
        this.authId,
        this.status,
        this.type,
        this.count,
        this.discount,
        this.createdAt,
        this.updatedAt,
      //  this.preview
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleEn = json['title_en'];
    titleAr = json['title_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    slug = json['slug'];
    lang = json['lang'];
    authId = json['auth_id'];
    status = json['status'];
    type = json['type'];
    count = json['count'];
    discount = json['discount'] ?? 0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // preview =
    // json['preview'] != null ? new Preview.fromJson(json['preview']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_en'] = this.titleEn;
    data['title_ar'] = this.titleAr;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['slug'] = this.slug;
    data['lang'] = this.lang;
    data['auth_id'] = this.authId;
    data['status'] = this.status;
    data['type'] = this.type;
    data['count'] = this.count;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.preview != null) {
    //   data['preview'] = this.preview.toJson();
    // }
    return data;
  }
}
