import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:untitled/help/animate_button.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/help.dart';
import 'package:untitled/help/constants/styles.dart';
import 'package:untitled/screens/cart/cart_screen.dart';

import '../details_product.dart';

class ViewCollection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()
          {
            helpNavigateTo(context, CartScreen());
          }, icon: Icon(Icons.shopping_cart),),
        ],
      ),
      body: Container(
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: .8,
            mainAxisSpacing: 10,
            itemCount: 15,
            itemBuilder: (context, index) {
             // final product = bloc.catalog[index];
              return GestureDetector(
                onTap: ()
                {
                  Navigator.of(context).push(PageRouteBuilder(pageBuilder: (context, animation, _)
                  {
                    return FadeTransition(
                        opacity: animation,
                        child: DetailsScreen(
                        )
                    );
                  }));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 8,
                  shadowColor: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              child: helpImage('https://edge.thesofaandchair.co.uk/23/157517/2.jpg', 0.0)),
                        ),
                        SizedBox(height: 5 ,),
                        Text(
                          '20000 EG',
                              style: SubtitleTextStyle,
                              // helpCurrency('20000', ColorsApp.primaryColor, 20.0),
                        ),
                        SizedBox(height: 5 ,),
                        Text(
                          'product.brand',
                          style: BodyTextStyle
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.3);
            }),
      ),
      floatingActionButton: floatingAnimate(context),
    );
  }
}
