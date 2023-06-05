import 'package:flutter/material.dart';
import '../utils/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.height(60),
          padding: const EdgeInsets.only(left: 10, bottom: 3),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              print('点击搜索');
            },
            child: Container(
              height: ScreenAdapter.height(60),
              width: ScreenAdapter.width(80),
              child: Row(
                children: [Text('搜索')],
              ),
            ),
          )
        ],
      ),
      body: Text('搜索'),
    );
  }
}
