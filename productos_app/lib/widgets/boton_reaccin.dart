import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:productos_app/providers/form_product_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class BotonReaccion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) =>  FormProductProvider(productsService.selectedProduct),
      child: _BotonReaccionBody()
    );
  }
}

class _BotonReaccionBody extends StatefulWidget {


  @override
  __BotonReaccionBodyState createState() => __BotonReaccionBodyState();
}

class __BotonReaccionBodyState extends State<_BotonReaccionBody> {

  int numero = 0;
  int estadoLike = 10;

  @override
  Widget build(BuildContext context) {

   final productsService = Provider.of<ProductsService>(context);
   final formProduct = Provider.of<FormProductProvider>(context);


    return Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        // width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient:
                LinearGradient(colors: [Colors.grey.shade100, Colors.grey.shade200])),
    
        child: Builder(
            builder: (contex) => FlutterReactionButtonCheck(
                  
                  onReactionChanged: (reaction, index, isChecked ) async {

                    print(index);


                    if (estadoLike >= 0 && estadoLike <= 3 ) {
                      formProduct.product.reacciones![estadoLike]--; 
                       estadoLike = index;
                      formProduct.product.reacciones![index]++; 
                    } else {
                      estadoLike = index;
                      formProduct.product.reacciones![index]++; 

                    }

                    numero = index;

                    await productsService.saveOrCreateProduct(formProduct.product);    


                  },
                  // isChecked: true,
                  boxColor: Colors.white.withOpacity(0.9),
                  boxPadding: EdgeInsets.all(5),
                  boxRadius: 10,
                  boxAlignment: AlignmentDirectional.bottomCenter,
                  boxDuration: Duration(milliseconds: 100),
                  highlightColor: Colors.grey.shade200,
                  reactions: <Reaction>[
        
                    Reaction(
                      previewIcon: buildWidgetPreview(
                        'Me gusta',
                        'assets/like.gif',
                      ),
                      icon: _Selected(numero)
                    ),
        
                    Reaction(
                      previewIcon: buildWidgetPreview(
                        'Me encanta',
                        'assets/meEncanta.gif',
                      ),
                      icon: _Selected(numero)
                    ),
                    Reaction(
                      previewIcon: buildWidgetPreview(
                        'Me enoja',
                        'assets/enoja.gif',
                      ),
                      icon: _Selected(numero)
                    ),
                    Reaction(
                      previewIcon: buildWidgetPreview(
                        'Me sorprende',
                        'assets/sorprendido.gif',
                      ),
                      icon: _Selected(numero)
                    ),
                  ],

                  initialReaction: Reaction(
                    icon: _Selected(numero)
                  ),
                  
                )),
      );
  }

  Widget _Selected(int index) {

  String imagen = "";
  String texto  =  "";
  Color color   =  Color.fromRGBO(45, 222, 167, 1);


    if(index < 1 || index > 3) {
      imagen = 'assets/like.gif';
      texto = 'Me gusta';
      color = Color.fromRGBO(45, 222, 167, 1);

    }

    if (index == 1) {
      imagen = 'assets/meEncanta.gif';
      texto = 'Maravilloso!!';
      color = Color.fromRGBO(239, 82, 103, 1);
    }
    
    if (index == 2) {
      imagen = 'assets/enoja.gif';
      texto = 'Se puede mejorar';
      color= Color.fromRGBO(239, 112, 82, 1);
    }
    
   if (index == 3) {
      imagen = 'assets/sorprendido.gif';
      texto = 'OMG!!';
      color = Color.fromRGBO(252, 214, 111, 1);
    }
    
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Image(
              image: AssetImage(imagen),
              height: 30,
            ),
            SizedBox(width: 5),
            Text(
              texto,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
      );
    
  }

  Widget buildWidgetPreview(String title, String imagen) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          Image(
            image: AssetImage(imagen),
            height: 45,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}