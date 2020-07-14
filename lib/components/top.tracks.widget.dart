import 'package:flutter/material.dart';
import 'package:quarentify/components/top.tracks.card.dart';
import 'package:quarentify/models/top.tracks.model.dart';

class TopTracksWidget extends StatelessWidget {

  final List<TracksItems> tracks;

  const TopTracksWidget({Key key, @required this.tracks}) : super(key: key);
  
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
              "Top 5 Músicas",
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
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tracks.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: index == 0
                  ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.all(0),
                  child: TopTracksCard(
                    track: tracks[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}