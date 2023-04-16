import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/services/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:productos_app/ui/InputDecorations.dart';


class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
   create: (_) => FormProductProvider(productsService.selectedProduct),
   child: ProductBodyPage(),
  );      
  
  }

}

class ProductBodyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
  final formProduct = Provider.of<FormProductProvider>(context);
  final productsService = Provider.of<ProductsService>(context);

  var boxDecoration = BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        border: Border.all(color: Colors.black12),

         boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
          )
        ],
        gradient: LinearGradient(
            begin: Alignment(0.0, 1.1),
            end: Alignment.topLeft,
            stops: [
              0.4,
              0.6
            ],
            colors: [
              Colors.white.withOpacity(0.7),
              Colors.white.withOpacity(0.7)
            ])
      );


     return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Stack(children: [
                  // CardCreate(),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 35),
                  width: double.infinity,
                  decoration: boxDecoration,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                    child: Container(
                      height: 300,
                      child: ImageCreate(product: productsService.selectedProduct)
                    ),
                  ),
            ),
                AddImageButton(),
                ]),
                FormCreate(),
                SizedBox(height: 50)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatButtons(context, formProduct),
    );
  }


  Widget floatButtons(BuildContext context, FormProductProvider formProduc) {

    final productsService = Provider.of<ProductsService>(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

      //Volver
            
        FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, 'home'),
          backgroundColor: Color.fromRGBO(18, 190, 189, 1),
          child: Icon(
            Icons.keyboard_return_sharp,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 50),

        //Guardar
        FloatingActionButton(
          onPressed: productsService.isSaving
          ? null
          : () async {
            
            productsService.isSaving = true;
            
            if( !formProduc.isValidFomr()) return;

            final String? imgUrl = await productsService.uploadImage();
            
            if ( imgUrl != null ) formProduc.product.picture = imgUrl;  

            print(formProduc.product.picture);       

            await productsService.saveOrCreateProduct(formProduc.product);

           productsService.getProductoCategoria(
                        productsService.getCategoriaSeleccionada);

            // Navigator.pushReplacementNamed(context, 'home');


          },
          backgroundColor: Color.fromRGBO(18, 190, 189, 1),
          child: productsService.isSaving
          ? CircularProgressIndicator( color: Colors.white)
          : Icon(Icons.save_outlined, color: Colors.white)
        ),
      ],
    );
  }
}

class AddImageButton extends StatefulWidget {

  @override
  _AddImageButtonState createState() => _AddImageButtonState();
}

class _AddImageButtonState extends State<AddImageButton> {

  double _height = 0;
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);

    return Positioned(
        right: 8,
        top: 20,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
        
            FloatingActionButton(
              mini: true,
              onPressed: () {

                final altura = 75.0;

                setState(() {
                  
                  if (_height == 0 ) {
                    _height = altura;
                  }

                });       
              },
              child: Icon(Icons.add_a_photo),
              backgroundColor: Color.fromRGBO(18, 190, 189, 0.8),
            ),

            Padding(
              padding:  EdgeInsets.only(right:2),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutQuart,
                height: _height,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.cyan.shade600 , width: 0.5)
                ),
                child: SingleChildScrollView(
                  child:
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
            
                             setState(() {
                                _height = 0.0;
                  
                              });
                            
                            final picker = new ImagePicker();
                            final XFile? pickedFiles = await picker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 100,
                              );
            
            
                            if(pickedFiles == null) {
                              print('No selecciono nada');
                              return;
                            } 
            
                              productsService.updateSelectedImage(pickedFiles.path);
            
                             
                          },
                          child: Text('Camara')),
                        
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 65,
                          height: 0.5,
                          color: Colors.cyan[600],
                        ),
                        GestureDetector(
                          onTap: () async{
            
                             setState(() {
                                _height = 0.0;
              
                              });
            
                            final picker = new ImagePicker();
                            final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 100
                              );
            
            
                            if(pickedFile == null) {
                              print('No selecciono nada');
                              return;
                            } 
                              print('Tenemos imagen${pickedFile.path}');
            
                              productsService.updateSelectedImage(pickedFile.path);
                            
                          },
                          child: Text('Galeria'))
                      ],
                    ),
                  
                ),
                ),
            ),
          ],
        ));
  }
}

class FormCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final formProduct = Provider.of<FormProductProvider>(context);

    Product product = formProduct.product;

    String tallasInicial = formProduct.product.tallas.toString();
    
    return Container(
      // color: Colors.red,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
        border: Border.all(color: Colors.black12)
      ),
      // height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Form(
        key: formProduct.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

          child: Column(
            children: [

               SwitchListTile.adaptive(
                  value: product.disponible,
                  title: Text( 'Disponible',style: TextStyle(fontFamily: 'MeriendaOne')),
                  onChanged:(value) => formProduct.updateDisponible(value),
                  selectedTileColor: Colors.cyan,
                  activeColor: Colors.greenAccent.shade700,
                  inactiveThumbColor: Colors.red,
                  // tileColor: Colors.red,
                ),


              SizedBox(height: 5),

              SwitchListTile(
                  value: product.domicilio,
                  onChanged: (value) => formProduct.updateDomicilio(value),
                  title: Text(
                    'Domicilio',
                    style: TextStyle(fontFamily: 'MeriendaOne'),
                  ),
                  selectedTileColor: Colors.cyan,
                  activeColor: Colors.greenAccent.shade700,
                  inactiveThumbColor: Colors.red,
              ),
                  

              SizedBox(height: 5),


              //Lista Tipo
              Row(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 18),
                    child: Text('Tipo' , style: TextStyle(fontFamily: 'MeriendaOne', fontSize: 16)),
                  ),
                  Expanded(child: Container()),
                  ListaDesplegable(productTipo: product.tipo,),
                ],
              ),

              RadioListTile<int>(
                title: Text('Hombre/Niño',  style: TextStyle(fontFamily: 'MeriendaOne', color: Colors.black87)),
                value: 1, 
                groupValue: product.sexo, 
                onChanged: (value) => formProduct.updateRadioSexo(value!),
                activeColor:  Colors.cyan[600],
                ),
                // Expanded(child: Container()),
              RadioListTile<int>(
                title: Text('Mujer/Niña',  style: TextStyle(fontFamily: 'MeriendaOne', color: Colors.black87)),
                value: 2, 
                groupValue: product.sexo,  
                onChanged: (value) => formProduct.updateRadioSexo(value!),
                activeColor: Colors.pink[600],
                ),  


              //Tallas

              TextFormField(
                initialValue: '${
                tallasInicial.replaceAll('[', "").replaceAll(']', "").replaceAll(" ", "")}',
                onChanged: (value) {
                  
                  List<String> valor = value.split(',');
                  formProduct.updateTalla(valor);
                  
                  },           

                validator: (value) {
                   if (value == null || value.length < 1) {
                    return 'Las tallas son obligatorias';
                  }
                },
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.decorationInput(
                    hinText: 'Ejemplo: 38,39,40',
                    labelTex: 'Tallas',
                    iconData: Icons.straighten_rounded),
              ),

              SizedBox(height: 5),


              //Input Nombre

              TextFormField(
                initialValue: product.nombre,
                onChanged: (value) => product.nombre = value,
                validator: (value) {
                  if (value == null || value.length < 1 ) {
                    return 'El nombre es obligatorio';
                  }
                },
                autocorrect: true,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.decorationInput(
                    hinText: 'Nombre del producto',
                    labelTex: 'Nombre',
                    iconData: Icons.person),
              
              ),

              SizedBox(height: 5),

              //Input contraseña

              TextFormField(
                initialValue: '\$${product.precio}',
                inputFormatters: [

                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) ==  null ) {
                    product.precio = 0;
                  } else {
                    product.precio = double.parse(value);
                  }
                },
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.decorationInput(
                    hinText: '\$45.900',
                    labelTex: 'Precio',
                    iconData: Icons.price_check),
              ),

              SizedBox(height: 35),
            ],
          )
          
          ),
    );
  }

}