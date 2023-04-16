import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/models/models.dart';
import 'package:productos_app/services/services.dart';

import 'package:photo_view/photo_view.dart';

class ShowImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        // leading: Icon(Icons.keyboard_backspace_outlined),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Hero(
        tag: "Imagen",
        child: getImage(context)),
    );

        
  }

Widget getImage(BuildContext context){

  
  final productsService = Provider.of<ProductsService>(context);

    Product product = productsService.selectedProduct;

    if (product.picture == null)
      return Container(
          child: PhotoView.customChild(
            child: Image(image: AssetImage('assets/img.png'))
            )
        );

    if (product.picture!.startsWith('http'))
      return Container(
        child: PhotoView.customChild(
          child: Image(
            image: NetworkImage('${product.picture}'),
            fit: BoxFit.contain,
          ),
          initialScale: PhotoViewComputedScale.contained,
        ),
      );
    return Container(
      child: PhotoView.customChild(
        child: Image.file(
          File('${product.picture}'),
          fit: BoxFit.contain,
        ),
        initialScale: PhotoViewComputedScale.contained,
      ),
    );

}
}