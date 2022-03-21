import 'package:flutter/material.dart';
import '../exports.dart';

class DetailsTile extends StatelessWidget {
  const DetailsTile({
    Key? key,
    required this.info,
    required this.type,
  }) : super(key: key);
  final String type;
  final String info;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '$type: ',
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        info,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      textColor: kTextColor,
    );
  }
}
