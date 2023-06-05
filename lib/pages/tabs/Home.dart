// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../services/ScreenAdapter.dart';
import '../../model/MovieModel.dart';
import '../../config/Config.dart';
import '../../widget/CustomImage.dart';
import '../../http/api/moveApi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 保持页面状态
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Map<String, List> movieLists = {
    '_swiperMovieList': [],
    '_recMovieList': [],
    '_lastMovieList': [],
    '_hotPlayMovieList': []
  };
  // final ApiService apiService = ApiService();
  final MovieApi movieApi = MovieApi();
  @override
  void initState() {
    super.initState();
    _getSwiperMovieData();
    _getRecMovieData();
    _getLastMovieData();
    _getHotPlayMovieData();
  }

  _setMovieList(result, setListName) {
    var movieData =
        MovieModel.fromJson((result['data']) as Map<String, dynamic>);
    setState(() {
      movieLists[setListName] = movieData.records ?? [];
    });
  }

  // 获取轮播电影数据
  _getSwiperMovieData() async {
    // Map<String, dynamic> queryParameters = {
    //   "carousel": true,
    //   "current": 1,
    //   "size": 4
    // };
    var result = await movieApi
        .getMovie(queryParameters: {"carousel": true, "current": 1, "size": 4});
    _setMovieList(result, '_swiperMovieList');
  }

  // 获取推荐电影
  _getRecMovieData() async {
    var result = await movieApi.getMovie(
        queryParameters: {"recommended": true, "current": 1, "size": 4});
    _setMovieList(result, '_recMovieList');
  }

  // 获取最新电影
  _getLastMovieData() async {
    var result = await movieApi
        .getMovie(queryParameters: {"current": 1, "size": 5, "sort": 1});
    _setMovieList(result, '_lastMovieList');
  }

  // 获取最新电影
  _getHotPlayMovieData() async {
    var result = await movieApi
        .getMovie(queryParameters: {"current": 1, "size": 5, "sort": 2});
    _setMovieList(result, '_hotPlayMovieList');
  }

  // 轮播图
  Widget _swiperWidget() {
    List<Map> imgList = movieLists['_swiperMovieList']!.map((itemMovie) {
      var diskName = itemMovie.disk.substring(0, 1);
      var url = '${Config.resorceBaseUrl}/$diskName/${itemMovie.image}';
      return {"url": url};
    }).toList();
    print(imgList);
    return Container(
      child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return CustomImage(
                url: imgList[index]['url'],
                fit: BoxFit.fill,
              );
            },
            itemCount: imgList.length,
            pagination: const SwiperPagination(),
          )),
    );
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(10)),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.red, width: 4))),
      child: Text(
        value,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  // 推荐商品
  Widget _hotRecProductList() {
    var recMovieList = movieLists['_recMovieList'];
    return Container(
      width: double.infinity,
      height: ScreenAdapter.height(240),
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Widget widgetShow = const Text('加载中...');
          if (recMovieList.isNotEmpty) {
            var currentMovie = recMovieList[index];
            var diskName = currentMovie.disk.substring(0, 1);
            var pic =
                '${Config.resorceBaseUrl}/$diskName/${currentMovie.image}';
            widgetShow = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: ScreenAdapter.height(140),
                  width: ScreenAdapter.width(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                  child: CustomImage(url: pic, fit: BoxFit.contain),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: ScreenAdapter.width(10),
                        right: ScreenAdapter.width(10)),
                    height: ScreenAdapter.height(44),
                    width: ScreenAdapter.width(140),
                    child: Text(currentMovie.title.trim(),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: ScreenAdapter.width(20))))
              ],
            );
          }
          return widgetShow;
        },
        itemCount: recMovieList!.length,
      ),
    );
  }

  Widget _singleProductWidget(itemMovie) {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 35) / 2;
    var diskName = itemMovie.disk.substring(0, 1);
    var pic = '${Config.resorceBaseUrl}/$diskName/${itemMovie.image}';
    return Container(
      width: itemWidth,
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              // height: ScreenAdapter.height(200),
              child: AspectRatio(
                // 防止服务器返回的的图片大小不一样，导致高度不一致
                aspectRatio: 1 / 1,
                child: CustomImage(
                  url: pic,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Text(
              itemMovie.remark,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: const Stack(children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '￥132.00',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '￥132.00',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      decoration: TextDecoration.lineThrough),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _prodectListWidget(MovieList) {
    return Container(
      padding: EdgeInsets.all(ScreenAdapter.width(20)),
      child: Wrap(
        runSpacing: 10, // 垂直间距
        spacing: 10, // 水平间距
        children: MovieList!
            .map<Widget>((itemMovie) => _singleProductWidget(itemMovie))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(
          height: ScreenAdapter.height(20),
        ),
        _titleWidget('热门推荐'),
        SizedBox(
          height: ScreenAdapter.height(20),
        ),
        _hotRecProductList(),
        SizedBox(
          height: ScreenAdapter.height(20),
        ),
        _titleWidget('热播电影'),
        _prodectListWidget(movieLists['_hotPlayMovieList']),
        SizedBox(
          height: ScreenAdapter.height(20),
        ),
        _titleWidget('最新电影'),
        _prodectListWidget(movieLists['_lastMovieList'])
      ],
    );
  }
}
