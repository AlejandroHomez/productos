import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ImageCreate extends StatelessWidget {

 final Product product;

  const ImageCreate({
    Key? key,
    required this.product
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

  final size = MediaQuery.of(context).size;



    return Container(
        width: double.infinity,
        height: size.height * 0.4,
        //  color: Colors.black,
        child:getImage(product, context)
     );
        //  getImage(product));
  }

  Widget getImage(Product? product,BuildContext context) {

    if (product!.picture == null)
      return Image(
          image: AssetImage('assets/img.png'),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity);

    if (product.picture!.startsWith('http'))
      return FadeInImage(
        placeholder: AssetImage('assets/gato_load.gif'),
        image: NetworkImage('${product.picture}'),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      );

    return Image.file(
      File('${product.picture}'),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );

  }

}
