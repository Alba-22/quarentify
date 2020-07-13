import 'package:flutter/material.dart';
import 'package:quarentify/functions.dart';
import 'package:quarentify/models/top.artists.model.dart';
import 'package:quarentify/models/top.tracks.model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF282828),
      appBar: AppBar(
        backgroundColor: Color(0xFF1DB954),
        title: Text(
          "SPOTIFY GENRES"
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
            Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                color: Color(0xFF1DB954),
                borderRadius: BorderRadius.circular(15)
              ),
              child: MaterialButton(
                onPressed: () async {
                  const ACCESS_TOKEN = "BQDONxm1rypj6L3-ZXnQi3UMY2fxMbvMl5_M3jDtT4h3Q3bnyONjbUREbRh6dmKxcq_yumHtgOP4UDsUpKQKJ3IOD0ROYifCxparYEEssWCUFQkpK21R_8Hp3X9AiFsyi8V9veJtlAo8_120UevVToqzv1Fx6udA1e8sdkM";
                  final TopTracksModel tracks = await getTopRead("tracks", ACCESS_TOKEN);
                  var genres = await getTopGenresByMusic(tracks, ACCESS_TOKEN);
                  print(genres);
                },
                child: Text(
                  "BY MUSICS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                color: Color(0xFF1DB954),
                borderRadius: BorderRadius.circular(15)
              ),
              child: MaterialButton(
                onPressed: () async {
                  const ACCESS_TOKEN = "BQDONxm1rypj6L3-ZXnQi3UMY2fxMbvMl5_M3jDtT4h3Q3bnyONjbUREbRh6dmKxcq_yumHtgOP4UDsUpKQKJ3IOD0ROYifCxparYEEssWCUFQkpK21R_8Hp3X9AiFsyi8V9veJtlAo8_120UevVToqzv1Fx6udA1e8sdkM";
                  final TopArtistsModel artists = await getTopRead("artists", ACCESS_TOKEN);
                  var genres = await getTopGenresByArtists(artists);
                  print(genres);
                },
                child: Text(
                  "BY ARTISTS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   height: MediaQuery.of(context).size.height,
    //   color: Colors.white,
    //   child: FlatButton(
    //     color: Colors.orange,
    //     onPressed: () async {
    //       const ACCESS_TOKEN = "BQBkguK69eCE72CCekdhPZ-f6iFGEzde2DRNozJQBD3opirUSBlOGASVqClrRGsbQcqKrdFIs-qkHmvRUzKokofhBSInto9C48qC39LGJ9ckdrWvzy7rY30bqJ7bqmPbvCP72AXeTB7wqLvdT2sLqf2cT6HnncosNhyHMa8";
    //       final TopArtistsModel artists = await getTopRead("artists", ACCESS_TOKEN);
    //       var genres = await getTopGenresByArtists(artists);
    //       print(genres);
    //     },
    //     child: Text(
    //       "GIT GUD",
    //       style: TextStyle(
    //         fontSize: 18,
    //         color: Colors.white
    //       ),
    //     ),
    //   )
    // );
  }
}