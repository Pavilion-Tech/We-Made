import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/shared/components/components.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/shared/styles/colors.dart';
import 'package:wee_made/widgets/default_button.dart';
import 'package:wee_made/widgets/default_form.dart';

import '../../../layouts/provider_layout/provider_cubit/provider_states.dart';
import '../../../models/user/home_model.dart';
import '../../user/widgets/menu/delete_dialog.dart';
import '../menu/pmenu_cubit/pmenu_cubit.dart';
import '../widgets/auth/dropdownfield.dart';

class AddEditProductScreen extends StatefulWidget {
  AddEditProductScreen({this.isEdit = false,this.products});
  bool isEdit;

  Products? products;

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  TextEditingController productNameC = TextEditingController();

  TextEditingController productDescC = TextEditingController();

  TextEditingController quantityC = TextEditingController();

  TextEditingController weightC = TextEditingController();

  TextEditingController priceC = TextEditingController();

  TextEditingController priceAfterDiscountC = TextEditingController();

  TextEditingController categoryC = TextEditingController();

  late CustomDropDownField customDropDownField;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //var cu = WafrCubit.get(context);
    if(widget.products!=null){
      print(widget.products!.images!);
      productNameC.text = widget.products!.title??'';
      productDescC.text = widget.products!.description??'';
      quantityC.text = widget.products!.quantity.toString()??'';
      weightC.text = widget.products!.weight??'';
      priceC.text = widget.products!.priceBeforeDiscount.toString()??'';
      priceAfterDiscountC.text = widget.products!.priceAfterDicount.toString()??'';
      ProviderCubit.get(context).categoryValue = widget.products!.categoryId;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ProviderCubit.get(context);
    return Stack(
      children: [
        Image.asset(
          Images.backGround,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            pDefaultAppBar(
                context: context,
                title: widget.isEdit ? tr('edit_product') : tr('add_product'),
                haveArrow: widget.isEdit,
                action: Image.asset(
                  Images.add,
                  width: 20,
                )),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultForm(
                          hint: tr('product_name'),
                          controller: productNameC,
                          validator: (str) {
                            if (str.isEmpty) return tr('product_name_empty');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: DefaultForm(
                            hint: tr('describe'),
                            maxLines: 3,
                            controller: productDescC,
                            validator: (str) {
                              if (str!.isEmpty) return tr('product_desc_empty');
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: DefaultForm(
                              hint: tr('quantity'),
                              type: TextInputType.number,
                              controller: quantityC,
                              validator: (str) {
                                if (str!.isEmpty) return tr('quantity_empty');
                              },
                            )),
                            const SizedBox(
                              width: 40,
                            ),
                            Expanded(
                                child: DefaultForm(
                                  controller: weightC,
                                  validator: (str) {
                                    if (str!.isEmpty) return tr('weight_empty');
                                  },
                                  hint: tr('weight'),
                                  type: TextInputType.number,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Row(
                            children: [
                              Expanded(child: DefaultForm(
                                controller: priceC,
                                hint: tr('price'),
                                validator: (str) {
                                  if (str!.isEmpty) return tr('price_empty');
                                },
                                type: TextInputType.number,
                              )),
                              const SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                  child:DefaultForm(
                                    controller: priceAfterDiscountC,
                                    hint: tr('price_after_dis'),
                                    validator: (val){
                                      if(priceC.text.isNotEmpty&&val.isNotEmpty){
                                        if(double.parse(priceC.text)<double.parse(val))return tr('price_discount_invalid');
                                      }
                                    },
                                    type: TextInputType.number,
                                  )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: ConditionalBuilder(
                              condition:
                                  ProviderCubit.get(context).providerModel !=
                                      null,
                              fallback: (context) => const SizedBox(
                                    height: 20,
                                  ),
                              builder: (context) {
                                customDropDownField = CustomDropDownField(
                                  hint: tr('category'),
                                  list: cubit.providerModel!.data!.categoryId!,
                                  value: cubit.categoryValue,
                                  isCategory: true,
                                );
                                return customDropDownField;
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            ProviderCubit.get(context).selectImages();
                          },
                          child: Container(
                            height: 43,
                            width: 143,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                border: Border.all(color: Colors.black)),
                            alignment: AlignmentDirectional.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.camera2,
                                  color: defaultColor,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  tr('upload_image'),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: BlocConsumer<ProviderCubit, ProviderStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              var cubit = ProviderCubit.get(context);
                              return ConditionalBuilder(
                                condition: cubit.productImages.isNotEmpty,
                                fallback: (context) => const SizedBox(),
                                builder: (context) => SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: GridView.builder(
                                      itemCount: cubit.productImages.length,
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 1),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: [
                                              Image.file(
                                                File(cubit
                                                    .productImages[index].path),
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    cubit.productImages.remove(
                                                        cubit.productImages[
                                                            index]);
                                                    cubit
                                                        .emit(LoadedImageState());
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  )),
                                            ]);
                                      }),
                                ),
                              );
                            },
                          ),
                        ),
                        BlocConsumer<ProviderCubit, ProviderStates>(
                          listener: (context, state) {
                            if(state  is AddProductSuccessState){
                              ProviderCubit.get(context).productImages=[];
                              productNameC.text ='';
                              productDescC.text ='';
                              priceC.text ='';
                              priceAfterDiscountC.text ='';
                              quantityC.text ='';
                              weightC.text ='';
                              customDropDownField.value =null;
                              ProviderCubit.get(context).justEmit();
                              PMenuCubit.get(context).justEmit();
                            }
                          },
                          builder: (context, state) {
                            var cubit = ProviderCubit.get(context);
                            return ConditionalBuilder(
                              condition: !cubit.productIsLoading,
                              fallback: (context) => const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                              builder: (context) => DefaultButton(
                                  text:!widget.isEdit ? tr('add_product') : tr('edit_product'),
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      if (cubit.productImages.isNotEmpty) {
                                        if (customDropDownField.value != null) {
                                          !widget.isEdit ?
                                          cubit.addProduct(
                                              title: productNameC.text,
                                              desc: productDescC.text,
                                              categoryID: customDropDownField.value,
                                              price: priceC.text,
                                              discount: priceAfterDiscountC.text,
                                              weight: weightC.text,
                                              quantity: quantityC.text
                                          ):cubit.editProduct(
                                              title: productNameC.text,
                                              desc: productDescC.text,
                                              categoryID: customDropDownField.value,
                                              price: priceC.text,
                                              discount: priceAfterDiscountC.text,
                                              weight: weightC.text,
                                              quantity: quantityC.text,
                                              id: widget.products!.id??''
                                          );
                                        } else {
                                          showToast(msg: 'Choose Category First');
                                        }
                                      } else {
                                        showToast(msg: 'Choose Images First');
                                      }
                                    }
                                  }),
                            );
                          },
                        ),
                        if (widget.isEdit)
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => DeleteDialog(() {
                                      PMenuCubit.get(context).deleteProduct(widget.products!.id??'',context,isProductScreen: false);
                                    }));
                              },
                              child: Text(
                                tr('delete_product'),
                                style: TextStyle(color: Colors.red),
                              )),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
