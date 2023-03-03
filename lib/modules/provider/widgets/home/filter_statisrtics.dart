import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/shared/images/images.dart';
import '../../../../shared/components/components.dart';

class FilterStatistics extends StatefulWidget {
  FilterStatistics({Key? key}) : super(key: key);

  @override
  State<FilterStatistics> createState() => _FilterStatisticsState();
}

class _FilterStatisticsState extends State<FilterStatistics> {
  int? checkNum(TextEditingController controller,int index){
    String num = controller.text.split('/')[index];
    return num.length ==2 ? null: 0;
  }

  String changeFormat(TextEditingController controller){
    return'${controller.text.trim().split('/')[2]}-${checkNum(controller,0)??''}${controller.text.trim().split('/')[0]}-${checkNum(controller,1)??''}${controller.text.trim().split('/')[1]}';
  }

  String? from;

  String? to;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Filter Your Statistics',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: InkWell(
            onTap: (){
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.parse("2020-11-11"),
                lastDate: DateTime.parse("2050-11-29"),
              ).then((value) {
                from = DateFormat(null,'en').add_yMd().format(value!)
                        .toString();
                setState(() {});
              });
            },
            child: Row(
              children: [
                Container(
                  height: 46,width: 46,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Colors.white
                  ),
                  alignment: AlignmentDirectional.center,
                  child: Image.asset(Images.calender,width: 26,),
                ),
                const SizedBox(width: 15,),
                Text(
                  'From',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
                ),
                const Spacer(),
                if(from!=null)
                Text(
                  from!,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            if(from!=null){
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.parse("2020-11-11"),
                lastDate: DateTime.parse("2050-11-29"),
              ).then((value) {
                to = DateFormat(null,'en')
                    .add_yMd().format(value!)
                    .toString();
                setState(() {});
                // String startDate = changeFormat(from!);
                // String lastDate = changeFormat(to!);
                // print(startDate);
                // print(lastDate);
                // ProviderCubit.get(context).getStatistics(
                //     from: startDate,to: lastDate
                // );
              });
            }else{
              showToast(msg: 'Choose From Date First',toastState: true);
            }
          },
          child: Row(
            children: [
              Container(
                height: 46,width: 46,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: Colors.white
                ),
                alignment: AlignmentDirectional.center,
                child: Image.asset(Images.calender,width: 26,),
              ),
              const SizedBox(width: 15,),
              Text(
                'To',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
              ),
              const Spacer(),
              if(to!=null)
              Text(
                to!,
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40,),
      ],
    );
  }
}
