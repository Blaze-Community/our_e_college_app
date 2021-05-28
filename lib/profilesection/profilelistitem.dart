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
    return InkWell(
      onTap: () {
        this.onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: [
            Icon(
              this.icon,
              size: 25,
            ),
            SizedBox(width: 15),
            Text(
              this.text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}
