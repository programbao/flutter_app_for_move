import 'package:flutter/material.dart';
import '../../utils/ScreenAdapter.dart';
import '../../widget/CustomImage.dart';
import '../../config/Config.dart';
import '../../model/MovieCategoryModel.dart';
import '../../model/MovieModel.dart';
import '../../http/api/categoryApi.dart';
import '../../http/api/moveApi.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  // 保持页面状态
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  int _selectIndex = 0;
  final List _categoryList = [
    MovieCategoryModel.fromJson(
        {"id": '', "name": "全部类型", "movie": null, "tv": null})
  ];
  var _singleCategoryData = MovieModel();
  // final ApiService apiService = ApiService();
  final CategoryApi categoryApi = CategoryApi();
  final MovieApi movieApi = MovieApi();

  @override
  void initState() {
    super.initState();
    _getCategoryList();
  }

  // 获取分类类型数据
  Map<String, dynamic> categoryParams = {'movie': true};
  _getCategoryList() async {
    var result = await categoryApi.getCategory(queryParameters: categoryParams);
    var categoryList = result['data'].map((item) {
      return MovieCategoryModel.fromJson(item);
    }).toList();
    setState(() {
      _categoryList.addAll(categoryList);
    });
    _getSingleCategoryData();
  }

  // 获取当个分类数据
  _getSingleCategoryData({dynamic categoryId = ''}) async {
    Map<String, dynamic> categoryParams = {
      "movie": true,
      "categoryId": categoryId,
      "current": 1,
      "size": 20
    };
    var result = await movieApi.getMovie(queryParameters: categoryParams);
    var singleCategoryData = MovieModel.fromJson(result['data']);
    setState(() {
      _singleCategoryData = singleCategoryData;
    });
  }

  _movieListWidget(records, rightItemWidth, rightItemHeight) {
    Widget widgetPage = const Text(
      '暂无数据',
      textAlign: TextAlign.center,
    );
    if (records != null && records!.length > 0) {
      widgetPage = Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        color: const Color.fromRGBO(240, 246, 246, 0.9),
        child: ListView.builder(
          itemCount: (records.length / 3).ceil(),
          itemBuilder: (context, index) {
            var startIndex = index * 3;
            var endIndex = startIndex + 3;
            if (endIndex > records.length) {
              endIndex = records.length;
            }
            var gridItems = records
                .sublist(startIndex, endIndex)
                .map<Widget>((currentMovie) {
              var diskName = currentMovie.disk!.substring(0, 1);
              var pic =
                  '${Config.resorceBaseUrl}/$diskName/${currentMovie.image}';
              return InkWell(
                onTap: () {
                  print(currentMovie);
                  Navigator.pushNamed(context, '/productList',
                      arguments: {"cid": currentMovie.categoryId});
                },
                child: Container(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CustomImage(url: pic, fit: BoxFit.cover),
                      ),
                      Container(
                        height: ScreenAdapter.height(24),
                        child: Text(
                          currentMovie.title!.trim(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: ScreenAdapter.size(12)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList();
            return GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth / rightItemHeight,
              children: List<Widget>.from(gridItems),
            );
          },
        ),
      );
    }
    return Expanded(flex: 1, child: widgetPage);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    // 计算右侧GridView比例宽高比
    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    // 右侧宽度 = 总宽度 - GridView外侧原生左右的padding值 - GridView中间的间距
    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 30 - 30) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);
    // 分类电影数据
    var records = _singleCategoryData.records;
    return Row(
      children: [
        Container(
            width: 140,
            height: double.infinity, // 自适应高度
            // color: Colors.red,
            child: ListView.builder(
                itemCount: _categoryList.length,
                itemBuilder: (context, index) {
                  var itemCategory = _categoryList[index];
                  return Column(
                    children: [
                      InkWell(
                        // 可以当作按钮组件
                        onTap: () {
                          setState(() {
                            _selectIndex = index;
                          });
                          _getSingleCategoryData(categoryId: itemCategory.id);
                        },
                        child: Container(
                          width: double.infinity,
                          height: ScreenAdapter.height(42),
                          padding:
                              EdgeInsets.only(top: ScreenAdapter.height(12)),
                          color: _selectIndex == index
                              ? const Color.fromRGBO(240, 246, 246, 0.9)
                              : Colors.white,
                          child: Text(
                            itemCategory.name,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      )
                    ],
                  );
                }) // 列表要动态生产 要用builder
            ),
        _movieListWidget(records, rightItemWidth, rightItemHeight)
      ],
    );
  }
}
