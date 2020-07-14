import 'package:flutter/material.dart';

class TopGenresWidget extends StatelessWidget {

  final List<dynamic> genres;

  const TopGenresWidget({Key key, @required this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Gêneros mais Ouvidos",
              style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: 20
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: MediaQuery.of(context).size.width * 0.05
            ),
            height: 0.5,
            color: Theme.of(context).textSelectionColor,
          ),
        ],
      ),
    );
  }
}