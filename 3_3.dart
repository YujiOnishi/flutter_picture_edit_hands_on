import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class BlendData {
  BlendMode mode;
  Color color;

  BlendData(BlendMode mode, Color color) {
    this.mode = mode;
    this.color = color;
  }
}

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
  //BlendDataの作成
  final Map blendDataMap = {
    "Original": BlendData(
      null,
      null,
    ),
    "Strong": BlendData(
      BlendMode.saturation,
      Color(0xFF00FFFF),
    ),
    "Sepia": BlendData(
      BlendMode.modulate,
      Color(0xFFffdead),
    ),
    "Sunset": BlendData(
      BlendMode.colorBurn,
      Color(0xFFf0e68c),
    ),
    "MagicHour": BlendData(
      BlendMode.colorBurn,
      Color(0xFFba55d3),
    ),
    "Ocean": BlendData(
      BlendMode.colorBurn,
      Color(0xFF00FFFF),
    ),
  };

  File _image;
  BlendMode _mode;
  Color _color;

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
                      color: _color,
                      colorBlendMode: _mode,
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
