import 'package:flutter/material.dart';
import 'package:productos_app/providers/form_product_provider.dart';
import 'package:provider/provider.dart';

class ListaDesplegable extends StatefulWidget {

   final String? productTipo;

  const ListaDesplegable({Key? key, this.productTipo}) : super(key: key);

  @override
  _ListaDesplegableState createState() => _ListaDesplegableState(productTipo);
}

class _ListaDesplegableState extends State<ListaDesplegable> {


    final String? productTipo;

  _ListaDesplegableState(this.productTipo);

  String? opcionSelected;

  @override
  void initState() { 
    super.initState();
    
    if (productTipo == null) {
      opcionSelected == 'Babuchas';
    } else {
      opcionSelected = productTipo!;
    }
    
  }

  List<String> list = ['Babuchas', 'Pantuflas','Garras'];

  @override
  Widget build(BuildContext context) {
    
    final formProduct = Provider.of<FormProductProvider>(context);

    return  DropdownButton<String>(
            iconEnabledColor: Colors.cyan[600],
            style: TextStyle(
              color: Colors.cyan[600],
              fontFamily: 'MeriendaOne'
            ),
            items: list.map((String select) {
              return DropdownMenuItem(
                value: select,
                child: Text(select)
                );
             }).toList(),  
            onChanged: (value) => {
              setState(() {
                opcionSelected = value!;
                formProduct.product.tipo = value;
              })
            },

            hint: Text( opcionSelected! ),
            dropdownColor: Colors.white,
                            
              
    );
  }
}