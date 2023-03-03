import 'package:flutter/material.dart';
import 'package:wee_made/shared/components/constants.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../widgets/stories/list_stories.dart';
import '../../menu_screens/chat/chat_history_screen.dart';
import '../../menu_screens/notification.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Images.curveHome,height: size!.height*.32,width: double.infinity,fit: BoxFit.cover,),
        Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title:Image.asset(Images.title,width: 180,),
              leading:InkWell(
                  onTap: (){
                    Scaffold.of(context).openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(Images.menu,width: 2,height: 2,),
                  )),
              actions: [
                IconButton(
                    onPressed: (){
                      navigateTo(context, ChatHistoryScreen());
                    },
                    icon: Image.asset(Images.send,width: 20,)
                ),
                IconButton(
                    onPressed: (){
                     navigateTo(context, NotificationScreen());
                    },
                    icon: Image.asset(Images.notification,width: 20,)
                ),
              ],

            ),
            //const SizedBox(height: ,),
            ListStories()
          ],
        )
      ],
    );
  }
}
