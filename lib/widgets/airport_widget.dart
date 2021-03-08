import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_app/models/airport.dart';

class AirportWidget extends StatelessWidget {
  final Airport airport;

  AirportWidget({Key key, this.airport}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(airport.img, height: 40,),
        SizedBox(width: 8),
        Text(airport.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14)),
      ],
    );
  }
}
