import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerContent(context, 'Category'),
      body: SingleChildScrollView(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children:
          List.generate(
              6,
                  (index) => categoryList(index, context)),
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          childAspectRatio: 20.0 / 10.0,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
