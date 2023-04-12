import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/modules/auth/login_screen.dart';
import 'package:wee_made/shared/components/constants.dart';
import 'package:wee_made/widgets/story/models/user_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../widgets/story/list_stories.dart';
import '../../menu_screens/chat/chat_history_screen.dart';
import '../../menu_screens/menu_cubit/menu_cubit.dart';
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
                      if(token!=null){
                        MenuCubit.get(context).chatHistory();
                        navigateTo(context, ChatHistoryScreen());
                      }else{
                        navigateTo(context,LoginScreen(haveArrow: true,));
                      }
                    },
                    icon: Image.asset(Images.send,width: 20,)
                ),
                IconButton(
                    onPressed: (){
                      if(token!=null){
                        MenuCubit.get(context).getAllNotification();
                        navigateTo(context, NotificationScreen());
                      }else{
                        navigateTo(context,LoginScreen(haveArrow: true,));
                      }
                    },
                    icon: Image.asset(Images.notification,width: 20,)
                ),
              ],

            ),
            //const SizedBox(height: ,),
            ListStories(stories: UserCubit.get(context).homeModel!.data!.stories,)
          ],
        )
      ],
    );
  }
}
