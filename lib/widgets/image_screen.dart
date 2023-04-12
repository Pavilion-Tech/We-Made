import 'package:flutter/material.dart';
import 'image_net.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen(this.image);
  String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon:const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: ()=>Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: InteractiveViewer(
        child: Center(
          child: ImageNet(image: image,fit: null,),
        ),
      ),
    );
  }
}
