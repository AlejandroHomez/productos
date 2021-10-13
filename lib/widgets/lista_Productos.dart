
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/mycolors.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListaProductos extends StatefulWidget {
  
  final List<Product> productos;
  
  const ListaProductos({Key? key, required this.productos}) : super(key: key);

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> with AutomaticKeepAliveClientMixin {

  double valor = 0;

  @override
  Widget build(BuildContext context) {

 final productService = Provider.of<ProductsService>(context);

 final pref = PreferenciasUsurario();

  super.build(context);
    return GridView.builder(

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: widget.productos.length,

        itemBuilder: (BuildContext context, int index) =>
            
         pref.getEmail == 'alejandro.homez.97@gmail.com'
            ?  Dismissible(
                key: UniqueKey(),
                background: EliminarItem(),
                direction: DismissDirection.endToStart,

                child: GestureDetector(

                    onTap: () {

                      productService.selectedProduct =
                      productService.getArticulosCategoriaSelecccionada![index].copy();

                      print(productService.getCategoriaSeleccionada);
                      Navigator.pushNamed(context, 'descripcion');

                    },

                    onDoubleTap: () {

                      print(pref.getEmail);
                      productService.selectedProduct =
                          productService.getArticulosCategoriaSelecccionada![index].copy();
                      Navigator.pushNamed(context, 'create');

                    },
                    child: CardProduct(
                      product: widget.productos[index], index: index
                    )),


                onDismissed: (DismissDirection direction) {
                  productService.selectedProduct =
                      productService.getArticulosCategoriaSelecccionada![index];

                  print('idProducto: ${productService.getArticulosCategoriaSelecccionada![index].id}');

                  productService.borrarProduct(productService.selectedProduct);
                },
              )
            : GestureDetector(
              onTap: () {

                productService.selectedProduct = productService
                    .getArticulosCategoriaSelecccionada![index]
                    .copy();

                Navigator.pushNamed(context, 'descripcion');
              },
              child: CardProduct(product: widget.productos[index], index: index),
            
            )
        
          );
  }

  @override
  bool get wantKeepAlive => true;
}



class EliminarItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
        padding: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.redAccent,
                  Colors.pink,
                ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 12,
            ),
            Icon(
              Icons.delete_rounded,
              size: 30,
              color: Colors.white,
            ),
            SizedBox(
              width: 12,
            ),
            Text("Eliminar item",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BerkshireSwash',
                    fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
