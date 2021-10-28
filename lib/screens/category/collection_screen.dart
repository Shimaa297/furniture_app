import 'package:flutter/material.dart';
import 'package:untitled/help/constants/constant.dart';
import 'package:untitled/help/constants/header&footer.dart';

class CollectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            headerContent(context, 'Collections'),
            Column(
                 mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  7,
                      (index) => buildListCollection(context)
                //  buildListProduct(context)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
