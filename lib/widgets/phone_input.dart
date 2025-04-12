import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import '../utils/colors.dart'; // Import colors.dart for consistent styling

class PhoneInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String initialValue; // Add initialValue parameter

  const PhoneInput({
    Key? key,
    required this.onChanged,
    this.initialValue = '', // Default to an empty string
  }) : super(key: key);

  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  late String selectedPrefix;
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Split the initial value into prefix and phone number
    if (widget.initialValue.length >= 4) {
      selectedPrefix = widget.initialValue.substring(0, 4);
      phoneController.text = widget.initialValue.substring(4);
    } else {
      selectedPrefix = '0416'; // Default prefix
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorsBackground,
        border: Border.all(color: colorsBlack, width: 4),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          // Dropdown for prefix selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: colorsBackground,
              border: Border(right: BorderSide(color: colorsBlack, width: 4)),
            ),
            child: DropdownButton<String>(
              value: selectedPrefix,
              underline: const SizedBox(), // Remove default underline
              icon: Icon(Icons.arrow_drop_down, color: colorsBlack),
              dropdownColor: colorsBackground,
              items:
                  ['0416', '0414', '0412', '0424', '0426', '0422']
                      .map(
                        (prefix) => DropdownMenuItem<String>(
                          value: prefix,
                          child: Text(
                            prefix,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colorsBlack,
                            ),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPrefix = value!;
                });
                _notifyChange();
              },
            ),
          ),
          // Text input for the remaining 7 digits
          Expanded(
            child: TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter
                    .digitsOnly, // Restrict to numbers only
              ],
              maxLength: 7, // Limit input to 7 digits
              style: TextStyle(color: colorsBlack, fontSize: 16.0),
              decoration: InputDecoration(
                counterText: '', // Hide character counter
                hintText: '1234567',
                hintStyle: TextStyle(color: colorsBlack.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
              onChanged: (value) {
                _notifyChange();
              },
            ),
          ),
        ],
      ),
    );
  }

  void _notifyChange() {
    final phoneNumber = '$selectedPrefix${phoneController.text}';
    widget.onChanged(phoneNumber);
  }
}
