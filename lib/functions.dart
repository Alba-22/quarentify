import 'dart:html';
import 'package:dio/dio.dart';
import 'package:quarentify/models/artists.list.model.dart';
import 'package:quarentify/models/top.artists.model.dart';
import 'package:quarentify/models/top.tracks.model.dart';

getAuthToken() {
  var tokenStart = window.location.href.indexOf("access_token=");
  if (tokenStart == -1) {
    window.location.href = window.location.origin;
  }
  tokenStart += 13;
  var tokenEnd = window.location.href.indexOf("&");
  return window.location.href.substring(tokenStart, tokenEnd);
}

BaseOptions dioOptions = new BaseOptions(
  baseUrl: "https://api.spotify.com/v1",
  followRedirects: false,
  validateStatus: (status) {
    return status <= 500;
  },
);

Dio _dio = new Dio(dioOptions);

Future getTopRead(String type, String accessToken) async {
  try {
    final response = await _dio.get(
      "https://api.spotify.com/v1/me/top/$type",
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken"
        }  
      ),
    );
    if (response.statusCode == 200) {
      if (type == "tracks") {
        return TopTracksModel.fromJson(response.data);
      }
      else if (type == "artists") {
        return TopArtistsModel.fromJson(response.data);
      }
      return null;
    }
    else {
      window.alert(response.data);
      return null;
    }
  }
  catch (error) {
    print(error);
    return null;
  }
}

Future<ArtistsListModel> getArtistsList(String artistsIds,String accessToken) async {
  try {
    final response = await _dio.get(
      "/artists",
      queryParameters: {
        "ids": artistsIds
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken"
        }
      ),
    );

    if (response.statusCode == 200) {
      return ArtistsListModel.fromJson(response.data);
    }
    return null;
  }
  catch (error) {
    print(error);
    return null;
  }
}

Future getTopGenresByMusic(TopTracksModel tracksPo, String accessToken) async {
  if (tracksPo != null) {
    final artistsIdsMap = tracksPo.items.map((element) {
      return element.artists[0];
    })
    .map((element) {
      return element.id;
    });

    String artistsIdsString = artistsIdsMap.join(",");

    final ArtistsListModel artistsList = await getArtistsList(artistsIdsString, accessToken);

    if (artistsList != null) {
      List topGenre = [{ "times": 0, "name": "" }];
      Map<String, dynamic> genresObj = {};

      artistsList.artists.forEach((artist) {
        artist.genres.forEach((genre) {
          if (genresObj.containsKey(genre)) {
            genresObj[genre] += 1;
          }
          else {
            genresObj[genre] = 1;
          }

          // Resets the array with the new top genre or adds another genre if it's just as liked
          if (genresObj[genre] > topGenre[0]["times"]) {
            topGenre = [ { "times": genresObj[genre], "name": genre } ];
          }
          else if (genresObj[genre] == topGenre[0]["times"] && !topGenre.any((element) => element["name"] == genre)) {
            topGenre.add({ "times": genresObj[genre], "name": genre });
          } 
        });
      });
      return topGenre;
    }
    else {
      window.alert("Failed");
      window.location.href = window.location.origin;
      return null;
    }
  }
  window.alert("Failed");
  window.location.href = window.location.origin;
  return null;
}

Future getTopGenresByArtists(TopArtistsModel artistsPo) async {
  if (artistsPo != null) {

    List topGenre = [{ "times": 0, "name": "" }];
    Map<String, dynamic> genresObj = {};

    artistsPo.items.forEach((artist) {
      artist.genres.forEach((genre) {
        if (genresObj.containsKey(genre)) {
          genresObj[genre] += 1;
        }
        else {
          genresObj[genre] = 1;
        }

        // Resets the array with the new top genre or adds another genre if it's just as liked
        if (genresObj[genre] > topGenre[0]["times"]) {
          topGenre = [ { "times": genresObj[genre], "name": genre } ];
        }
        else if (genresObj[genre] == topGenre[0]["times"] && !topGenre.any((element) => element["name"] == genre)) {
          topGenre.add({ "times": genresObj[genre], "name": genre });
        } 
      });
    });
    return topGenre;
  }
  window.alert("Failed");
  window.location.href = window.location.origin;
  return null;
}

testPrint(List artist) {
  artist.forEach((element) {
    print("Genre: ${element["genres"]}");
  });
}
