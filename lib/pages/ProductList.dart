import 'package:flutter/material.dart';
import '../services/ScreenAdapter.dart';
import '../widget/CustomImage.dart';
import '../../api/ApiService.dart';
import '../../config/Config.dart';
import '../../model/MovieModel.dart';
import '../widget/LoadingWidget.dart';

class ProductListPage extends StatefulWidget {
  final Map? arguments; // 声明为可空类型

  const ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ApiService apiService = ApiService();
  // 用于上拉分页
  ScrollController _scrollController = ScrollController();
  // 数据
  final _productList = [];
  // 分页
  int currentPage = 1;
  int pageSize = 10;
  // 解决重复请求的问题
  bool flag = true;
  // 是否有数据
  bool hasData = true;
  // 排序
  // 初始化生命周期会调用的函数
  @override
  void initState() {
    super.initState();
    _getProductList();
    // 监听滚动条滚动事件
    _scrollController.addListener(() {
      //  _scrollController.position.pixels // 获取滚动条滚动的高度
      // _scrollController.position.maxScrollExtent // 获取最大页面高度
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (flag && hasData) {
          _getProductList();
        }
      }
    });
  }

  // 获取商品列表的数据
  _getProductList({dynamic categoryId = '', sort = ''}) async {
    var cid = widget.arguments != null && widget.arguments!['cid'] != null
        ? widget.arguments!['cid']
        : '';
    Map<String, dynamic> categoryParams = {
      "movie": true,
      "categoryId": categoryId != '' ? categoryId : cid,
      "current": currentPage,
      "size": pageSize,
      "sort": sort
    };
    setState(() {
      flag = false;
    });
    var result = await apiService.get('${Config.baseApi}/movie/page',
        queryParameters: categoryParams);
    var productData = MovieModel.fromJson(result.data['data']);
    var listData = productData.records ?? [];
    if (listData.length < pageSize) {
      setState(() {
        hasData = false;
      });
    }
    setState(() {
      _productList.addAll(listData);
      currentPage++;
      flag = true;
      if (pageSize < 1) {
        pageSize = productData.size!;
      }
    });
  }

  Widget _showMore(index) {
    Widget widgetShow;
    if (hasData) {
      widgetShow = LoadingWidget();
    } else {
      widgetShow = Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Text('我是有底线的'),
      );
    }
    if (index != _productList.length - 1) {
      widgetShow = Text('');
    }
    return widgetShow;
  }

  Widget _prodectListWidget() {
    if (_productList.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            controller: _scrollController,
            itemCount: _productList.length,
            itemBuilder: (context, index) {
              var currentMovie = _productList[index];
              var diskName = currentMovie.disk!.substring(0, 1);
              var pic =
                  '${Config.resorceBaseUrl}/$diskName/${currentMovie.image}';
              return Column(
                // 每个元素
                children: [
                  Row(
                    children: [
                      Container(
                        width: ScreenAdapter.width(180),
                        height: ScreenAdapter.height(180),
                        child: CustomImage(
                          url: pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            height: ScreenAdapter.height(180),
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentMovie.title!.trim(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: ScreenAdapter.height(36),
                                      margin: EdgeInsets.only(right: 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // 注意 如果Container里面加上decoration属性，这个时候color必须放在decoration里面
                                          color: Color.fromRGBO(
                                              230, 230, 230, 0.9)),
                                      child: Text("4g"),
                                    ),
                                    Container(
                                      height: ScreenAdapter.height(36),
                                      margin: EdgeInsets.only(right: 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // 注意 如果Container里面加上decoration属性，这个时候color必须放在decoration里面
                                          color: Color.fromRGBO(
                                              230, 230, 230, 0.9)),
                                      child: Text("256"),
                                    )
                                  ],
                                ),
                                Text(
                                  '￥999',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              ],
                            ),
                          ))
                    ],
                  ), // 使用flex布局
                  Divider(
                    height: 20,
                  ),
                  _showMore(index)
                ],
              );
            }),
      );
    } else {
      // 加载中
      return LoadingWidget();
    }
  }

  // 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
        top: 0,
        height: ScreenAdapter.height(80),
        width: ScreenAdapter.width(750),
        child: Container(
          height: ScreenAdapter.height(80),
          width: ScreenAdapter.width(750),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                    onTap: () {
                      // 回到页面顶部
                      _scrollController.jumpTo(0);
                    },
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            ScreenAdapter.height(16),
                            0,
                            ScreenAdapter.height(16)),
                        child: Text(
                          "综合",
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ))),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ScreenAdapter.height(16),
                              0,
                              ScreenAdapter.height(16)),
                          child: Text(
                            "销量",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          )))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {},
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ScreenAdapter.height(16),
                              0,
                              ScreenAdapter.height(16)),
                          child: Text(
                            "价格",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          )))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              ScreenAdapter.height(16),
                              0,
                              ScreenAdapter.height(16)),
                          child: Text(
                            "筛选",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ))))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("商品列表"),
          actions: [Text('')],
        ),
        endDrawer: Drawer(
          child: Container(
            child: Text('实现筛选功能'),
          ),
        ),
        body: Stack(
          children: [_prodectListWidget(), _subHeaderWidget()],
        ));
  }
}
