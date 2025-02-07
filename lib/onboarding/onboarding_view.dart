import "package:flutter/material.dart";
import 'package:mybete_app/onboarding/onboarding_items.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //Skip button
            TextButton(
                onPressed: (){},
                child: const Text("Skip")),

            //Indicator
            SmoothPageIndicator(
                controller: pageController,
                count: controller.items.length,
                effect: const WormEffect(
                  activeDotColor: Color(0x0096D8E3)
                ),
            ),

            //Next button
            TextButton(
                onPressed: (){},
                child: const Text("Next")),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.items[index].image,
                  const SizedBox(height: 15,),
                  Text(controller.items[index].title,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 15,),
                  Text(controller.items[index].descriptions,style: TextStyle(color: Colors.grey,fontSize: 17), textAlign: TextAlign.center,),

                ],
              );
            }
        ),
      ),
    );
  }
}
