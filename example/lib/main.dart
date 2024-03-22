import 'package:umeng_apm_sdk/umeng_apm_sdk.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';
import 'package:flutter/material.dart';
import './pages/exception.dart';
import './pages/white_screen.dart';
import './pages/lazy_load_page.dart';
import './pages/list.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => HomePage(),
  "/exception": (context) => ExceptionPage(),
  "/white_screen": (context) => WhiteScreenPage(),
  "/list": (context) => ListPage(),
  "/lazy_load": (context) => ScrollLazyLoadPage(),
};

void main() {
  final UmengApmSdk umengApmSdk = UmengApmSdk(
    name: '',
    bver: '',
    flutterVersion: '3.10.0',
    engineVersion: 'd44b5a94c9',
    enableLog: true,
    enableTrackingPageFps: true,
    enableTrackingPagePerf: true,
    errorFilter: {
      "mode": "ignore",
      // "rules": [RegExp('RangeError')],
      "rules": [],
    },
    initFlutterBinding: MyApmWidgetsFlutterBinding.ensureInitialized,
    // onError: (exception, stack) {},
  );

  umengApmSdk.init(appRunner: (observer) async {
    // 确保去掉原有的WidgetsFlutterBinding.ensureInitialized() ，以免出现重复初始化绑定的异常造成无法正常初始化，
    // SDK内部已通过initFlutterBinding入参带入继承的WidgetsFlutterBinding实现初始化操作
    // 依赖ensureInitialized()初始化的代码可在此调用
    // 需要异步获取设置应用名称和版本号可在此回调中操作
    // SDK实例化的设置可先将name和bver 为 "",然后通过以下方式进行设置
    // 如：umengApmSdk.name = 'app_demo';
    umengApmSdk.name = 'app_demo';
    umengApmSdk.bver = '1.0.0+9';
    return MyApp(observer);
  });
}

class MyApmWidgetsFlutterBinding extends ApmWidgetsFlutterBinding {
  @override
  void handleAppLifecycleStateChanged(AppLifecycleState state) {
    // 添加自己的实现逻辑
    // print('AppLifecycleState changed to $state');
    super.handleAppLifecycleStateChanged(state);
  }

  static WidgetsBinding? ensureInitialized() {
    MyApmWidgetsFlutterBinding();
    return WidgetsBinding.instance;
  }
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp([this._navigatorObserver]);

  NavigatorObserver? _navigatorObserver;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      initialRoute: "/",
      navigatorObservers: <NavigatorObserver>[
        _navigatorObserver ?? ApmNavigatorObserver.singleInstance
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class CustomTransitionPage extends PageRouteBuilder {
  final Widget widget;

  CustomTransitionPage({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            Animation<Offset> customAnimation = Tween<Offset>(
              begin: Offset(3.0, 0.0),
              end: Offset.zero,
            ).animate(animation);

            return SlideTransition(
              position: customAnimation,
              child: child,
            );
          },
        );
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    UmengCommonSdk.initCommon(
        '6521276cd94a131a1ae7ab1f', '6521029cd94a131a1ae7aac3', 'Umeng');
    UmengCommonSdk.setPageCollectionModeManual();
  }

  void runCustomException() {
    try {
      // 模拟数组越界错误
      List<String> numList = ['1', '2'];
      print(numList[5]);
    } catch (e) {
      ExceptionTrace.captureException(
          exception: Exception(e), extra: {"user": '123'});
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("AlertDialog Title"),
          content: Text("AlertDialog Body"),
          actions: <Widget>[
            TextButton(
              child: Text("CANCEL"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  child: Text('dart error page'),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/exception');
                  }),
              TextButton(
                  child: Text('dart error new page'),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExceptionPage()));
                  }),
              TextButton(
                  child: Text('Page Transition'),
                  onPressed: () async {
                    Navigator.of(context)
                        .push(CustomTransitionPage(widget: ExceptionPage()));
                  }),
              TextButton(
                  child: Text('dart error release page'),
                  onPressed: () async {
                    Navigator.of(context).pushReplacementNamed('/exception');
                  }),
              TextButton(
                child: Text("Show Dialog"),
                onPressed: _showDialog,
              ),
              TextButton(
                  child: Text("dart white screen exception"),
                  onPressed: () async {
                    Navigator.of(context).pushReplacementNamed('/white_screen');
                  }),
              TextButton(
                  child: Text("lazy loading text list"),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/list');
                  }),
              TextButton(
                  child: Text("lazy loading picture list"),
                  onPressed: () async {
                    Navigator.pushNamed(context, '/lazy_load');
                  }),
              TextButton(
                  child: Text("捕获主动上报 exception"),
                  onPressed: () {
                    runCustomException();
                  }),
            ]),
      ),
    );
  }
}
