import 'package:get/get.dart';

import '../controllers/tugas1_controller.dart';

class Tugas1Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Tugas1Controller>(
      () => Tugas1Controller(),
    );
  }
}
