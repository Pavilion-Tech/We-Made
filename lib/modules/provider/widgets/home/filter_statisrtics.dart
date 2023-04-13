import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/widgets/default_button.dart';
import '../../../../layouts/provider_layout/provider_cubit/provider_cubit.dart';
import '../../../../shared/components/components.dart';

class FilterStatistics extends StatefulWidget {
  FilterStatistics({Key? key}) : super(key: key);

  @override
  State<FilterStatistics> createState() => _FilterStatisticsState();
}

class _FilterStatisticsState extends State<FilterStatistics> {
  int? checkNum(String text,int index){
    String num = text.split('/')[index];
    return num.length ==2 ? null: 0;
  }

  String changeFormat(String text){
    return'${text.trim().split('/')[2]}-${checkNum(text,0)??''}${text.trim().split('/')[0]}-${checkNum(text,1)??''}${text.trim().split('/')[1]}';
  }

  String? from;

  String? to;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tr('filter_statistics'),
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
                if(value!=null){
                  from = DateFormat(null,'en').add_yMd().format(value)
                      .toString();
                  setState(() {});
                }
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
                  tr('from'),
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
                ),
                const Spacer(),
                Text(
                  from??'',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        if(from!=null)
        DefaultButton(text: tr('remove_date'), onTap: (){
          from = null;
          to = null;
          setState(() {});
        }),
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
                String startDate = changeFormat(from!);
                String lastDate = changeFormat(to!);
                print(startDate);
                print(lastDate);
                ProviderCubit.get(context).getStatistics(
                    from: startDate,to: lastDate
                );
              });
            }else{
              showToast(msg: tr('choose_date_first'),toastState: true);
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
                tr('to'),
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
              ),
              const Spacer(),
              Text(
                to??'',
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
