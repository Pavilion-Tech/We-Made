import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wee_made/layouts/user_layout/user_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/images/images.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../../widgets/default_button.dart';
import 'join_us_screen.dart';

class IntroModel{
  IntroModel({
    required this.title,
    required this.image,
    required this.desc,
});

  String title;
  String image;
  String desc;
}

class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  bool isLast = false;
  List<IntroModel> intros = [
    IntroModel(
        title: 'Getting',
        image: Images.intro1,
        desc:'Your healthy Homemade products is not difficult anymore'
    ),
    IntroModel(
        title: 'Delivering',
        image: Images.intro2,
        desc:'The product to anywhere around all the Emirates, and soon all Arab world'
    ),
  ];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(Images.backGround),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 455,
                child: PageView.builder(
                  itemBuilder: (c,i)=>itemBuilder(intros[i]),
                  controller:controller,
                  onPageChanged: (int page){
                    setState(() {
                      isLast = !isLast;
                    });
                  },
                  itemCount: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Stack(
                  children: [
                    Container(
                      height: 7,
                      width: size!.width*.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(22),
                        color: HexColor('#EAE7B1')
                      ),
                    ),
                    Container(
                      height: 7,
                      width: isLast?size!.width*.4:size!.width*.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(22),
                          color: defaultColor
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: DefaultButton(
                  text:isLast? 'Get Started':'Next',
                  onTap: (){
                    if(isLast){
                      intro = true;
                      CacheHelper.saveData(key: 'intro', value: intro);
                      navigateAndFinish(context, UserLayout());
                    }else{
                      controller.animateTo(controller.position.maxScrollExtent, duration: Duration(milliseconds: 500), curve: Curves.easeInBack);
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget itemBuilder(IntroModel model){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(model.image,width: size!.width*.8,height: 269,),
        const SizedBox(height: 35,),
        Text(
          model.title,
          style: TextStyle(color: !isLast?defaultColor:null,fontSize: 42,fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            model.desc,
            textAlign: TextAlign.center,
            style:const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
