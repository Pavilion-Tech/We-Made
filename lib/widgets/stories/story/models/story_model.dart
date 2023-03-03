

import 'package:wee_made/widgets/stories/story/models/user_model.dart';

class Story {
  final String url;
  final Duration duration;
  final User user;

  const Story({
    required this.url,
    required this.duration,
    required this.user,
  });
}