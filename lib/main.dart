import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:widget_to_image_example/utils.dart';
import 'package:widget_to_image_example/widget/widget_to_image.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Convert Widget To Image';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        debugShowCheckedModeBanner: false,
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
          // appBar: AppBar(
          //   title: Text(widget.title),
          // ),
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'widgets',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              WidgetToImage(
                builder: (key) {
                  this.key1 = key;

                  return Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: GradientText(
                        'Widget',
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            // end: Alignment.topCenter,
                            colors: [
                              Color(0xff8921aa),
                              // Colors.purple[500],
                              Color(0xffDA44bb),
                              // Colors.pink[600]
                            ]
                        ),
                        // style: GoogleFonts.poppins(
                        style: TextStyle(
                          // color: Colors.blue,
                          // color: Colors.pink[600],
                          // fontWeight: FontWeight.w400,
                          // letterSpacing: -8.5,
                          letterSpacing: -9,
                          // letterSpacing: -1,
                          // fontSize: 50,
                          fontSize: 120,

                          // wordSpacing: 20,
                          // textBaseline: TextBaseline.,
                          // height: 20,
                          fontFamily: 'Panton',
                        ),
                      ),
                    ),
                  );
                },
              ),

              WidgetToImage(
                builder: (key) {
                  this.key2 = key;

                  return AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,

                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.all(0),
                      // margin: EdgeInsets.symmetric(horizontal: 50),
                      // height: 50,
                      // width: 50,
                      // constraints: BoxConstraints(minWidth: 50, maxWidth: 50),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            // Color(0xff8921aa),
                            Colors.purple[500],
                            Color(0xffDA44bb),
                            // Colors.pink[600]
                            // Colors.blue[500],
                            // Colors.blue[500]

                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        // shape: BoxShape.circle,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(45))
                      ),
                      child: Center(
                        child: Text(
                          'Widget',
                          // style: GoogleFonts.poppins(
                          style: TextStyle(
                            // color: Colors.blue,
                            color: Colors.white,
                            // color: Colors.pink[600],
                            // fontWeight: FontWeight.w400,
                            letterSpacing: -8.5,
                            // letterSpacing: -7,
                            fontSize: 120,
                            // wordSpacing: 20,
                            // height: 20,
                            fontFamily: 'Panton',
                          ),
                        ),
                      )
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'images',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              // buildImage(bytes1),
              buildImage(bytes2),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: RaisedButton(
            color: Colors.blue,
            child: Text('Capture', style: TextStyle(color: Colors.white),),
            onPressed: () async {
              // final bytes1 = await Utils.capture(key1);
              final bytes2 = await Utils.capture(key2);

              setState(() {
                // this.bytes1 = bytes1;
                this.bytes2 = bytes2;
              });
            },
          ),
        ),
  );

  Widget buildImage(Uint8List bytes) => bytes != null ? Image.memory(bytes) : Container();
}
