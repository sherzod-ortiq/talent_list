import 'package:flutter/material.dart';

class MiniNetworkPhoto extends StatelessWidget {
  const MiniNetworkPhoto({
    Key? key,
    required double height,
    required double width,
    required String url,
  })  : _height = height,
        _width = width,
        _url = url,
        super(key: key);

  final double _height;
  final double _width;
  final String _url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _url,
      height: _height,
      width: _width,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
