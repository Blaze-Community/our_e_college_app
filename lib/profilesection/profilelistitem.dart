import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileListItems extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function onPressed;

  const ProfileListItems({
    this.icon,
    this.text,
    this.onPressed,
    this.hasNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(
        horizontal: 40,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: InkWell(
          onTap: () {
            this.onPressed();
          },
          child: Container(
              child: Row(
            children: <Widget>[
              Icon(
                this.icon,
                size: 25,
              ),
              SizedBox(width: 15),
              Text(
                this.text,
              ),
              Spacer(),
              if (this.hasNavigation)
                Icon(
                  Icons.arrow_forward,
                  size: 25,
                ),
            ],
          ))),
    );
  }
}
