import "package:flutter/material.dart";
import 'package:mybete_app/onboarding/onboarding_items.dart';

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
