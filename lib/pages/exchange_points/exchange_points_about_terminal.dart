import 'package:flutter/material.dart';
import 'package:test_app/utils/location.dart';
import 'package:test_app/widgets/CustomButton.dart';

class ExchangePointsAboutTerminal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Text(
              'Sed consectetur convallis parturient suscipit commodo. Potenti habitant semper nunc tincidunt dignissim.  Et mauris aenean porttitor nunc, phasellus dui ultrices integer. Mattis quam tincidunt molestie viverra in hendrerit mattis quis. Urna faucibus ultrices arcu.\n\n'
              'Sed consectetur convallis parturient suscipit commodo. Potenti habitant semper nunc tincidunt dignissim.  Et mauris aenean porttitor nunc, phasellus dui ultrices integer. Mattis quam tincidunt molestie viverra in hendrerit mattis quis. Urna faucibus ultrices arcu.Sed consectetur convallis parturient suscipit commodo. Potenti habitant semper nunc tincidunt dignissim.',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white),
              textAlign: TextAlign.center),
        ),
        Image.asset('assets/images/photo_exchange.png'),
        Spacer(),
        CustomButton(
          title: 'Проложить маршрут',
          callback: () {
            determinePosition().then((position) {
              if(position != null) {
                launchMapsUrl(position.latitude, position.longitude);
              }
            });
          },
        )
      ],
    );
  }
}
