import 'package:flutter/material.dart';

class PostsSeeMore extends StatelessWidget {
  const PostsSeeMore({
    Key? key,
  }) : super(key: key);

  final double _width = 100;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(4),
          child: Center(
            child: Text(
              'See more ...',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      ),
    );
  }
}
