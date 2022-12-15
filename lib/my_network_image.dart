import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyNetworkImage extends StatefulWidget {
  const MyNetworkImage({
    super.key,
    required this.globalKey,
  });

  final GlobalKey globalKey;

  @override
  State createState() => _State();
}

class _State extends State<MyNetworkImage> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.globalKey,
      child: Stack(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CachedNetworkImage(
              imageUrl:
                  'https://imgs.ototoy.jp/imgs/jacket/1439/00000003.1667977171.6042_640.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            'テキストです',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
