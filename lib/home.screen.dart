
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:quarentify/components/custom.button.dart';
import 'package:quarentify/functions.dart';
import 'models/top.artists.model.dart';
import 'models/top.tracks.model.dart';

class HomeScreen extends StatefulWidget {

  final String accessToken;

  const HomeScreen({Key key, this.accessToken}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool firstButtonLoad = false;
  bool secondButtonLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF282828),
      appBar: AppBar(
        backgroundColor: Color(0xFF1DB954),
        title: Text(
          "SPOTIFY GÊNEROS"
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              isLoading: firstButtonLoad,
              text: "Pesquisa por Músicas".toUpperCase(),
              width: 300,
              onTap: () async {
                setState(() { firstButtonLoad = true; });
                final TopTracksModel tracks = await getTopRead("tracks", widget.accessToken);
                var genres = await getTopGenresByMusic(tracks, widget.accessToken);
                setState(() { firstButtonLoad = false; });
                print(genres);
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              isLoading: secondButtonLoad,
              text: "Pesquisa por Artistas".toUpperCase(),
              width: 300,
              onTap: () async {
                setState(() { secondButtonLoad = true; });
                final TopArtistsModel artists = await getTopRead("artists", widget.accessToken);
                var genres = await getTopGenresByArtists(artists);
                setState(() { secondButtonLoad = false; });
                print(genres);
              },
            ),
          ],
        ),
      ),
    );
  }
}