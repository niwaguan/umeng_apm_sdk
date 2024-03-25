import 'dart:async';

import 'package:flutter/widgets.dart';

typedef PlatformDispatcherErrorHandler = bool Function(Object, dynamic);
typedef AppRunner = FutureOr<Widget> Function(NavigatorObserver);
typedef AppRunnerHook = FutureOr<void> Function();
typedef InitFlutterBinding = void Function();
typedef OnError = void Function(Object, dynamic);
