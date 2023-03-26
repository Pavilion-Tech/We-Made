import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wee_made/widgets/story/story_screen.dart';
import '../../models/user/home_model.dart';
import '../../shared/components/components.dart';
import '../image_net.dart';

class StoryItem extends StatelessWidget {
  StoryItem({required this.color,required this.stories,this.isProvider = false});

  Stories stories;
  bool isProvider;
  Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, StoryScreen(stories,isProvider: isProvider,)),
      child: Column(
        children: [
          Container(
            height: 72,
            width: 72,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red,
                    Colors.red,
                    Colors.yellow,
                    HexColor('#839EFF99'),
                    HexColor('#839EFF99'),
                    HexColor('#839EFF'),
                    HexColor('#EE000099'),
                  ],
                )
            ),
            padding:const EdgeInsetsDirectional.all(4),
            child:Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(30),
              ),
              child:ImageNet(image:stories.providerStoryThumbnail??''),
            ),
          ),
          Text(
            stories.storeName??'',
            style: TextStyle(color: color,fontWeight: FontWeight.w700,fontSize: 10),
          )
        ],
      ),
    );
  }
}