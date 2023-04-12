import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/widgets/story/store_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../models/user/home_model.dart';

class ListStories extends StatelessWidget {
  ListStories({this.padding=20,this.color = Colors.white,this.isProvider = false,this.stories});

  double padding;
  Color color;
  bool isProvider;
  List<Stories>? stories;

  @override
  Widget build(BuildContext context) {
    return  ConditionalBuilder(
      condition: stories!=null,
      fallback: (context)=>Text(tr('no_stories'),style: TextStyle(color: Colors.white),),
      builder: (context)=> SizedBox(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: padding),
            itemBuilder: (c,i)=>StoryItem(stories:stories![i],color:color,isProvider:isProvider),
            separatorBuilder: (c,i)=>const SizedBox(width: 10,),
            itemCount: stories!.length
        ),
      ),
    );
  }
}