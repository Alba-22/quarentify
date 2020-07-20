import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final double width;
  final String text;
  final Function onTap;
  final bool isLoading;

  const CustomButton({Key key, this.width, this.text, this.onTap, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width != null
      ? width
      : 180,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25)
        ),
        color: Color(0xFF1DB954),
        onPressed: onTap,
        child: isLoading == false
        ? Text(
          "$text",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        )
        : Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      ),
    );
  }
}