import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/widgets/stories/story_item.dart';

class ListStories extends StatelessWidget {
  ListStories({this.padding=20,this.color = Colors.white,this.isProvider = false});

  double padding;
  Color color;
  bool isProvider;

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: padding),
          itemBuilder: (c,i)=>StoryItem(color:color,image:listImages[i],isProvider:isProvider),
          separatorBuilder: (c,i)=>const SizedBox(width: 10,),
          itemCount: listImages.length
      ),
    );
  }
}
