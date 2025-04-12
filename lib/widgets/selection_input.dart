import 'package:flutter/material.dart';
import '../utils/colors.dart'; // Import colors.dart to access colorsBackground, colorsBlack, and colorsPrimary

class SelectionInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String initialValue; // Add initialValue parameter

  const SelectionInput({
    Key? key,
    required this.onChanged,
    this.initialValue = '', // Default to an empty string
  }) : super(key: key);

  @override
  _SelectionInputState createState() => _SelectionInputState();
  }

class _SelectionInputState extends State<SelectionInput> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue; // Initialize with the provided value
  }


@override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: colorsBackground,
      border: Border.all(color: colorsBlack, width: 4),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: IntrinsicHeight( // Wrap with IntrinsicHeight
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Male option
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 'M';
                });
                widget.onChanged(selectedOption);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedOption == 'M'
                      ? colorsPrimary
                      : colorsBackground,
                ),
                child: Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedOption == 'M'
                          ? colorsBackground
                          : colorsBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Divider
          Container(
            width: 4, // Adjust the width of the divider
            height: double.infinity, // Ensure the divider takes full height
            color: colorsBlack, // Set the color of the divider
          ),
          // Female option
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 'F';
                });
                widget.onChanged(selectedOption);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selectedOption == 'F'
                      ? colorsPrimary
                      : colorsBackground,
                ),
                child: Center(
                  child: Text(
                    'F',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selectedOption == 'F'
                          ? colorsBackground
                          : colorsBlack,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}
