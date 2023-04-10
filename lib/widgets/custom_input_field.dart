
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool obscureText,borderEnable;
  final double fontSize;
  final void Function(String text)? onChanged;
  final String? Function(String? text)? validator;
  final Widget? icon;
  const InputField({
    super.key, 
    this.label = '', 
    this.keyboardType = TextInputType.text, 
    this.obscureText = false, 
    this.borderEnable = true,  
    this.fontSize = 15,
    this.onChanged,
    this.validator, 
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          fontSize: fontSize,
        ),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2)
          ),
          prefixIcon: icon,
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          border: borderEnable ? null : InputBorder.none,
          labelStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )
        ),
      ),
    );
  }
}