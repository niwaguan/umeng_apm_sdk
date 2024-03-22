import 'package:flutter/material.dart';
import 'package:umeng_apm_sdk/umeng_apm_sdk.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  ScrollController _scrollController = ApmScrollController();
  List<int> _dataList = List.generate(20, (index) => index); // 初始数据列表
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // 到达列表底部
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });

      // 模拟异步加载数据
      await Future.delayed(Duration(seconds: 2));
      try {
        setState(() {
          _dataList
              .addAll(List.generate(10, (index) => index + _dataList.length));
          _isLoading = false;
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazy Loading List'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _dataList.length + 1,
        itemBuilder: (context, index) {
          if (index < _dataList.length) {
            return ListTile(
              title: Text('Item ${_dataList[index]}'),
            );
          } else {
            // 显示加载指示器
            return _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container();
          }
        },
      ),
    );
  }
}
