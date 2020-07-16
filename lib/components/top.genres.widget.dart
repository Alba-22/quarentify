import 'package:flutter/material.dart';
import 'package:quarentify/components/top.genres.card.dart';
import 'package:quarentify/models/top.genre.model.dart';

class TopGenresWidget extends StatelessWidget {

  final List<TopGenreModel> genres;

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
          Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: index == 0
                  ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.all(0),
                  child: TopGenresCard(name: genres[index].name)
                );
              },
            ),
          )
        ],
      ),
    );
  }
}