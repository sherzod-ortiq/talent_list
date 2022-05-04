import 'package:flutter/material.dart';

class AlbumsSeeMore extends StatelessWidget {
  const AlbumsSeeMore({
    Key? key,
  }) : super(key: key);

  final double _width = 200;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: InkWell(
        // onTap: () => selectMeal(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Center(
            child: Center(
              child: Text(
                'See more ...',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
