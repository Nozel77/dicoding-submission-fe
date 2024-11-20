class AnimeModel {
  int? statusCode;
  String? message;
  List<Anime>? data;

  AnimeModel({this.statusCode, this.message, this.data});

  AnimeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Anime>[];
      json['data'].forEach((v) {
        data!.add(new Anime.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Anime {
  int? id;
  String? title;
  String? image;
  String? genre;
  String? rating;
  String? studio;
  String? status;
  String? type;
  String? episodes;
  String? duration;
  String? synopsis;
  bool? isLiked;

  Anime(
      {this.id,
        this.title,
        this.image,
        this.genre,
        this.rating,
        this.studio,
        this.status,
        this.type,
        this.episodes,
        this.duration,
        this.synopsis,
        this.isLiked});

  Anime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    genre = json['genre'];
    rating = json['rating'];
    studio = json['studio'];
    status = json['status'];
    type = json['type'];
    episodes = json['episodes'];
    duration = json['duration'];
    synopsis = json['synopsis'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['genre'] = this.genre;
    data['rating'] = this.rating;
    data['studio'] = this.studio;
    data['status'] = this.status;
    data['type'] = this.type;
    data['episodes'] = this.episodes;
    data['duration'] = this.duration;
    data['synopsis'] = this.synopsis;
    data['isLiked'] = this.isLiked;
    return data;
  }
}
