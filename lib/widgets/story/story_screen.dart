import 'package:flutter/material.dart';
import 'package:wee_made/widgets/story/story_widget.dart';

import '../../models/user/home_model.dart';

class StoryScreen extends StatelessWidget {
  StoryScreen(this.stories,{this.isProvider = false});

  Stories stories;
  bool isProvider;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StoryWidget(
        stories: stories,
        isProvider: isProvider,
      ),
    );
  }
}
