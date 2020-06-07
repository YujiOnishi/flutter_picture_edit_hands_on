import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Picture'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<Widget> widgets = List();
    
    //メインの画像
    widgets.add(
      SizedBox(
        height: size.width,
        width: size.width,
        child: FittedBox(
          fit: BoxFit.fitHeight,
          child: _image == null
              ? Container()
              : Image.file(
                      _image,
                      color: Color(0xFF00FFFF),
                      colorBlendMode: BlendMode.colorBurn,
                    ),
        ),
      ),
    );

    //Utilityボタン
    widgets.add(
      FloatingActionButton(
        onPressed: (){
          getImage(ImageSource.gallery);
          },
        tooltip: "画像を変更する",
        child: Icon(Icons.attach_file),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: widgets,
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);

    setState(
      () {
        _image = image;
      },
    );
  }
}
