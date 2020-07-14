
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:quarentify/components/top.genres.widget.dart';
import 'package:quarentify/components/top.tracks.widget.dart';
import 'package:quarentify/functions.dart';

import 'components/top.artists.widget.dart';

class HomeScreen extends StatefulWidget {

  final String accessToken;

  const HomeScreen({Key key, this.accessToken}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool firstButtonLoad = false;
  bool secondButtonLoad = false;
  bool initialLoading = true;

  String tempToken = "BQAqxmT7eNxGcoI-2OmYndlq-oCArffIfIftYKQOrcGK_IfJsLbFl3xHqAIt1DsVcDt43hTyoruqotGY7sUlbOjW_YCeuhYOZZUb6ZZ3L-d0ORyd_-zh7N938pJcq37NllIHwtciuBPmNqi-1pAhVMe3KNtMo-vOXWgDRBg";

  var tracks;
  var artists;
  List<dynamic> genres = List();

  ScrollController scrollController = new ScrollController();

  manageTopRead() async {
    // ! CHANGE TEMPTOKEN TO WIDGET.ACCESSTOKEN
    tracks = await getTopRead("tracks", widget.accessToken);
    artists = await getTopRead("artists", widget.accessToken);
    List<dynamic> artistsGenres = await getTopGenresByArtists(artists);
    List<dynamic> tracksGenres = await getTopGenresByMusic(tracks, widget.accessToken);
    genres.addAll(artistsGenres);
    genres.addAll(tracksGenres);
    setState(() {
      initialLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    manageTopRead();
  }

  @override
  Widget build(BuildContext context) {
    if (initialLoading == true) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "QUARENTIFY",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTracksWidget(
                tracks: tracks.items.sublist(0, 20),
              ),
              TopArtistsWidget(
                artists: artists.items.sublist(0, 20),
              ),
              TopGenresWidget(
                genres: genres,
              ),

              // CustomButton(
              //   isLoading: firstButtonLoad,
              //   text: "Pesquisa por Músicas".toUpperCase(),
              //   width: 300,
              //   onTap: () async {
              //     setState(() { firstButtonLoad = true; });
              //     // var genres = await getTopGenresByMusic(tracks, widget.accessToken);
              //     var genres = await getTopGenresByMusic(tracks, tempToken);
              //     setState(() { firstButtonLoad = false; });
              //     print(genres);
              //   },
              // ),
              // SizedBox(height: 20),
              // CustomButton(
              //   isLoading: secondButtonLoad,
              //   text: "Pesquisa por Artistas".toUpperCase(),
              //   width: 300,
              //   onTap: () async {
              //     setState(() { secondButtonLoad = true; });
              //     var genres = await getTopGenresByArtists(artists);
              //     setState(() { secondButtonLoad = false; });
              //     print(genres);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}