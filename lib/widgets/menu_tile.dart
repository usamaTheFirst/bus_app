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
        width: 150,
        height: 150,
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
              FaIcon(iconSource, size: 75, color: Colors.green),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Book Ticket",
                  style: TextStyle(
                    fontSize: 16,
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
