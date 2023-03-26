import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_cubit.dart';
import 'package:wee_made/layouts/user_layout/user_cubit/user_states.dart';
import 'package:wee_made/widgets/story/user_info.dart';
import '../../../shared/components/components.dart';
import '../../models/user/home_model.dart';
import '../../modules/user/store/store_screen.dart';
import '../../shared/components/constants.dart';
import '../image_net.dart';
import 'animated_bar.dart';
import 'models/user_model.dart';



class StoryWidget extends StatefulWidget {
  Stories stories;
  bool isProvider;


  StoryWidget({required this.stories,this.isProvider = false});

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget>
    with SingleTickerProviderStateMixin {
   PageController? _pageController;
   AnimationController? _animController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    _loadStory(animateToPage: false);

    _animController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController!.stop();
        _animController!.reset();
        setState(() {
          if (_currentIndex + 1 < widget.stories.stories!.length) {
            _currentIndex += 1;
            _loadStory();
          } else {

            bool lastPage = _pageController!.page == widget.stories.stories!.length;
            lastPage
                ? _pageController!.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut)
                : Navigator.pop(context);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController!.dispose();
    _animController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final story = widget.stories;
    return SafeArea(
      child: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.stories.stories!.length,
              itemBuilder: (context, i) {
                final String story = widget.stories.stories![i];
                return ImageNet(image: story);
              },
            ),
            Positioned(
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10.0,
                    ),
                    child: InkWell(
                      onTap: (){
                       // WafrCubit.get(context).getStore(story.id??'');
                       // WafrCubit.get(context).getStoryProducts(story.id??'');
                        navigateTo(context, StoreScreen());
                      },
                      child: UserInfo(user: User(
                          name: story.storeName??'',
                          profileImageUrl: story.providerStoryThumbnail??''
                      )),
                    ),
                  ),
                  Row(
                    children: widget.stories.stories!
                        .asMap()
                        .map((i, e) {
                      return MapEntry(
                        i,
                        AnimatedBar(
                          animController: _animController!,
                          position: i,
                          currentIndex: _currentIndex,
                        ),
                      );
                    })
                        .values
                        .toList(),
                  ),
                ],
              ),
            ),
            if(!widget.isProvider)
              Align(
              alignment: AlignmentDirectional.bottomCenter,
                child:  SeeMore(widget.stories.id??''))
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    bool firstPage = _pageController!.page !=0.0;
    bool lastPage = _pageController!.page == widget.stories.stories!.length;
    if (dx < screenWidth / 3) {
      setState(() {
        if(myLocale == 'en'){
          if (_currentIndex - 1 >= 0) {
            _currentIndex -= 1;
            _loadStory();
          }else{
            firstPage
                ? _pageController!.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut)
                : Navigator.pop(context);
          }
        }else{
          if (_currentIndex + 1 < widget.stories.stories!.length) {
            _currentIndex += 1;
            _loadStory();
          } else {
            lastPage
                ? _pageController!.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut)
                : Navigator.pop(context);
          }
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if(myLocale == 'en'){
          if (_currentIndex + 1 < widget.stories.stories!.length) {
            _currentIndex += 1;
            _loadStory();
          } else {
            lastPage
                ? _pageController!.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut)
                : Navigator.pop(context);
          }
        }else{
          if (_currentIndex - 1 >= 0) {
            _currentIndex -= 1;
            _loadStory();
          }else{
            firstPage
                ? _pageController!.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut)
                : Navigator.pop(context);
          }
        }

      });
    }
  }

  void _loadStory({bool animateToPage = true}) {
    _animController!.stop();
    _animController!.reset();
    _animController!.duration = const Duration(seconds: 8);
    _animController!.forward();
    if (animateToPage) {
      _pageController!.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class SeeMore extends StatefulWidget {
  SeeMore(this.id);

  String id;

  @override
  State<SeeMore> createState() => _SeeMoreState();
}

class _SeeMoreState extends State<SeeMore> {

  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<UserCubit, UserStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = UserCubit.get(context);
    return AnimatedContainer(
      duration:const Duration(milliseconds: 500),
      height: isOpen?size!.height*.7:80,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      color: Colors.black54,
      child: Column(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                isOpen = !isOpen;
                //if(isOpen)cubit.getStoryProducts(widget.id);
              });
            },
            child: Row(
              children: [
                Text(
                  tr('see_more'),
                  style:const  TextStyle(
                    color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16
                  ),
                ),
                const Spacer(),
                // state is! GetProviderProductsLoadingState ?Icon(
                //   isOpen?Icons.arrow_drop_down:Icons.arrow_drop_up,
                //   color: Colors.white,):const CircularProgressIndicator()
              ],
            ),
          ),
          if(isOpen)
            const SizedBox(height: 20,),
          //if(isOpen&&state is! GetProviderProductsLoadingState)
          // Expanded(
          //     child: ListView.separated(
          //         itemBuilder: (c,i)=>ProductWidget(product: cubit.providerProductModel!.data!.data![i],isStory: true),
          //         separatorBuilder: (c,i)=>const SizedBox(height: 20,),
          //         itemCount: cubit.providerProductModel!.data!.data!.length
          //     )
          // ),
        ],
      ),
    );
  },
);
  }
}



