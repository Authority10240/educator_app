import 'package:flutter/material.dart';

class Texty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }}
  
  class MyLogoWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var assetsImage = new AssetImage('assets/logo.png');
    var image = new Image(image: assetsImage, height: 150.0  , width: 150.0, );
    return  new Container(child: image);
  }

  }

