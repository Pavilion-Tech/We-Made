import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/modules/auth/login_screen.dart';
import 'package:wee_made/modules/user/widgets/shimmer/product_shimmer.dart';
import 'package:wee_made/widgets/image_screen.dart';
import 'package:wee_made/widgets/no_items/no_product.dart';
import '../../../models/user/home_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../../shared/styles/colors.dart';
import '../../../widgets/image_net.dart';
import '../../../widgets/story/list_stories.dart';
import '../widgets/category/category_store.dart';
import '../widgets/menu/chat/spcial_dialog.dart';
import '../widgets/product/product_grid.dart';

class StoreScreen extends StatefulWidget {
  StoreScreen(this.providerId);
  ProviderId providerId;
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  CategorStoreyWidget? categorStoreyWidget;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image.asset(Images.curvesBackGround,height: double.infinity,width: double.infinity,fit: BoxFit.cover,),
          Container(
            height: size!.height*.7,
            width: double.infinity,
            decoration:const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20),
                )
            ),
            child: Image.asset(Images.backGround,width: double.infinity,fit: BoxFit.cover,),
          ),
          Column(
            children: [
              defaultAppBar(
                  isProduct: true,
                  title: widget.providerId.storeName??'',
                  backColor:Colors.white,context: context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap:(){
                          navigateTo(context, ImageScreen(widget.providerId.personalPhoto??''));
                        },
                        child: Center(
                            child: Container(
                              height: 230,width: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ImageNet(image:widget.providerId.personalPhoto??'',),
                            )
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child:  ConditionalBuilder(
                                  condition: widget.providerId.stories!.stories!=null,
                                    fallback: (context)=>const SizedBox(),
                                    builder: (context)=> ListStories(padding:0,color:Colors.black,stories:[widget.providerId.stories!],isProvider: true)),
                              ),
                              Row(
                                children: [
                                  // CircleAvatar(
                                  //   radius: 20,
                                  //   backgroundColor: Colors.grey.shade300,
                                  //   child: Image.asset(Images.whats2,color: defaultColor,width: 25,),
                                  // ),
                                  // const SizedBox(width: 20,),
                                  InkWell(
                                    onTap: (){
                                      final Uri launchUri = Uri(
                                        scheme: 'tel',
                                        path: widget.providerId.phoneNumber??'',
                                      );
                                      openUrl(launchUri.toString());
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: defaultColor,
                                      child: Icon(Icons.phone,color: Colors.white,size: 25,),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                      onTap: () async {
                                        if(token!=null){
                                          showDialog(
                                              context: context,
                                              builder: (context)=>SpecialDialog(widget.providerId.id??'')
                                          );
                                        }else{
                                          navigateTo(context, LoginScreen(haveArrow: true,));
                                        }

                                      },
                                    child: Text(
                                      tr('special_request'),
                                      style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                              //   child:Row(
                              //     children: [
                              //       Expanded(
                              //         child: TextFormField(
                              //           cursorColor: Colors.black,
                              //           style: TextStyle(color: Colors.black),
                              //           decoration: InputDecoration(
                              //             border:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color:defaultColor)),
                              //             enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color:defaultColor)),
                              //             focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(43),borderSide: BorderSide(color:defaultColor)),
                              //             hintText: tr('search_by_product'),
                              //             hintStyle: TextStyle(color: defaultColor,fontSize: 15),
                              //             prefixIcon: Padding(
                              //               padding: const EdgeInsets.all(12.0),
                              //               child:  Image.asset(Images.search,width: 1,height: 1,),
                              //             ),
                              //             isDense: true,
                              //           ),
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         width: 20,
                              //       ),
                              //       InkWell(
                              //         onTap: (){
                              //           showDialog(
                              //               context: context,
                              //               builder: (context)=>FilterWidget()
                              //           );
                              //         },
                              //         child: Image.asset(
                              //           Images.filter,
                              //           width: 30,
                              //           color: defaultColor,
                              //         ),
                              //       )
                              //     ],
                              //   ),w
                              // ),
                              if(widget.providerId.categoryId!.isNotEmpty)
                                Builder(builder: (context){
                                  categorStoreyWidget =  CategorStoreyWidget(
                                    widget.providerId.categoryId!,
                                    widget.providerId.id??''
                                  );
                                  return categorStoreyWidget!;
                                }),
                                Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20.0),
                                child: Center(
                                  child: Text(
                                    UserCubit.get(context).currentCategory??'',
                                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30),
                                  ),
                                ),
                              ),
                             ConditionalBuilder(
                               condition: UserCubit.get(context).providerProductsModel!=null,
                                 fallback: (context)=>ConditionalBuilder(
                                     condition: state is! ProviderProductsLoadingState,
                                     builder: (context)=>const SizedBox(),
                                     fallback: (context)=>ProductShimmer()
                                 ),
                                 builder: (context)=> ConditionalBuilder(
                                   condition: UserCubit.get(context).providerProductsModel!.data!.data!.isNotEmpty,
                                     fallback: (context)=>NoProduct(),
                                     builder: (context)=> ProductGrid(
                                       products:  UserCubit.get(context).providerProductsModel!.data!.data!,
                                         padding: 0))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  },
);
  }
}
