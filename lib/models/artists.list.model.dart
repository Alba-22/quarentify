class ArtistsListModel {
  List<Artists> artists;

  ArtistsListModel({this.artists});

  ArtistsListModel.fromJson(Map<String, dynamic> json) {
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artists {
  ExternalUrls externalUrls;
  Followers followers;
  List<String> genres;
  String href;
  String id;
  List<Images> images;
  String name;
  int popularity;
  String type;
  String uri;

  Artists(
      {this.externalUrls,
      this.followers,
      this.genres,
      this.href,
      this.id,
      this.images,
      this.name,
      this.popularity,
      this.type,
      this.uri});

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    followers = json['followers'] != null
        ? new Followers.fromJson(json['followers'])
        : null;
    genres = json['genres'].cast<String>();
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    name = json['name'];
    popularity = json['popularity'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls.toJson();
    }
    if (this.followers != null) {
      data['followers'] = this.followers.toJson();
    }
    data['genres'] = this.genres;
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class ExternalUrls {
  String spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this.spotify;
    return data;
  }
}

class Followers {
  Null href;
  int total;

  Followers({this.href, this.total});

  Followers.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['total'] = this.total;
    return data;
  }
}

class Images {
  int height;
  String url;
  int width;

  Images({this.height, this.url, this.width});

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}
