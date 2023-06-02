class MovieCategoryModel {
  Object? id;
  String? name;
  Null? movie;
  Null? tv;

  MovieCategoryModel({this.id, this.name, this.movie, this.tv});

  MovieCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    // ignore: void_checks
    movie = json['movie'];
    // ignore: void_checks
    tv = json['tv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['movie'] = movie;
    data['tv'] = tv;
    return data;
  }
}
