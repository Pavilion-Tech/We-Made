import 'package:flutter/material.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
class ProviderNavBar extends StatelessWidget {
  final List<Map<String, Widget>> items;
  ProviderNavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit =ProviderCubit.get(context);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: items.map((e) {
                  return GestureDetector(
                    onTap: () => cubit.changeIndex(items.indexOf(e),context),
                    child: Container(
                      width: 70,
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
