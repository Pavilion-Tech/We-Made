import 'package:flutter/material.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/shared/components/constants.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/images/images.dart';
import '../../../../widgets/stories/list_stories.dart';
import '../../home/add_highlight_screen.dart';

class PHomeAppBar extends StatelessWidget {
  const PHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Images.curveHome,height: size!.height*.3,width: double.infinity,fit: BoxFit.cover,),
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
                     // navigateTo(context, ChatHistoryScreen());
                    },
                    icon: Image.asset(Images.send,width: 20,)
                ),
                IconButton(
                    onPressed: (){
                     ProviderCubit.get(context).changeIndex(1, context);
                    },
                    icon: Image.asset(Images.notification,width: 20,)
                ),
              ],

            ),
            //const SizedBox(height: ,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: (){
                      navigateTo(context, AddHighlightScreen());
                    },
                    child: Container(
                      height: 72,
                      width: 72,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                          shape: BoxShape.circle,
                      ),
                      padding:const EdgeInsetsDirectional.all(20),
                      child:Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(30),
                        ),
                        child:Image.asset(Images.add2),
                      ),
                    ),
                  ),
                ),
                Expanded(child: ListStories(color: Colors.transparent,padding: 0,isProvider: true,)),
              ],
            )
          ],
        )
      ],
    );
  }
}
