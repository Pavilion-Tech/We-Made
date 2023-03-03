import 'package:flutter/material.dart';

import '../shared/styles/colors.dart';

class DefaultForm extends StatelessWidget {
  DefaultForm({
    required this.hint,
    this.prefix,
    this.type = TextInputType.text,
    this.validator,
    this.radius = 10,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.controller,
    this.onChanged
});

  String hint;
  Widget? prefix;
  TextInputType type;
  FormFieldValidator? validator;
  double radius;
  int maxLines;
  bool readOnly;
  VoidCallback? onTap;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: defaultColor,
      keyboardType: type,
      controller: controller,
      readOnly: readOnly,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      onTap: onTap,
      decoration: InputDecoration(
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(radius),borderSide: BorderSide(color: defaultColor)),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade500,fontSize: 15),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(14.0),
          child: prefix,
        ),
        isDense: true,
      ),
    );
  }
}
