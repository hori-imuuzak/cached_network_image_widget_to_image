import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image_widget_to_image/my_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends HookWidget {
  MyApp({super.key});

  final imageGlobalKey = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final image = useState<Uint8List?>(null);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyNetworkImage(globalKey: imageGlobalKey),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () async {
                    image.value = await convertWidgetToImage(imageGlobalKey);
                  },
                  child: const Text('Widget to image'),
                ),
                const SizedBox(height: 16),
                if (image.value != null) Image.memory(image.value!)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<Uint8List> convertWidgetToImage(GlobalKey widgetGlobalKey) async {
  // RenderObjectを取得
  RenderRepaintBoundary? boundary = widgetGlobalKey.currentContext!
      .findRenderObject()! as RenderRepaintBoundary;

  // RenderObject を dart:ui の Image に変換する
  final image = await boundary.toImage();
  final byteData = await image.toByteData(format: ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
