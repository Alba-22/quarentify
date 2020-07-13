class TopTracksModel {
  List<Items> items;
  int total;
  int limit;
  int offset;
  String href;
  dynamic previous;
  String next;

  TopTracksModel(
      {this.items,
      this.total,
      this.limit,
      this.offset,
      this.href,
      this.previous,
      this.next});

  TopTracksModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    total = json['total'];
    limit = json['limit'];
    offset = json['offset'];
    href = json['href'];
    previous = json['previous'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['href'] = this.href;
    data['previous'] = this.previous;
    data['next'] = this.next;
    return data;
  }
}

class Items {
  Album album;
  List<Artists> artists;
  List<String> availableMarkets;
  int discNumber;
  int durationMs;
  bool explicit;
  ExternalIds externalIds;
  ExternalUrls externalUrls;
  String href;
  String id;
  bool isLocal;
  String name;
  int popularity;
  String previewUrl;
  int trackNumber;
  String type;
  String uri;

  Items(
      {this.album,
      this.artists,
      this.availableMarkets,
      this.discNumber,
      this.durationMs,
      this.explicit,
      this.externalIds,
      this.externalUrls,
      this.href,
      this.id,
      this.isLocal,
      this.name,
      this.popularity,
      this.previewUrl,
      this.trackNumber,
      this.type,
      this.uri});

  Items.fromJson(Map<String, dynamic> json) {
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    availableMarkets = json['available_markets'].cast<String>();
    discNumber = json['disc_number'];
    durationMs = json['duration_ms'];
    explicit = json['explicit'];
    externalIds = json['external_ids'] != null
        ? new ExternalIds.fromJson(json['external_ids'])
        : null;
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    isLocal = json['is_local'];
    name = json['name'];
    popularity = json['popularity'];
    previewUrl = json['preview_url'];
    trackNumber = json['track_number'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.album != null) {
      data['album'] = this.album.toJson();
    }
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['available_markets'] = this.availableMarkets;
    data['disc_number'] = this.discNumber;
    data['duration_ms'] = this.durationMs;
    data['explicit'] = this.explicit;
    if (this.externalIds != null) {
      data['external_ids'] = this.externalIds.toJson();
    }
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['is_local'] = this.isLocal;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['preview_url'] = this.previewUrl;
    data['track_number'] = this.trackNumber;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Album {
  String albumType;
  List<Artists> artists;
  List<String> availableMarkets;
  ExternalUrls externalUrls;
  String href;
  String id;
  List<Images> images;
  String name;
  String releaseDate;
  String releaseDatePrecision;
  int totalTracks;
  String type;
  String uri;

  Album(
      {this.albumType,
      this.artists,
      this.availableMarkets,
      this.externalUrls,
      this.href,
      this.id,
      this.images,
      this.name,
      this.releaseDate,
      this.releaseDatePrecision,
      this.totalTracks,
      this.type,
      this.uri});

  Album.fromJson(Map<String, dynamic> json) {
    albumType = json['album_type'];
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    availableMarkets = json['available_markets'].cast<String>();
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    name = json['name'];
    releaseDate = json['release_date'];
    releaseDatePrecision = json['release_date_precision'];
    totalTracks = json['total_tracks'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['album_type'] = this.albumType;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    data['available_markets'] = this.availableMarkets;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['release_date'] = this.releaseDate;
    data['release_date_precision'] = this.releaseDatePrecision;
    data['total_tracks'] = this.totalTracks;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Artists {
  ExternalUrls externalUrls;
  String href;
  String id;
  String name;
  String type;
  String uri;

  Artists(
      {this.externalUrls, this.href, this.id, this.name, this.type, this.uri});

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['name'] = this.name;
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

class ExternalIds {
  String isrc;

  ExternalIds({this.isrc});

  ExternalIds.fromJson(Map<String, dynamic> json) {
    isrc = json['isrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isrc'] = this.isrc;
    return data;
  }
}
