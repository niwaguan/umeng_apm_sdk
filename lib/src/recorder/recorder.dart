import 'package:umeng_apm_sdk/src/recorder/page_fps_recorder.dart';
import 'package:umeng_apm_sdk/src/recorder/page_perf_recorder.dart';

class ApmRecorder {
  ApmRecorder();

  static void init() {
    PagePerfRecorder();
    PageFpsRecorder();
  }
}
