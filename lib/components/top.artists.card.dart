import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quarentify/models/top.artists.model.dart';

class TopArtistsCard extends StatelessWidget {

  final ArtistsItems artist;

  const TopArtistsCard({Key key, @required this.artist}) : super(key: key);

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
                  artist.images[1].url,
                ),
                fit: BoxFit.cover
              )
            ),
          ),
          AutoSizeText(
            "${artist.name}",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 12
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 5),
              AutoSizeText(
                "${artist.followers.total}",
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7B7B7B),
                  fontSize: 12
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}