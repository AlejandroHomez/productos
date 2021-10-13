import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/widgets/mycolors.dart';
import 'package:productos_app/widgets/widgets.dart';

class CardProduct extends StatelessWidget {
  
  final Product product;
  final int index;

const CardProduct({Key? key,required this.product, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Container(
       width: double.infinity,
       height: size.height,
       child: CardProductIndividual(product: product, index: index),
       // child: Text('hole'),
     );
  }

}

class CardProductIndividual extends StatefulWidget {

  final Product product;
  final int index;

  const CardProductIndividual({Key? key,required this.product, required this.index}) : super(key: key);

  @override
  State<CardProductIndividual> createState() => _CardProductIndividualState();
}

class _CardProductIndividualState extends State<CardProductIndividual> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 15
        )
      ],
      );

    final size = MediaQuery.of(context).size;

   final pref = new PreferenciasUsurario();
    
    super.build(context);
    
    return Container(
      margin: EdgeInsets.only(bottom: 20 , left: 10, right: 10, top: 5 ),
      width: 160,
      height: 160,
      decoration: boxDecoration,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          ProductImage(widget.product, widget.index),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Row(
            children: [
              
              Text("Nombre:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      fontFamily: 'MeriendaOne',
                      color: Colors.black54)),
              Expanded(child: Container()),

              Container(
                width: 85,
                child: Text(widget.product.nombre,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                        fontFamily: 'MeriendaOne')),
              ),
            ],
          ),

             Row(
            children: [
              Text("Tallas:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      fontFamily: 'MeriendaOne', color: Colors.black54)),

              Expanded(child: Container()),

              Container(
                // color: Colors.red,
                width: 85,
                height: 15,
                child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      // padding: Edge,
                      itemCount: widget.product.tallas!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return talla(widget.product.tallas![index],
                        pref.getColor 
                        ? MyColors.colorRosa 
                        : MyColors.colorAzul);
                      },
                    ),
              ),
            ],
          ),
          
          Row(
            children: [
              Text("Etiqueta:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      fontFamily: 'MeriendaOne',
                      color: Colors.black54)),
              Expanded(child: Container()),
              Text( this.widget.product.sexo == 1
              ? 'Hombre/Niño'
              : 'Mujer/Niña',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      fontFamily: 'MeriendaOne')),
            ],
          ),

          SizedBox(height: 2)

              ],
            ),
          )
          // Positioned(
          //   bottom:0,
          //   child: ProductDetails(product: product)
          // ),
          
        ],
      ),
    );
  }

  Widget talla(String talla, Color color) {
    return CircleAvatar(
        radius: 10,
        backgroundColor: color,
        child: Text(
          '${talla}',
          style: TextStyle(color: Colors.white ,fontFamily: 'MeriendaOne', fontSize: 8.5),
          ),
        );
  }

  @override
  bool get wantKeepAlive => true;
}

class ProductDetails extends StatelessWidget {

     final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Row(
            children: [
              Text("Tipo:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne', color: Colors.black54)),
              Expanded(child: Container()),

              Text(product.tipo,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne')),
            ],
          ),
          Row(
            children: [
              Text("Etiqueta:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne',
                      color: Colors.black54)),
              Expanded(child: Container()),
              Text( this.product.sexo == 1
              ? 'Hombre/Niño'
              : 'Mujer/Niña',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne')),
            ],
          ),

            Row(
            children: [
              Text("Nombre:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne',
                      color: Colors.black54)),
              Expanded(child: Container()),

              Container(
                width: 200,
                child: Text(product.nombre,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                        fontFamily: 'MeriendaOne')),
              ),
            ],
          ),
          
          Row(
            children: [
              Text("Domicilio:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne',
                      color: Colors.black54)),

              Expanded(child: Container()),

              Text(this.product.domicilio 
              ? 'Incluye Domicilio'
              : 'No incluye Domicilio',
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne')),
            ],
          ),


          Row(
            children: [
              Text("Precio:",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne',
                      color: Colors.black54)),
                      
              Expanded(child: Container()),

              Text("\$${product.precio}",
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'MeriendaOne')),
            ],
          ),
          

          

          
        ],
      ),
    );
  }
}

class ProductPrice extends StatelessWidget {

   final Product product;

  const ProductPrice({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(

      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), topRight: Radius.circular(20)),

        gradient: LinearGradient(colors: [

        Colors.amber,
        Colors.amberAccent
        ]));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      // width: 80,
      height: 30,
      decoration: boxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("\$${product.precio}",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

class ProductNotAvatible extends StatelessWidget {

  final Product product;

  const ProductNotAvatible({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if( product.disponible ) {
      return Container();
    }

    var boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(220, 69, 54, 1),
          Color.fromRGBO(181, 50, 37, 1),
        ]));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: 120,
      height: 25,
      decoration: boxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("No disponible",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'MeriendaOne',color: Colors.white)),
        ],
      ),
    );
  }
}
