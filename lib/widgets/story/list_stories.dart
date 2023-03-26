import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/widgets/story/store_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ListStories extends StatelessWidget {
  ListStories({this.padding=20,this.color = Colors.white,this.isProvider = false});

  double padding;
  Color color;
  bool isProvider;

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = UserCubit.get(context);
    return ConditionalBuilder(
      condition: cubit.homeModel!.data!.stories!.isNotEmpty,
      fallback: (context)=>Text('No Stories Yet',style: TextStyle(color: Colors.white),),
      builder: (context)=> SizedBox(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: padding),
            itemBuilder: (c,i)=>StoryItem(stories:cubit.homeModel!.data!.stories![i],color:color,isProvider:isProvider),
            separatorBuilder: (c,i)=>const SizedBox(width: 10,),
            itemCount: cubit.homeModel!.data!.stories!.length
        ),
      ),
    );
  },
);
  }
}