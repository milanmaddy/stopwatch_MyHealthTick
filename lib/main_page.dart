import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stopwatch/all_controller.dart';
import 'package:stopwatch/page1.dart';
import 'package:stopwatch/page2.dart';
import 'package:stopwatch/page3.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final allController = Get.put(AllController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Meal Timer', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20
        ),),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black38,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SmoothPageIndicator(
              controller: allController.controller,
              count: 3,
              effect: ScaleEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.grey.shade800,
                dotHeight: 12,
                dotWidth: 12,
              ),
            ),
            Expanded(
                child: PageView(
                  // physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    allController.pageIndex.value = index;
                    allController.isStart1.value = false;
                    print(index);
                  },
                  controller: allController.controller,
                  children: [
                    Page1(),
                    Page2(),
                    Page3(),
                  ],
                )
            ),
          ],
        )



      ),
    );
  }
}
