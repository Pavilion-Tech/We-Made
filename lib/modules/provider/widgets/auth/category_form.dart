import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../models/category_model.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../widgets/default_button.dart';

class ChooseCategory extends StatelessWidget {

  ChooseCategory({
    this.validator,
    required this.controller,
    required this.values,
    required this.data,
    this.categoryId
  });

  TextEditingController controller;

  FormFieldValidator? validator;
  List<Data>? categoryId;



  List data;
  List<String> values;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          height: 64,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              border:Border.all(color: Colors.grey.shade500)
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0),
          child: TextFormField(
            readOnly: true,
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context)=>CategoryDialog(
                    controller: controller,
                    data: data,
                    categoryId: categoryId,
                    values: values,
                  )
              );
            },
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                suffixIcon: Icon(Icons.arrow_drop_down,color: defaultColor,),
                hintText:tr('choose_category'),
                hintStyle: TextStyle(color: Colors.grey.shade400)
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryDialog extends StatelessWidget {
  CategoryDialog({required this.controller,required this.data,required this.values,this.categoryId});
  TextEditingController controller;
  List data;
  List<String> values;
  List<Data>? categoryId;
  List<bool> haveCate = [];



  @override
  Widget build(BuildContext context) {
    for (var element in data){
      if(values.contains(element.id)){
        haveCate.add(true);
      }else{
        haveCate.add(false);
      }
    }
    print(haveCate);
    return  Dialog(
      child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          // height: 300,
          child:  SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                    itemBuilder:(c,i){
                      return  Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(data[i].title??''),
                          const Spacer(),
                          CustommCheckBox(
                            controller: controller,
                            text:data[i].title??'',
                            values:values,
                            value: haveCate[i],
                            id: data[i].id??'',
                          )
                        ],
                      );
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (c,i)=>const SizedBox(height: 20,),
                    itemCount:  data.length
                ),
                const SizedBox(height: 20,),
                DefaultButton(
                    text: tr('done'),
                    onTap: ()=>Navigator.pop(context)
                )
              ],
            ),
          )
      ),
    );
  }
}


class CustommCheckBox extends StatefulWidget {
  CustommCheckBox({
    required this.controller,
    required this.text,
    required this.values,
    required this.id,
    this.value = false
  });
  TextEditingController controller;
  String text;
  String id;
  List<String> values;
  bool value;

  @override
  State<CustommCheckBox> createState() => _CustommCheckBoxState();
}

class _CustommCheckBoxState extends State<CustommCheckBox> {

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: widget.value,
        activeColor: defaultColor,
        onChanged: (val){
          setState(() {
            widget.value = val!;
            if(widget.value){
              if(!widget.controller.text.contains('${widget.text},')) widget.controller.text += '${widget.text},';
              if(!widget.values.contains(widget.id)) widget.values.add(widget.id);
            }else{
              widget.values.remove(widget.id);
              if(widget.values.isEmpty)widget.controller.text = '';
            }
          });
        }
    );
  }
}