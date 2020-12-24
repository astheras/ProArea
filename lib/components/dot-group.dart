import 'package:flutter/material.dart';

class DotGroup extends StatefulWidget {
  // counstructor
  DotGroup({
    this.dotCount,
    this.activeDotIndex,
    this.selectedColor,
    this.color,
  });

  final int dotCount;
  final int activeDotIndex;
  final Color selectedColor;
  final Color color;

  @override
  _DotGroupState createState() => _DotGroupState();
}

class _DotGroupState extends State<DotGroup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.dotCount, (index) {
          return dot(index == widget.activeDotIndex);
        }),
      ),
    );
  }

  Widget dot(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: widget.selectedColor.withOpacity(0.72),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? widget.selectedColor : widget.color,
        ),
      ),
    );
  }
}
