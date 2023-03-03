import 'package:flutter/material.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import '../../shared/styles/colors.dart';
class NavBar extends StatelessWidget {
  final List<Map<String, Widget>> items;
  NavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              height: 60,
              color: Colors.white,
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: SizedBox(
              height: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: items.map((e) {
                  return GestureDetector(
                    onTap: () => cubit.changeIndex(items.indexOf(e),context),
                    child: Container(
                      width: 100,
                        child: cubit.currentIndex == (items.indexOf(e))
                            ?Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadiusDirectional.circular(50),
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: e['activeIcon'],
                          ),
                        )
                        : e['icon']!
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
