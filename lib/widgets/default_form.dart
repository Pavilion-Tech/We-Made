import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.onChanged,
    this.textLength,
    this.digitsOnly,
    this.obscureText = false,
    this.suffix
});

  String hint;
  Widget? prefix;
  Widget? suffix;
  bool obscureText;
  TextInputType type;
  FormFieldValidator? validator;
  double radius;
  int? textLength;
  bool? digitsOnly;
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
      obscureText:obscureText,
      onTap: onTap,
      inputFormatters: [
        LengthLimitingTextInputFormatter(textLength),
        if(digitsOnly!=null)FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border:OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(radius),borderSide: BorderSide(color: defaultColor)),
        hintText: hint,
        suffixIcon: suffix,
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
