import 'package:flutter/material.dart';
import 'package:quarentify/components/top.artists.card.dart';
import 'package:quarentify/models/top.artists.model.dart';

class TopArtistsWidget extends StatelessWidget {

  final List<ArtistsItems> artists;

  TopArtistsWidget({Key key, @required this.artists}) : super(key: key);

  final scrollController = new ScrollController();
  
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
            child: Text.rich(
              TextSpan(
                text: "Top 10 Artistas",
                children: [
                  TextSpan(
                    text: "  (clique para ver o perfil)",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.5
                    )
                  )
                ]
              ),
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
              itemCount: artists.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: index == 0
                  ? EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)
                  : EdgeInsets.all(0),
                  child: TopArtistsCard(
                    artist: artists[index],
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