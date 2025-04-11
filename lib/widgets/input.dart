import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import '../utils/colors.dart'; // Import colors.dart to access colorsBackground and colorsBlack

class Input extends StatelessWidget {
  final String type; // 'dob' or 'name'
  final String label;
  final TextEditingController controller;

  const Input({
    Key? key,
    required this.type,
    required this.label,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorsBackground, // Match the background color of SelectionInput
        border: Border.all(
          color: colorsBlack,
          width: 4,
        ), // Match the border style
        borderRadius: BorderRadius.circular(4.0), // Match the border radius
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
        ), // Add padding inside the input box
        child:
            type == 'dob'
                ? GestureDetector(
                  onTap: () async {
                    // Show styled date picker
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900), // Earliest date allowed
                      lastDate: DateTime.now(), // Latest date allowed
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor:
                                colorsPrimary, // Header background color
                            colorScheme: ColorScheme.light(
                              primary: colorsPrimary, // Selected date color
                              onPrimary: Colors.white, // Text color on header
                              onSurface: colorsBlack, // Text color on calendar
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor:
                                    colorsPrimary, // Button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      // Format the selected date and update the controller
                      controller.text = DateFormat(
                        'dd-MM-yyyy',
                      ).format(pickedDate);
                    }
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: controller,
                      style: TextStyle(color: colorsBlack, fontSize: 16.0),
                      decoration: InputDecoration(
                        labelText: label,
                        labelStyle: TextStyle(color: colorsBlack),
                        border: InputBorder.none, // Remove the default border
                      ),
                    ),
                  ),
                )
                : TextField(
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: colorsBlack, fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(color: colorsBlack),
                    border: InputBorder.none, // Remove the default border
                  ),
                ),
      ),
    );
  }
}
