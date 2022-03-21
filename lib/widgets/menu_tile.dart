import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key? key,
    required this.title,
    required this.iconSource,
    required this.onTap,
  }) : super(key: key);

  final IconData iconSource;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 120,
        height: 120,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: kBackgroundColor,
          elevation: 8,
          borderOnForeground: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(iconSource, size: 60, color: kTextColor),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
