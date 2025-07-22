import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_app_button.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage(
                "assets/onboarding image 2.png",
              ),
              fit: BoxFit.fitWidth,
              width: double.infinity,
            ),

            Container(
              height: MediaQuery.of(context).size.height * .55,
              child: Image(
                filterQuality: FilterQuality.high,
                image: AssetImage(
                  "assets/onboarding image.png",
                ),
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            //          const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Your Ultimate ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Car Rental',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: blueColor,
                        letterSpacing: 1),
                  ),
                  TextSpan(
                    text: '\nExperience',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing: 1),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            const Text(
              "Find Your Perfect Car",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),

            const Text(
              "Start exploring the best rental cars right now.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 15),

            CustomAppButton(
                title: "User",
                onPress: () {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.userLoginScreen);
                }),

            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 5),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(fixedSize: Size(330, 40)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.renterLoginScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Renter ",
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            color: blueColor),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
