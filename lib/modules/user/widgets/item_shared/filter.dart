import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/shared/images/images.dart';
import 'package:wee_made/shared/styles/colors.dart';
import 'package:wee_made/widgets/default_button.dart';

class FilterModel{
  String image;
  String title;
  String first;
  String last;
  FilterModel({
    required this.title,
    required this.image,
    required this.first,
    required this.last,
});
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  int productAndStore = 0;
  int price = -1;
  int rate = -1;
  int location = 0;

  @override
  void initState() {
    var cubit = UserCubit.get(context);
    productAndStore = cubit.searchType == 'product'?0:1;
    price = cubit.price;
    rate = cubit.rate;
    // TODO: implement initState
    super.initState();
  }

  List<FilterModel> model = [
    FilterModel(
      title: 'by_price',
      image: Images.coin,
      first: 'high_to_low',
      last: 'low_to_high',
    ),
    FilterModel(
      title: 'rating',
      image: Images.rate,
      first: 'high_to_low',
      last: 'low_to_high',
    ),
    FilterModel(
      title: 'location',
      image: Images.address,
      first: 'nearest_to_farthest',
      last: 'farthest_to_nearest',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Stack(
        children: [
          Image.asset(Images.backGround,fit: BoxFit.cover,width: double.infinity,height: double.infinity,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
            ),
            padding:const EdgeInsetsDirectional.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  productOrStore(image: Images.product,title: 'product',index: 0),
                  const SizedBox(height: 30,),
                  productOrStore(image: Images.store,title: 'store',index: 1),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Image.asset(model[0].image,width: 24,height: 24,),
                      const SizedBox(width: 10,),
                      Text(
                        model[0].title,
                        style:const TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  itemBuilder(
                    model: model[0],
                    title: 'high_to_low',
                    index: -1,
                    isSelected: price == -1
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 40),
                    child: itemBuilder(
                      model: model[0],
                      title: 'low_to_high',
                      index: 1,
                      isSelected: price == 1
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(model[1].image,width: 24,height: 24,),
                      const SizedBox(width: 10,),
                      Text(
                        model[1].title,
                        style:const TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  itemBuilder(
                      model: model[1],
                      title: 'high_to_low',
                      index: -1,
                      isSelected: rate ==-1
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 40),
                    child: itemBuilder(
                        model: model[1],
                        title: 'low_to_high',
                        index: 1,
                        isSelected: rate == 1
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(model[2].image,width: 24,height: 24,),
                      const SizedBox(width: 10,),
                      Text(
                        model[2].title,
                        style:const TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  itemBuilder(
                      model: model[2],
                      title: 'nearest_to_farthest',
                      index: 0,
                      isSelected: location == 0
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,bottom: 40),
                    child: itemBuilder(
                        model: model[2],
                        title: 'farthest_to_nearest',
                        index: 1,
                        isSelected: location == 1
                    ),
                  ),
                  DefaultButton(
                      text: tr('done'),
                      width: 150,
                      onTap: (){
                        cubit.searchType = productAndStore == 0 ?'product':'provider';
                        cubit.rate = rate;
                        cubit.price = price;
                        cubit.getSearch();
                        Navigator.pop(context);
                      }
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productOrStore({required String image,required String title,required int index}){
    return InkWell(
      onTap: (){
        setState(() {
          productAndStore = index;
        });
      },
      child: Row(
        children: [
          Image.asset(image,width: 17,height: 15,color: productAndStore == index?Colors.black:Colors.grey,),
          const SizedBox(width: 8,),
          Text(
            tr(title),
            style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500,color: productAndStore == index?Colors.black:Colors.grey,),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 10,
            backgroundColor: defaultColor,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 9,
              child:productAndStore == index? CircleAvatar(
                radius: 8,
                backgroundColor: defaultColor,
              ):null,
            ),
          )
        ],
      ),
    );
  }

  Widget itemBuilder({
    required FilterModel model,
    required bool isSelected,
    required int index,
    required String title
  }){
    return InkWell(
      onTap: (){
        setState(() {
          if(model.image == Images.coin){
            price = index;
          }else if (model.image == Images.rate){
            rate = index;
          }else{
            location = index;
          }
        });
      },
      child: Column(
        children: [
          Row(
            children: [
              Text(
                tr(title),
                style:const TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color:Colors.black),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 10,
                backgroundColor: defaultColor,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 9,
                  child:isSelected? CircleAvatar(
                    radius: 8,
                    backgroundColor: defaultColor,
                  ):null,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
