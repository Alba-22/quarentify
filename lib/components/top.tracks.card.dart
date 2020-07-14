import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quarentify/models/top.tracks.model.dart';

class TopTracksCard extends StatelessWidget {

  final TracksItems track;

  const TopTracksCard({Key key, @required this.track}) : super(key: key);

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
        children: [
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                  track.album.images[1].url,
                ),
                fit: BoxFit.cover
              )
            ),
          ),
          AutoSizeText(
            "${track.name}",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 12
            ),
          ),
          AutoSizeText(
            "${track.artists[0].name}",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF7B7B7B),
              fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}