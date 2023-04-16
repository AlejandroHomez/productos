import 'package:flutter/material.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/mycolors.dart';
import 'package:provider/provider.dart';

class ClasificacionProducto extends StatefulWidget {

  @override
  State<ClasificacionProducto> createState() => _ClasificacionProductoState();
}

class _ClasificacionProductoState extends State<ClasificacionProducto>  {
  @override
  Widget build(BuildContext context) {


  final productService = Provider.of<ProductsService>(context);

    return Container(
      height: 60,
      padding: EdgeInsets.all(5),
      child:Center(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          // itemExtent: 100,
          children: [
            CardClasificacion(productService.categorias[0]),
            CardClasificacion(productService.categorias[1]),
            CardClasificacion(productService.categorias[2]),

          ],
        ),
      ),
        
      );
  }
}

class CardClasificacion extends StatelessWidget {

  final String item;
  const CardClasificacion( this.item) ;


  

  @override
  Widget build(BuildContext context) {

  final productService = Provider.of<ProductsService>(context);
  final pref = new PreferenciasUsurario();

    var boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: productService.getCategoriaSeleccionada == item 
          ? pref.getColor ?  MyColors.colorRosa.withOpacity(0.5)  : MyColors.colorAzul.withOpacity(0.5) 
          : Colors.black12,
          blurRadius: 10,
          offset: Offset(0, 0)
        )
      ]
      );

  

    return GestureDetector(
      onTap: (){
        
         final productService = Provider.of<ProductsService>(context, listen: false);
         productService.categoriaSeleccionada = item;
         
         print(item);

      },

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          decoration: boxDecoration,
          child: SingleChildScrollView(
            child: Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: productService.getCategoriaSeleccionada == item
                ? pref.getColor ?   MyColors.colorRosa : MyColors.colorAzul 
                : pref.getColor ?   MyColors.colorRosa.withOpacity(0.5)  : MyColors.colorAzul.withOpacity(0.5),

                child: Text(item[0], style: TextStyle(color: Colors.white,  fontFamily: 'MeriendaOne', fontSize: 13)),
              ),
              SizedBox(width: 5),
              Text(item, style: TextStyle(fontSize: 13,fontFamily: 'MeriendaOne', color: Colors.black54),)
            ],
          ),
              ),
      ),
    )
  );
  }
}