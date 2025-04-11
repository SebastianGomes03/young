import 'package:flutter/material.dart';
import 'package:young/utils/colors.dart';

class Button extends StatefulWidget {
  final String type; // 'menu' or 'option'
  final String label;
  final String color; // 'primary' or 'secondary'
  final VoidCallback onPressed;

  const Button({
    Key? key,
    required this.type,
    required this.label,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bool isMenu = widget.type == 'menu';
    final double height = isMenu ? 90.0 : 70.0;
    final double width = isMenu ? 600.0 : 200.0;
    final double fontSize = isMenu ? 32.0 : 24.0;

    // Determine the button color based on the 'color' parameter
    final Color buttonColor =
        widget.color == 'primary' ? colorsPrimary : colorsBackground;

    // Adjust color for hover and pressed states
    final Color effectiveColor =
        isPressed
            ? buttonColor.withOpacity(0.8) // Darker when pressed
            : isHovered
            ? colorsBlack // Black when hovered
            : buttonColor;

    final Color textColor =
        isHovered
            ? colorsBackground
            : colorsBlack; // Background color for text when hovered

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: effectiveColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: colorsBlack.withOpacity(0.4),
                offset: const Offset(0, 6),
                blurRadius: 4.0,
              ),
            ],
            border: Border.all(color: colorsBlack, width: 4),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor, // Update text color based on hover state
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
