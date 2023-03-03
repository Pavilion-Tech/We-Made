import 'package:flutter/material.dart';

import '../../../../../shared/styles/colors.dart';

class CategoryDialog extends StatelessWidget {
  CategoryDialog({required this.controller,required this.data,required this.values});
  TextEditingController controller;
  List data;
  List<String> values;
  @override
  Widget build(BuildContext context) {
    return  Dialog(
      child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          // height: 300,
          child:  ListView.separated(
              itemBuilder:(c,i){
                return  Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(data[i].name??''),
                    const Spacer(),
                    CustommCheckBox(
                      controller: controller,
                      text:data[i].name??'',
                      values:values,
                      id: data[i].id??'',
                    )
                  ],
                );
              },
              shrinkWrap: true,
              separatorBuilder: (c,i)=>const SizedBox(height: 20,),
              itemCount:  data.length
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
  });
  TextEditingController controller;
  String text;
  String id;
  List<String> values;

  @override
  State<CustommCheckBox> createState() => _CustommCheckBoxState();
}

class _CustommCheckBoxState extends State<CustommCheckBox> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: value,
        activeColor: defaultColor,
        onChanged: (val){
          setState(() {
            value = val!;
            if(value){
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