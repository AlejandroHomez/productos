import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/preferencias/preferencias_usuario.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeBody extends StatelessWidget {

  final VoidCallback onTap;
  final Size size;

  HomeBody(this.onTap,this.size);

  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);
  
    return Scaffold(
                appBar: AppBar(  
                  flexibleSpace: AppBarWidget(
                   child:  GestureDetector(

                      onTap: onTap,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(FontAwesomeIcons.exchangeAlt  , color: Colors.black54 ),
                        ),                     
                    //  Image(image: AssetImage('assets/deslizar.gif'), width: 40),
              
                      ),
                                
                  ),
                  toolbarHeight: 108,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                ),
                body: BackGroundHome(
                 
                    child: RefreshIndicator(
                      onRefresh: () async {
                        productService.
                        getProductoCategoria(productService.getCategoriaSeleccionada);
                        print(productService.isLoading);
                      },

                      color: Colors.red,
                      displacement: 30,
                      strokeWidth: 3,
                      
                      child:  Container(
                        width: double.infinity,
                        height:double.infinity,
                          child: productService.isLoading 
                          ? Center(child: CircularProgressIndicator(backgroundColor: Colors.black , color: Colors.white, ))
                          : ListaProductos(productos: productService.getArticulosCategoriaSelecccionada! ) 
                        )
                        
                      ),

                ),
        
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: bottomAdd(context),
            );
        
  }

  
  Widget bottomAdd(BuildContext context){

  final productService = Provider.of<ProductsService>(context);
 final pref = PreferenciasUsurario();

  if (pref.getEmail == 'alejandro.homez.97@gmail.com') {
    
    return FloatingActionButton(
        backgroundColor: Color.fromRGBO(18, 190, 189, 1),
        onPressed: () {

          productService.selectedProduct = new Product(
              disponible: false,
              domicilio: false,
              nombre: '',
              precio: 0.0,
              sexo: 1,
              tipo: 'Elija una opcion',
              tallas: [],
              reacciones: [0, 0, 0, 0],
              color: '0xff000000'
              );

          Navigator.pushNamed(context, 'create');
        },
        child: Icon(Icons.add_box),
      );
    
  }

  return Container();

  }
}