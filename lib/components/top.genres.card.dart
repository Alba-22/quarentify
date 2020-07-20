import 'package:flutter/material.dart';

class TopGenresCard extends StatelessWidget {

  final String name;

  const TopGenresCard({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 230,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name.replaceAllMapped(
              RegExp(r"(^|(?<=\s))[a-z]"), 
              (match) => match.group(0).toUpperCase()
            ),
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}