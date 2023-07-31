import 'package:flutter/material.dart';

import '../../../../layouts/provider_layout/provider_cubit/provider_cubit.dart';
import '../../../../shared/styles/colors.dart';
import '../../../auth/auth_cubit/auth_cubit.dart';
import '../../menu/pmenu_cubit/pmenu_cubit.dart';

class CustomDropDownField extends StatefulWidget {
  CustomDropDownField({
    required this.list,
    required this.value,
    required this.hint,
    this.validator,
    this.isCity = false,
    this.isCategory = false,
    this.isNe = false,
    this.isEdit = false,
    this.title,
    this.id
  });

  bool isCity;
  bool isCategory;
  bool isNe;
  bool isEdit;
  List list;
  dynamic value;
  String hint;
  String? id;
  String? title;
  FormFieldValidator? validator;

  @override
  State<CustomDropDownField> createState() => _CustomDropDownFieldState();
}

class _CustomDropDownFieldState extends State<CustomDropDownField> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              border: Border.all(color: Colors.grey.shade500)
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonFormField(
              items: widget.list.map((e)
              => DropdownMenuItem(
                child: Text(e.name,style: TextStyle(height: 1),),
                value: e.id,
                enabled: widget.id!=null?widget.id!=e.id:true,
              )).toList(),
              hint: Text(widget.title??widget.hint,style:TextStyle(color:widget.title!=null?Colors.black: Colors.grey,height: 1),),
              icon:const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
              validator: widget.validator,
              decoration:const InputDecoration(
                enabledBorder: InputBorder.none,
                border: InputBorder.none
              ),
              value: widget.value,
              onChanged: (str){
                widget.value = str;
                if(widget.isCategory){
                  ProviderCubit.get(context).categoryValue = str as String?;
                }
                if(widget.isNe){
                  if(!widget.isEdit){
                    AuthCubit.get(context).neighborhoodValue = str as String?;
                  }else{
                    PMenuCubit.get(context).neighborhoodValue = str as String?;
                  }
                }
                if(widget.isCity){
                  if(!widget.isEdit){
                    AuthCubit.get(context).cityValue = widget.value;
                    AuthCubit.get(context).getNeighborhood(widget.value);
                  }else{
                    PMenuCubit.get(context).cityValue = widget.value;
                    PMenuCubit.get(context).getNeighborhood(widget.value);
                  }
                }
              }
          ),
        ),
      ],
    );
  }
}
