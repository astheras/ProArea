import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({this.icon, this.onTap});

  final Icon icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.grey,
            ],
            stops: [0.1, 0.8],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(5, 5),
              blurRadius: 5,
            )
          ],
        ),
        child: icon,
      ),
    );
  }
}
