import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.controller,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    //check this out
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
      child: Container(
        height: 60,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(width: 2, color: Colors.pink[300]!),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(
                  icon,
                  size: 24,
                  color: Colors.pink[300],
                ),
              ),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.pink[300], fontWeight: FontWeight.bold),
            ),
            style:
                TextStyle(color: Colors.pink[300], fontWeight: FontWeight.bold),
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}
