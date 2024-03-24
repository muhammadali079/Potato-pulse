import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomSplash extends StatelessWidget {
  const CustomSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: (MediaQuery.of(context).size.width)/2,
           height: (MediaQuery.of(context).size.height)/2,
          child: Center(
            child: LottieBuilder.asset(
                "assets/lottie/Animation - 1710912054191.json"),
          ),
         
        ),
         Text('Loading....'),
      ],
    );
  }
}
