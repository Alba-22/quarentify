
import 'dart:html';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quarentify/components/custom.button.dart';
import 'package:quarentify/components/top.genres.widget.dart';
import 'package:quarentify/components/top.tracks.widget.dart';
import 'package:quarentify/functions.dart';
import 'package:quarentify/models/top.genre.model.dart';
import 'components/top.artists.widget.dart';
import 'models/top.artists.model.dart';
import 'models/top.tracks.model.dart';

class HomeScreen extends StatefulWidget {

  final String accessToken;

  const HomeScreen({Key key, this.accessToken}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool playlistLoading = false;
  bool initialLoading = true;
  bool activeUser = true;

  TopTracksModel tracks;
  TopArtistsModel artists;
  List<TopGenreModel> artistsGenres = new List();
  List<TopGenreModel> tracksGenres = new List();
  List<TopGenreModel> topGenres = new List();

  ScrollController scrollController = new ScrollController();

  manageTopRead() async {
    tracks = await getTopRead("tracks", widget.accessToken);
    artists = await getTopRead("artists", widget.accessToken);
    if (artists.total == 0 || tracks.total == 0) {
      setState(() {
        activeUser = false;
        initialLoading = false;
      });
      return;
    }
    tracksGenres = await getTopGenresByTracks(tracks, widget.accessToken);
    artistsGenres = await getTopGenresByArtists(artists);
    topGenres = getAllTopGenres(tracksGenres, artistsGenres);
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
    if (activeUser == false) {
      return Scaffold(
        body: Container(
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.2
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "QUARENTIFY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 25
                ),
              ),
              SizedBox(height: 20),
              AutoSizeText(
                "Sua conta não possui dados o suficiente para exibição das informações.",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).textSelectionColor,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 15
                ),
                child: CustomButton(
                  width: 200,
                  text: "Tentar Novamente",
                  onTap: () {
                    window.location.href = window.location.origin;
                  },
                ),
              )
            ],
          )
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "QUARENTIFY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              String text = "Minha música mais escutada durante a quarentena foi ${tracks.items[0].artists[0].name} - ${tracks.items[0].name}.\nConfira a sua em https://quarentify.agst.dev";
              String share = 'https://twitter.com/intent/tweet?ref_src=twsrc%5Etfw&text=' + Uri.encodeComponent(text) + '&tw_p=tweetbutton';
              urlLauncher(share);
            },
            padding: EdgeInsets.only(right: 10),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopTracksWidget(
                tracks: tracks.total > 10
                ? tracks.items.sublist(0, 10)
                : tracks.items.sublist(0, tracks.total),
              ),
              TopArtistsWidget(
                artists: artists.total > 10
                ? artists.items.sublist(0, 10)
                : artists.items.sublist(0, artists.total),
              ),
              TopGenresWidget(
                genres: topGenres,
              ),
              InkWell(
                onTap: () async {
                  setState(() { playlistLoading = true; });
                  final tailoredId = await createTailoredPlaylist(artists, tracksGenres, widget.accessToken);
                  if (tailoredId != null) {
                    setState(() { playlistLoading = false; });
                    urlLauncher("https://open.spotify.com/playlist/$tailoredId");
                  }
                  else {
                    final playlistId = await createRecommendedPlaylist(widget.accessToken, tracks, artists);
                    setState(() { playlistLoading = false; });
                    urlLauncher("https://open.spotify.com/playlist/$playlistId");
                  }
                },
                child: Container(
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                  height: 50,
                  child: playlistLoading == false
                  ? Center(
                    child: Text(
                      "Criar Playlist Recomendada",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                  )
                  : Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}