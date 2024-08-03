import 'package:flutter/material.dart';

class TextFieldGeneral extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final bool obscureText;

  const TextFieldGeneral(
      {required this.labelText,
      this.hintText = '',
      required this.onChanged,
      this.keyboardType = TextInputType.text,
      this.icon = Icons.text_fields,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      // Redondear el contenedor
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          hintText: hintText,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
