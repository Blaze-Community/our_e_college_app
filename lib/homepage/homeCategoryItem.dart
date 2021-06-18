import 'package:flutter/material.dart';
import 'package:our_e_college_app/homepage/Theme.dart' as AppTheme;

class HomeCategoryItem extends StatefulWidget {
  final Color primaryColor;
  final IconData primaryIcon;
  final String primaryTitle;
  final Color secondaryColor;
  final IconData secondaryIcon;
  final double secondaryIconHeight;
  final Function onPressed;

  HomeCategoryItem(
      {this.primaryColor,
      this.primaryIcon,
      this.primaryTitle,
      this.secondaryColor,
      this.secondaryIcon,
      this.secondaryIconHeight,
      this.onPressed});

  @override
  _HomeCategoryItemState createState() => _HomeCategoryItemState();
}

class _HomeCategoryItemState extends State<HomeCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: widget.primaryColor.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0.0, 6))
      ], color: widget.primaryColor, borderRadius: BorderRadius.circular(10)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            widget.onPressed();
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          widget.secondaryIcon,
                          size: 45,
                          color: AppTheme.Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            widget.primaryTitle,
                            style: AppTheme.TextTheme.regularText,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(
                      widget.secondaryIcon,
                      size: widget.secondaryIconHeight,
                      color: AppTheme.Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: widget.secondaryColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(40),
                            topLeft: Radius.circular(40))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
