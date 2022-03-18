import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class Utils {
  static Future capture(GlobalKey key) async {
    if (key == null) return null;

    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    final image = await boundary.toImage(pixelRatio: 3);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData.buffer.asUint8List();

    saveAndSendFile(
      capturedImage: pngBytes,
      fileName: '${Random.secure().nextInt(999999999).toString()}.png',
      // fileName: DateTime.now().toLocal().toString().substring(0, 18) + '.png'
    );
    return pngBytes;
  }

  static Future<String> saveAndSendFile({Uint8List capturedImage,/*String url, */ String fileName}) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    // final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    // await file.writeAsBytes(response.bodyBytes);
    await file.writeAsBytes(capturedImage);
    print('filePath');
    print(filePath);
    var tt = await sendImage(filePath);
    print('tt');
    print(tt);
    return filePath;
  }

  static Future sendImage(/*XFile _image*/String imagePath) async {
    // String imageName = _image.path.split('/').last;
    // List<int> imageBytes = File(filePath.path).readAsBytesSync();

    var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://127.0.0.1:6000/widgets/")
    );

    String imageMimeType = lookupMimeType(imagePath);
    print('imageMimeType');
    print(imageMimeType);

    request.files.add(
        await http.MultipartFile.fromPath(
            'image',
            // imageFilePath,
            // _image.path,
            imagePath,
            filename: '${imagePath}',
            // contentType: new MediaType('image', 'jpeg')
            // contentType: new MediaType('image', 'png')
            contentType: new MediaType(
                imageMimeType.split('/').first,
                imageMimeType.split('/').last
            )
        )
    );
    // request.files.add(
    //   http.MultipartFile.fromBytes(
    //     'image',
    //     _imageFile.readAsBytesSync(),
    //     filename: '$imageName',
    //     // contentType: new MediaType('image', 'jpeg')
    //     contentType: new MediaType('image', 'png')
    //     // contentType: new MediaType('image', 'jpg')
    //   )
    // );

    // http.MultipartFile.fromString(
    //   'image',
    //   _imageFile.path,
    //   filename: '$imageName',
    // );

    request.headers.addAll({
      'Accept': '*/*',
      'Content-Type': 'multipart/form-data',
      'Accept-encoding': 'gzip',
    });
    // request.headers['Content-Type'] = 'multipart/form-data';
    // request.headers['Accept'] = '*/*';
    // request.headers['Accept-encoding'] = 'gzip';
    // request.fields['file'] = name;


    var res = await request.send();
    return res.statusCode;
  }


}
