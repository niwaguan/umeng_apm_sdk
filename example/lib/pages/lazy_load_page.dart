import 'package:flutter/material.dart';
import 'package:umeng_apm_sdk/umeng_apm_sdk.dart';

class ScrollLazyLoadPage extends StatefulWidget {
  @override
  _ScrollLazyLoadPageState createState() => _ScrollLazyLoadPageState();
}

class _ScrollLazyLoadPageState extends State<ScrollLazyLoadPage> {
  List<String> imageUrls = [];
  int page = 1;
  ScrollController _scrollController = ApmScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
  }

  Future<void> fetchData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Simulating a delay of 2 seconds
      await Future.delayed(Duration(seconds: 2));

      final List<String> urls = [
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
        'https://img.zcool.cn/community/01jz5vsgfkgclicuhmruvn3633.jpg',
      ];
      try {
        setState(() {
          imageUrls.addAll(urls);
          isLoading = false;
        });
      } catch (e) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Lazy Load Demo'),
      ),
      body: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: imageUrls.length + 1,
        itemBuilder: (context, index) {
          if (index == imageUrls.length) {
            return Center(
              child:
                  isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
            );
          }
          return Card(
            child: Image.network(
              imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
