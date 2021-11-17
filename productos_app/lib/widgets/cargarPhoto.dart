import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CargarPhoto extends StatefulWidget {

  @override
  _CargarPhotoState createState() => _CargarPhotoState();
}

class _CargarPhotoState extends State<CargarPhoto> {

  File? sampleImage; //Imagen
  String? url;      //url
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: sampleImage == null
      ? Text('Seleccione una imagen')
      : enableUpload(),
    ),

    floatingActionButton: FloatingActionButton(
      onPressed: getImage,
      tooltip: "Agregar Imagen",
      child: Icon(Icons.add_a_photo),

    ),
    );
  }

  Future getImage() async {
    final picker = ImagePicker();

    XFile? tempImage = await picker.pickImage(
      source: ImageSource.gallery);
      setState(() {

        sampleImage = File.fromUri(Uri(path: tempImage!.path));

        print('Imagen: ${sampleImage!.path}');
      });
  }

  Widget enableUpload() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Center(child: Image.file( sampleImage!, height: 300, width:600 )),

          TextButton(
            onPressed: uploadStatusImage, 
            child: Text('Guardar'))
        ],
      ),
    );
  }

  void uploadStatusImage() async {
    if(sampleImage != null ) {
      final Reference postImageRef = 
        FirebaseStorage.instance.ref().child("Imagenes-Babuchas");
      DateTime timeKey = DateTime.now();
      final UploadTask uploadTask = 
      postImageRef.child(timeKey.toString() + ".jpg").putFile(sampleImage!);
      var imageUrl = await (await  uploadTask).ref.getDownloadURL();
      url =imageUrl.toString();
      print('Image Url:${url}'); 
    }
  }
}