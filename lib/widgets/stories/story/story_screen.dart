import 'package:flutter/material.dart';
import 'package:wee_made/widgets/stories/story/story_widget.dart';

class StoryScreen extends StatelessWidget {
  StoryScreen({this.isProvider = false});

 //Stories stories;
  bool isProvider;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StoryWidget(
       // stories: stories,
        isProvider: isProvider,
      ),
    );
  }
}
