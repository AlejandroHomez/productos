import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class CountLikes extends StatelessWidget {
 final  Product product ;

  const CountLikes(this.product);

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          sumaReacciones(product),
          SizedBox(width: 10),
          _Reaccion(product, 'like',        '${product.reacciones![0]}', Color.fromRGBO(45, 222, 167, 1)),
          _Reaccion(product, 'meEncanta',   '${product.reacciones![1]}', Color.fromRGBO(239, 82, 103, 1)),
          _Reaccion(product, 'enoja',       '${product.reacciones![2]}', Color.fromRGBO(239, 112, 82, 1)),
          _Reaccion(product, 'sorprendido', '${product.reacciones![3]}', Color.fromRGBO(252, 214, 111, 1)),
      
        ],
      ),
    );
  }

  Widget sumaReacciones(Product product) {

    
    int suma1 = product.reacciones![0].toInt();
    int suma2 = product.reacciones![1].toInt();
    int suma3 = product.reacciones![2].toInt();
    int suma4 = product.reacciones![3].toInt();

    int suma = suma1+suma2+suma3+suma4;

    int _numeroAnterior = suma -1;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end:  1.0),
      key: Key(suma.toString()),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
      builder: (context, value, _) {

        return  Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey.shade300
        ),
        
        child: Stack(
          children: [
          if(_numeroAnterior  == 0 )
            Opacity(
              opacity: 1 - value,
              child: Transform.translate(
                offset: Offset(0.0, 10  *  value ),
                child: Text(_numeroAnterior.toString(), 
                style: TextStyle(fontFamily: 'MeriendaOne', color: Colors.cyan[600]),),
              ),
            ),
            
            Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0.0, -10 * (1 - value)),
                child: Text(suma.toString(), 
                style: TextStyle(fontFamily: 'MeriendaOne', color: Colors.cyan[600]),),
              ),
            )
          ],
        )
      );
      } ,
    );
  }
}

class _Reaccion extends StatelessWidget {

  final Product product;
  final String imagen;
  final String variable;
  final Color color;

  const _Reaccion( this.product, this.imagen, this.variable, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 50,
      // color: Colors.red,
      margin: EdgeInsets.only(right: 8),
      child: Row(
        children: [
          Image(image: AssetImage('assets/$imagen.gif'), height: 20,),
          SizedBox(width: 3),
          Text(variable, style: TextStyle(fontFamily: 'MeriendaOne', color: color),),
        ],
        
      ),
    );
  }
}