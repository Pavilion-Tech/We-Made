import 'package:flutter/material.dart';
import 'package:wee_made/modules/provider/add_edit_product/add_edit_product_screen.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddEditProductScreen(isEdit: true),
    );
  }
}
