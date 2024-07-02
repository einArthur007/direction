import 'package:flutter/material.dart';
import 'package:direction/global/global.dart';

class TextFieldCostum extends StatelessWidget {
  const TextFieldCostum({
    super.key,
    required this.controller,
    required this.suffixIcon,
    required this.onChanged,
    required this.hintText,
    required this.labelText,
    required this.textInputType,
  });
  final TextEditingController controller;
  final Icon suffixIcon;
  final Function onChanged;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        controller: controller,
        cursorColor: Theme.of(context).colorScheme.onSurface,
        onChanged: (value) => onChanged(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(borderRadius)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          suffixIcon: suffixIcon,
          suffixIconColor: Theme.of(context).colorScheme.onSurface,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        keyboardType: textInputType,
      ),
    );
  }
}
