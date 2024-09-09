import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parttime/core/cubits/isFirsttime/is_firsttime_cubit.dart';
import 'package:parttime/core/pages/route_finder_page.dart';
import 'package:parttime/core/widgets/first_open_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstOpenPage extends StatefulWidget {
  const FirstOpenPage({super.key});

  @override
  State<FirstOpenPage> createState() => _FirstOpenPageState();
}

class _FirstOpenPageState extends State<FirstOpenPage> {
  final PageController controller = PageController();
  bool isLastpage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 80.00),
        child: PageView(
          controller: controller,
          onPageChanged: (index) {
            setState(() {
              isLastpage = index == 2;
            });
          },
          children: [
            FirstOpenWidgets(
              tittle: 'Simply find your part time job',
              imgPath: 'assets/images/img1.jpg',
              height: 70,
            ),
            FirstOpenWidgets(
              tittle: 'Post a job vacancy and find job seekers ',
              imgPath: 'assets/images/img3.jpg',
            ),
            FirstOpenWidgets(
              tittle: 'Get started with part time jobs LK',
              imgPath: 'assets/images/img2.jpg',
              height: 60,
            ),
          ],
        ),
      ),
      bottomSheet: isLastpage
          ? TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(),
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(80)),
              onPressed: () {
                context.read<IsFirsttimeCubit>().saveFirstTime();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => RouteFinderPage(),
                ));
              },
              child: Text('Get Start'))
          : Container(
              color: Colors.white,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => controller.jumpToPage(2),
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Colors.blue),
                      )),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    onDotClicked: (index) => controller.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn),
                  ),
                  TextButton(
                      onPressed: () => controller.nextPage(
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeInOut,
                          ),
                      child:
                          Text('Next', style: TextStyle(color: Colors.blue))),
                ],
              ),
            ),
    );
  }
}
