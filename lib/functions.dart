import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

getAuthToken() {
  var tokenStart = window.location.href.indexOf("access_token=");
  if (tokenStart == -1) {
    window.location.href = window.location.origin;
  }
  tokenStart += 13;
  var tokenEnd = window.location.href.indexOf("&");
  return window.location.href.substring(tokenStart, tokenEnd);
}

getTopRead(type, authToken) async {
  var topRead = await http.get("https://api.spotify.com/v1/me/top/$type",
      headers: {"Authorization": "Bearer $authToken"});
  if (topRead.statusCode != 200) window.alert(topRead.body);
  return json.decode(topRead.body);
}
 
