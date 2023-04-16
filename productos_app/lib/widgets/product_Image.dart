import 'dart:io';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductImage extends StatefulWidget {

  final Product product;
  final int index;

  const ProductImage(this.product, this.index);

  @override
  _ProductImageState createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> with AutomaticKeepAliveClientMixin {


  File? sampleimage;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    int numero = widget.index;
    
    numero++;
    super.build(context);

    final orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: EdgeInsets.only(bottom: 54),
      child: Container(
        width: size.width* 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                
                ),
              child: widget.product.picture == null

              ? FadeInImage(
                  placeholder: AssetImage('assets/gato_load.gif'),
                  image: AssetImage('assets/img.png'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity)

              : Hero(
                tag: '${widget.product.picture}',
                child: FadeInImage(
                  placeholder: AssetImage('assets/gato_load.gif'), 
                  image: NetworkImage('${widget.product.picture}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  ),
              ),
            ),

            Positioned(right: 0, top: 0, child: ProductPrice(product: widget.product)),

            Positioned(
              left: 0,
              bottom: 0,
              child: ProductNotAvatible(product: widget.product),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}