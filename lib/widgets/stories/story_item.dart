import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wee_made/widgets/stories/story/story_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/images/images.dart';

class StoryItem extends StatelessWidget {
  StoryItem({required this.color,required this.image,this.isProvider = false});

  //Stories stories;
  bool isProvider;
  Color color;
  String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>navigateTo(context, StoryScreen(isProvider: isProvider,)),
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
              child:Image.asset(image),
            ),
          ),
          Text(
              'Store Family',
            style: TextStyle(color: color,fontWeight: FontWeight.w700,fontSize: 10),
          )
        ],
      ),
    );
  }
}
