import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/models/models.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class DescripcionProducto extends StatefulWidget {

  @override
  _DescripcionProductoState createState() => _DescripcionProductoState();
}

class _DescripcionProductoState extends State<DescripcionProducto> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {

  final productsService = Provider.of<ProductsService>(context);

  final Product product = productsService.selectedProduct;

   String tallas = product.tallas.toString();

  String parse = "${product.color}";

  print(parse);
  
    timeDilation = 1.5;
    super.build(context);
    return Scaffold(

    backgroundColor: product.color == null  
    ? MyColors.colorAzul 
    : Color(int.parse(parse)),
    // Color.fromRGBO(18, 180, 189, 1),
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    body:  Body(product: productsService.selectedProduct),
    
    floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    floatingActionButton: Transform.scale(
        scale: 0.8,
      child: Transform.translate(
        offset: Offset(2 , -30),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.share,size: 32, color: product.color == null 
            ? MyColors.colorAzul 
            : Color(int.parse(parse))
            ),
      
          onPressed: () {
    
               Share.share(
                  'Hola! , mira este producto: \n\nNombre: ${product.nombre} \nPrecio: \$${product.precio}\nTallas Disponibles: ${tallas.replaceAll('[', "").replaceAll(']', "")}\n\nImagen: ${product.picture}');
            
            
          }
          ),
      ),
    ),
       );

  }

  @override
  bool get wantKeepAlive => true;
}

class Body extends StatelessWidget {

  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
   String parse = "${product.color}";


    return SingleChildScrollView(
      // physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 70),
             Container(
              //  height: size.height,
               child: Stack(
                 children: [

                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.32),
                    padding: EdgeInsets.only(bottom: 100 , top: 10 , left: 20, right: 20),
                    height: 480,
                    width: double.infinity,
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )
                        ),
                    child:  Opacity(
                      opacity: 0.1,
                      child: Image(image: AssetImage('assets/Logo_imagen.png'))),

                      ),
                  

                    Padding(
                      padding: const EdgeInsets.only( left:8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Center(
                            child: Text(product.nombre, 
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style:TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'MeriendaOne',
                            
                          
                              ),),
                          ),

                          SizedBox(height: 20),
     
                            Row(
                              children: [

                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(text: 'Precio\n', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'MeriendaOne'),
                                  ),
                                      TextSpan(text: '\$${product.precio}' , 
                                     style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'MeriendaOne',
                                    shadows: [
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 2
                                      )
                                    ]
                                    
                                    ), )

                                    ]
                                  )
                                ),
                                
                                SizedBox(width: 20),
                                
                                Expanded(
                                child: Stack(
                                  children: [

                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.25),
                                            blurRadius: 10
                                          )
                                        ]
                                      ),

                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.pushNamed(context, 'image');
                                            },
                                            child: Hero(
                                              tag: '${product.picture}',
                                              child: getImage(product, context)))      
                        
                                        ),
                                      ),
                                    ),

                               AnimatedOpacity(
                                 duration: Duration(milliseconds: 500),
                                 curve: Curves.easeIn,
                                 opacity: 0.1,
                                 child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                           
                                          ),
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, 'image');
                                                },
                                                child: Hero(
                                                  tag: "Imagen",
                                                  child: getImage(product, context)))
                               
                                            ),
                                      ),
                                    ),
                               ),
                                  ],
                                ),
                            )
                              ],
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Tallas', style: TextStyle(fontFamily: 'RacingSansOne',fontSize: 35)),
                                      Expanded(child: Container()),
                                      avatibleProduct(product.disponible)
                                    ],
                                  ),

                                  TweenAnimationBuilder<double>(
                                    duration: Duration(milliseconds: 600) ,
                                    curve: Curves.easeInOutBack,
                                    tween: Tween(begin: 1.0, end: 0.0),
                                    builder: (context, value, child) {
                                      return Transform.translate(
                                        offset: Offset( 200 * value, 0.0),
                                        child: child,
                                        );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50,
                                      // color: Colors.red,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: product.tallas!.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return talla(product.tallas![index] , product);
                                        },
                                      ),
                                    ),
                                  ),
                              
                                  SizedBox(height: 15),
                                  
                                  Text(product.domicilio 
                                    ? 'Incluye Domicilio'
                                    : 'No incluye Domicilio',
                                      style: TextStyle(
                                        color: product.domicilio
                                        ?Colors.green
                                        :Colors.red,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          fontFamily: 'MeriendaOne')
                                  ),

                                  SizedBox(height: 15),

                                 Text(
                                      this.product.sexo == 1
                                          ? 'Categoria:  Hombre/Niño'
                                          : 'Categoria: Mujer/Niña',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 15,
                                          fontFamily: 'MeriendaOne')
                                  ),
                                  SizedBox(height: 15),


                                  Text('Te entregamos este producto en caja, aromatizado y el domicilio en la ciudad de Ibagué es totalmente gratis.',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(color: Colors.black54, letterSpacing: 2),
                                  ),
                                  SizedBox(height: 10),

                                  _Entrega(),

                                  SizedBox(height: 20),

                                  CountLikes(product),

                                  SizedBox(height: 5),

                                  Row(
                                    children: [
                                    
                                     BotonReaccion(),

                                    SizedBox(width: 20),

                                    _BotonComprar(product: product)

                                    ],
                                  )
                                ],
                              ),
                            )
                        ],
                      ),
                    )
                   

                 ],
               )
             ),
                       
        ],
      ),
    );
  }

      
  }

class _Entrega extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network('https://blogger.googleusercontent.com/img/a/AVvXsEjko45X-wP-S4_STiJb9LKfKHHBoHtJZX4rQu2CtbULtMxN_CdN-4C39v-Ca8VfJsq_lBJboENGnQ_Mhi2lfhWCLUku9GT60SWlIVAF3LrndKVC7eb1HaZu4Xb60FhftqmriLvgPtcNV0sJi5q15T1vtZc8RqRm4A3e57_XG06hsBcWgaXuiYvTzRrrRQ=s320'),
          Image.network('https://blogger.googleusercontent.com/img/a/AVvXsEjttK33KYySPk-tfP-PB0gAnr3ghQ1DOIoj-bpw10C74Rtm1ZJTvZ7cHtQDZ_JvN6B74bdf1-VplJo6mGAX1R-c-UQjI7szY27IhzBZjciONNvN2SaHif4-l949gh1dm-XM0x0VAcj-AINoO4uzKXMPyA0QcOF7lec9vNDsMKgWc-TZjiA4EIVFKJxdaQ=s320', scale: 10),
          Image.network('https://blogger.googleusercontent.com/img/a/AVvXsEhVEEcFK7gHTwg3wzd5PziZOecJmyIAVrzz7LhE3_QUQu858OtRa-mcNYYCTEkL-Ok0vOH0_vgoatu8TnWTpsikKK8rfXyDOGIJ7Y5mGhrEQXk8ZhQUZyoyL9vC3V-m3O3DCB7dJZFR8sGqyTeXCqEA_3VWfwaaSfgHrNTttuI1z4W7Rg4LnJQUyzTWEg'),
          Image.network('https://blogger.googleusercontent.com/img/a/AVvXsEjttK33KYySPk-tfP-PB0gAnr3ghQ1DOIoj-bpw10C74Rtm1ZJTvZ7cHtQDZ_JvN6B74bdf1-VplJo6mGAX1R-c-UQjI7szY27IhzBZjciONNvN2SaHif4-l949gh1dm-XM0x0VAcj-AINoO4uzKXMPyA0QcOF7lec9vNDsMKgWc-TZjiA4EIVFKJxdaQ=s320',  scale: 10),
          Image.network('https://blogger.googleusercontent.com/img/a/AVvXsEi8zm_V6RezUzb5wgoy_s-kDKZrqbQPAVAuk25w6kvd4R2EPuZDo-uNQUmSD6qjEU43W5MgOAMHC78g_ccFuoawO-ZfFXBwLaau2MNB7Oyvnt_ghRwJFRdV7Iczpw9yCACuETSkyLc_NDgSNb1nkuHAdag-BNhAzPr-xperNa5LejQ7WCtJjdSkgyTtfw=s320')
        ],
      ),
    );
  }
}

class _BotonComprar extends StatelessWidget {
  final Product product;

  const _BotonComprar({Key? key, required this.product}) : super(key: key);


  void lauchWhatsapp (String numero, String mensaje) async{
    String url = "https://wa.me/$numero?text=$mensaje";
    await canLaunch(url) ? launch(url) : print('No se puedo abrir Whatsapp');
  }

  @override
  Widget build(BuildContext context) {

   String tallas = product.tallas.toString();

    return Expanded(

      child: GestureDetector(
        onTap: () {

        if(product.disponible)
         lauchWhatsapp(
        '+573168885155',
         'Hola, quiero comprar este producto: \n\nNombre: ${product.nombre} \nPrecio: \$${product.precio}\nTallas Disponibles: ${tallas.replaceAll('[', "").replaceAll(']', "")}\n\nImagen: ${product.picture}');

        },

        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0 , end: 0.0),
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOutBack,
          builder: (context, value , child){
            return Transform.translate(
              offset: Offset( 0.0, 200 * value),
              child: child
              );
          },
          child: Container( 
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                  product.disponible ? Colors.red : Colors.grey.shade300,
                  product.disponible ? Colors.orange.shade600 : Colors.grey.shade600
                ]
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Text(product.disponible ? 'Comprar' : 'No disponible', style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'MeriendaOne'), textAlign: TextAlign.center,),
          ),
        ),
      ),
    );
  }
}

  Widget getImage(Product? product, BuildContext context) {


    if (product!.picture == null){
      return FadeInImage(
                    placeholder: AssetImage('assets/gato_load.gif'),
                    image: AssetImage('assets/img.png'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity);
    }
                    
    return FadeInImage(
                  placeholder: AssetImage('assets/gato_load.gif'), 
                  image: NetworkImage('${product.picture}'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  );       
  }

  Widget avatibleProduct(bool valor) {

    if (valor) {

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
          gradient: LinearGradient(colors: [
            Colors.green,
            Colors.green.shade700,
          ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Disponible",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, fontFamily: 'MeriendaOne',color: Colors.white)),
          ],
        ),
      );
  }

   return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(220, 50, 50, 1),
            Color.fromRGBO(190, 50, 50, 1),
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("No disponible",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: 'MeriendaOne',
                  color: Colors.white)),
        ],
      ),
    );


  }

  Widget talla(String talla , Product product) {

   String parse = product.color!;

  
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600) ,
     tween: Tween(begin: 1.0, end: 0.0),
     builder: (context, value, child) {
      return Transform.rotate(
        angle: value * 10,
        // offset: Offset( 100 * value, 0.0),
        child: child,
        ); 
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: CircleAvatar(
              backgroundColor: Color(int.parse(parse)),
              child: Text(
                '${talla}',
                style: TextStyle(color: Colors.white ,fontFamily: 'MeriendaOne'),
                ),
              ),
        ),
    );
  }
