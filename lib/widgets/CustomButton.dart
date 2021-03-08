import 'package:flutter/material.dart';
import 'package:test_app/constants/palette.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;

  const CustomButton({Key key, this.title = '', @required this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 40),
            width: MediaQuery.of(context).size.width,
            color: activeColor,
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
