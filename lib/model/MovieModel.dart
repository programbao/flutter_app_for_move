class MovieModel {
  List<Records>? records;
  int? total;
  int? size;
  int? current;
  List<Null>? orders;
  bool? optimizeCountSql;
  bool? searchCount;
  Null? countId;
  Null? maxLimit;
  int? pages;

  MovieModel(
      {records,
      total,
      size,
      current,
      orders,
      optimizeCountSql,
      searchCount,
      countId,
      maxLimit,
      pages});

  MovieModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(Records.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    if (json['orders'] != null) {
      orders = <Null>[];
      json['orders'].forEach((v) {
        // orders!.add(Null.fromJson(v));
      });
    }
    optimizeCountSql = json['optimizeCountSql'];
    searchCount = json['searchCount'];
    countId = json['countId'];
    maxLimit = json['maxLimit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (records != null) {
      data['records'] = records!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['size'] = size;
    data['current'] = current;
    if (orders != null) {
      data['orders'] = orders;
    }
    data['optimizeCountSql'] = optimizeCountSql;
    data['searchCount'] = searchCount;
    data['countId'] = countId;
    data['maxLimit'] = maxLimit;
    data['pages'] = pages;
    return data;
  }
}

class Records {
  int? id;
  int? categoryId;
  bool? recommended;
  bool? carousel;
  int? num;
  String? title;
  String? disk;
  String? banner;
  String? image;
  String? file;
  String? remark;

  Records(
      {id,
      categoryId,
      recommended,
      carousel,
      // ignore: avoid_types_as_parameter_names
      num,
      title,
      disk,
      banner,
      image,
      file,
      remark});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    recommended = json['recommended'];
    carousel = json['carousel'];
    num = json['num'];
    title = json['title'];
    disk = json['disk'];
    banner = json['banner'];
    image = json['image'];
    file = json['file'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['recommended'] = recommended;
    data['carousel'] = carousel;
    data['num'] = num;
    data['title'] = title;
    data['disk'] = disk;
    data['banner'] = banner;
    data['image'] = image;
    data['file'] = file;
    data['remark'] = remark;
    return data;
  }
}
