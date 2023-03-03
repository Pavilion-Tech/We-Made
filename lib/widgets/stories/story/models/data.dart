

import 'package:wee_made/widgets/stories/story/models/story_model.dart';
import 'package:wee_made/widgets/stories/story/models/user_model.dart';

const User user =  User(
  name: 'John Doe',
  profileImageUrl: 'https://wallpapercave.com/wp/AYWg3iu.jpg',
);
final List<Story> stories = [
  const Story(
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    duration:  Duration(seconds: 10),
    user: user,
  ),
  const Story(
    url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
    user: user,
    duration:  Duration(seconds: 7),
  ),

  const Story(
    url:
    'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    duration:  Duration(seconds: 5),
    user: user,
  ),

  const Story(
    url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
    duration:  Duration(seconds: 8),
    user: user,
  ),
];