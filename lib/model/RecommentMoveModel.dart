class RecommentMoveModel {
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

  RecommentMoveModel(
      {this.records,
      this.total,
      this.size,
      this.current,
      this.orders,
      this.optimizeCountSql,
      this.searchCount,
      this.countId,
      this.maxLimit,
      this.pages});

  RecommentMoveModel.fromJson(Map<String, dynamic> json) {
    print('238402984092384092384${json}283048290384092384902384023984');
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['current'] = this.current;
    if (this.orders != null) {
      data['orders'] = this.orders;
    }
    data['optimizeCountSql'] = this.optimizeCountSql;
    data['searchCount'] = this.searchCount;
    data['countId'] = this.countId;
    data['maxLimit'] = this.maxLimit;
    data['pages'] = this.pages;
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
      {this.id,
      this.categoryId,
      this.recommended,
      this.carousel,
      this.num,
      this.title,
      this.disk,
      this.banner,
      this.image,
      this.file,
      this.remark});

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['recommended'] = this.recommended;
    data['carousel'] = this.carousel;
    data['num'] = this.num;
    data['title'] = this.title;
    data['disk'] = this.disk;
    data['banner'] = this.banner;
    data['image'] = this.image;
    data['file'] = this.file;
    data['remark'] = this.remark;
    return data;
  }
}
