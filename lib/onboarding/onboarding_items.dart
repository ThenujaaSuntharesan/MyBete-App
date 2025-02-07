import 'onboarding_info.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
      title: "Title 1",
      descriptions: "Description 1",
      image: SvgPicture.asset("assets/images/onboard_img_1.svg"),
    ),
    OnboardingInfo(
      title: "Title 2",
      descriptions: "Description 2",
      image: SvgPicture.asset("assets/images/onboard_img_2.svg"),
    ),
    OnboardingInfo(
      title: "Title 3",
      descriptions: "Description 3",
      image: SvgPicture.asset("assets/images/onboard_img_3.svg"),
    ),
    OnboardingInfo(
      title: "Title 4",
      descriptions: "Description 4",
      image: SvgPicture.asset("assets/images/onboard_img_4.svg"),
    ),
  ];
}
