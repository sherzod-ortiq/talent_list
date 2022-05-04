import 'package:flutter/material.dart';

class SubInfoTile extends StatelessWidget {
  const SubInfoTile({Key? key, required String name, required String value})
      : _name = name,
        _value = value,
        super(key: key);

  final String _name;
  final String _value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
        right: 4.0,
        bottom: 4.0,
        left: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              '$_name:',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Text(
            _value,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
