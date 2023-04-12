import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import 'package:wee_made/layouts/provider_layout/provider_layout.dart';
import 'package:wee_made/modules/provider/add_edit_product/add_edit_product_screen.dart';
import 'package:wee_made/modules/provider/menu/pmenu_cubit/pmenu_cubit.dart';
import '../../../../models/user/home_model.dart';
import '../../../../shared/components/components.dart';

class EditProductScreen extends StatefulWidget {
  EditProductScreen(this.products);

  Products products;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  @override
  void initState() {
    var cu = ProviderCubit.get(context);
    cu.productImages.clear();
    cu.emit(LoadImageState());
    if(widget.products.images!.isNotEmpty){
      for (var image in widget.products.images!) {
        cu.addImageToList(image,widget.products.images!.length);
      }
    }else{
      cu.justEmit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
      listener: (context, state) {
        if(state  is EditProductSuccessState){
          PMenuCubit.get(context).getProducts();
          navigateAndFinish(context, ProviderLayout());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
              condition:state is LoadedImageState,
              fallback: (context)=>Center(child: CircularProgressIndicator()),
              builder: (context)=> AddEditProductScreen(isEdit: true, products: widget.products)
          ),
        );
      },
    );
  }
}
