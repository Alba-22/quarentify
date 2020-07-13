import 'dart:convert';
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

Future getTopRead(String type, String authToken) async {
  try {
    final response = await _dio.get(
      "/me/top/$type",
      options: Options(
        headers: {
          "Authorization": "Bearer $authToken"
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

getRecommendations(String authToken, [tracksPo, artistsPo]) async {
  if (tracksPo == null && artistsPo == null)
    return null;
  
  var tracksIds;// = tracksPo.items.sublist(0, 2).map((item) => item.id).toList();
  var artistsIds;// = artistsPo.items.sublist(0, 2).map((item) => item.id);
  String requestString = "/recommendations?limit=50";
  if (tracksPo != null) {
    tracksIds = tracksPo.items.sublist(0, 2).map((item) => item.id);
    requestString = requestString + "&seed_tracks=" + tracksIds.join(",");
  }
  if (artistsPo != null) {
    artistsIds = artistsPo.items.sublist(0, 2).map((item) => item.id);
    requestString = requestString + "&seed_artists=" + artistsIds.join(",");
  }
  //String tracksIdsString = tracksIds.join(",");
  //String artistsIdsString = artistsIds.join(",");
  var recommendations = await _dio.get(
    requestString,
    options: Options(
      headers: {"Authorization": "Bearer $authToken"}
    )
  );

  if (recommendations.statusCode != 200) {
    // Resets to origin window if API does not return ok
    window.alert(recommendations.data);
    window.location.href = window.location.origin;
  }

  return recommendations.data;
}

getUserId(String authToken) async {
  var response = await _dio.get(
    "/me", 
    options: Options(
      headers: {"Authorization": "Bearer $authToken"}
    )
  );

  if (response.statusCode != 200) {
    window.alert(response.data);
    window.location.href = window.location.origin;
  }

  return response.data["id"];
}

createPlaylist(String authToken, String userId) async {
  var response = await _dio.post(
    "/users/$userId/playlists",
    data: { "name": "Quarentify Playlist", "public" : "false" },
    options: Options(
      headers: {"Authorization": "Bearer $authToken", "Content-Type": "application/json"},
    )
  );

  // Code may be 200 or 201 according to Spotify Docs
  if (response.statusCode != 200 && response.statusCode != 201) {
    window.alert(response.data);
    window.location.href = window.location.origin;
  }

  return response.data["id"];
}

createRecommendedPlaylist(tracksPo, artistsPo, String userId, String authToken) async{
  var recommendedTracksObj = await getRecommendations(tracksPo, artistsPo, authToken);
  // Creates a list of all the recommended tracks URIs
  var recommendedTracksUris = recommendedTracksObj["tracks"].map((track) => track["uri"]).toList();
  
  // Creates playlist and gets its ID
  String playlistId = await createPlaylist(authToken, await getUserId(authToken));
  
  var response = await _dio.post(
    "/playlists/$playlistId/tracks",
    data: jsonEncode({ "uris": recommendedTracksUris }),
    options: Options(
      headers: {"Authorization": "Bearer $authToken"},
    )
  );

  return response.data;
}