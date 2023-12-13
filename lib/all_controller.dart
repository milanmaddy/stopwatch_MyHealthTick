import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:tizen_audio_manager/tizen_audio_manager.dart';

class AllController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // AudioManager.setVolume(isSoundOn ? 1.0 : 0.0);
  }

  var pageIndex = 0.obs;
  final PageController controller = PageController();
  var isStart1 = false.obs;
  final CountDownController countDownController = CountDownController();
  // final AudioPlayer audioPlayer = AudioPlayer();
  final duration = 30;
  var isSoundOn1 = true.obs;
  var isSoundOn2 = true.obs;
  var isSoundOn3 = true.obs;
  var isSoundOff1 = false.obs;
  var isSoundOff2 = false.obs;
  var isSoundOff3 = false.obs;
}