// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/RecommentMoveModel.dart';
import 'dart:convert';
import '../../config/Config.dart';
import 'package:dio/dio.dart';
import '../../model/RecommentMoveModel.dart';
import '../../utils/CustomImage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _recMoveList = [];
  List _lastMoveList = [];
  final dio = Dio();
  @override
  void initState() {
    super.initState();
    _getRecMoveData();
    // _getLastMoveData();
  }

  // 异步请求接口数据
  _getRecMoveData() async {
    var result = await dio
        .get('${Config.baseApi}/movie/page?current=1&size=10&recommended=true');
    var recMoveData = RecommentMoveModel.fromJson(
        (result.data['data']) as Map<String, dynamic>);
    setState(() {
      _recMoveList = recMoveData.records ?? [];
    });
  }

  // 获取最新电影
  _getLastMoveData() async {
    var result =
        await dio.get('${Config.baseApi}/movie/page?current=1&size=4&sort=1');
  }

  // 轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {"url": 'https://via.placeholder.com/350x150'},
      {"url": 'https://via.placeholder.com/350x150'},
      {"url": 'https://via.placeholder.com/350x150'}
    ];
    return Container(
      child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                imgList[index]['url'],
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
      height: ScreenAdaper.height(32),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(10)),
      decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: Colors.red, width: 4))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget _hotProductList() {
    return Container(
      width: double.infinity,
      height: ScreenAdaper.height(240),
      padding: EdgeInsets.all(ScreenAdaper.width(20)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Widget widgetShow = const Text('加载中...');
          print(_recMoveList.length);
          if (_recMoveList.isNotEmpty) {
            var currentMove = _recMoveList[index];
            var pic = '${Config.resorceBaseUrl}/${currentMove.image}';
            widgetShow = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: ScreenAdaper.height(140),
                  width: ScreenAdaper.width(140),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(20)),
                  child: CustomImage(url: pic, fit: BoxFit.cover),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: ScreenAdaper.width(10),
                        right: ScreenAdaper.width(10)),
                    height: ScreenAdaper.height(44),
                    // width: ScreenAdaper.width(300),
                    child: Text(
                      '第${index}条',
                      textAlign: TextAlign.center,
                    ))
              ],
            );
          }
          return widgetShow;
        },
        itemCount: _recMoveList.length,
      ),
    );
  }

  // 推荐商品
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;
    return Container(
      width: itemWidth,
      padding: EdgeInsets.all(ScreenAdaper.width(20)),
      decoration: BoxDecoration(
          border:
              Border.all(color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              // height: ScreenAdaper.height(200),
              child: AspectRatio(
                // 防止服务器返回的的图片大小不一样，导致高度不一致
                aspectRatio: 1 / 1,
                child: Image.network(
                  'https://via.placeholder.com/350x150',
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: const Text(
              'ajofejio金佛王金娥佛额温计文件饿哦副机位哦if就加我额飞机我饿附件金额和佛我发',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
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

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(
          height: ScreenAdaper.height(20),
        ),
        _titleWidget('热门推荐'),
        SizedBox(
          height: ScreenAdaper.height(20),
        ),
        _hotProductList(),
        SizedBox(
          height: ScreenAdaper.height(20),
        ),
        _titleWidget('最新电影'),
        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10, // 垂直间距
            spacing: 10, // 水平间距
            children: [_recProductListWidget()],
          ),
        )
      ],
    );
  }
}
