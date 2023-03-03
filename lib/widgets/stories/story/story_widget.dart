import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wee_made/modules/user/widgets/product/product_grid.dart';
import 'package:wee_made/widgets/stories/story/user_info.dart';
import '../../../shared/components/constants.dart';
import 'animated_bar.dart';
import 'models/data.dart';
import 'models/story_model.dart';
import 'models/user_model.dart';



class StoryWidget extends StatefulWidget {
 // Stories stories;


  StoryWidget({this.isProvider = false});
  bool isProvider;

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget>
    with SingleTickerProviderStateMixin {
   PageController? _pageController;
   AnimationController? _animController;
  int _currentIndex = 0;
 //  List<String> stories = [Images.story];

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
          if (_currentIndex + 1 < stories.length) {
            _currentIndex += 1;
            _loadStory();
          } else {

            bool lastPage = _pageController!.page == stories.length;
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
  //  final story = widget.stories;
    return SafeArea(
      child: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stories.length,
              itemBuilder: (context, i) {
                final Story story = stories[i];
                return Image.network(story.url);
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
                      onTap: (){},
                      child: UserInfo(user: User(
                          name: 'Ahmed',
                          profileImageUrl: ''
                      )),
                    ),
                  ),
                  Row(
                    children: stories
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
                child:  SeeMore(''))
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    bool firstPage = _pageController!.page !=0.0;
    bool lastPage = _pageController!.page ==stories.length;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory();
        }else{
          firstPage
              ? _pageController!.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut)
              : Navigator.pop(context);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < stories.length) {
          _currentIndex += 1;
          _loadStory();
        } else {
          lastPage
              ? _pageController!.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut)
              : Navigator.pop(context);
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
    return  AnimatedContainer(
      duration:const Duration(milliseconds: 500),
      height: isOpen?size!.height*.7:80,
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      color: Colors.black12,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                tr('see_more'),
                style:const  TextStyle(
                    color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16
                ),
              ),
              const Spacer(),
              InkWell(
                  onTap: (){
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  child: Icon(
                    isOpen?Icons.arrow_drop_down:Icons.arrow_drop_up,
                    color: Colors.white,)
              )
            ],
          ),
          if(isOpen)
            const SizedBox(height: 20,),
          if(isOpen)
            Expanded(
                child: ProductGrid(padding: 0,)
            ),
        ],
      ),
    );
  }
}



