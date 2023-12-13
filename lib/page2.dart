import 'dart:async';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:stopwatch/all_controller.dart';
import 'package:audioplayers/audioplayers.dart';

class Page2 extends StatelessWidget {
  Page2({Key? key}) : super(key: key);

  final allController = Get.put(AllController());
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('Break Time',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 22
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Text("Take a five-minute break to check in on your level of fullness",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 17,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Stack(
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    shape: BoxShape.circle
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    // height: 220,
                    // width: 220,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
              ),
              Positioned(left: 0, right: 0, top: 35, bottom: 35,
                child: CircularCountDownTimer(
                  onStart: () {
                    Timer.periodic(Duration(seconds: 1), (timer) {
                      String? remainingTime =
                      allController.countDownController.getTime();
                      if (remainingTime != null) {
                        List<String> timeParts = remainingTime.split(':');
                        int minutes = int.parse(timeParts[0]);
                        int seconds = int.parse(timeParts[1]);
                        int finalRemainingTime = minutes * 60 + seconds;
                        if (finalRemainingTime > 0 && finalRemainingTime <= 5) {
                          print('============');
                          print('REMAINING TIME: $finalRemainingTime');
                          // final player = AudioPlayer();
                          audioPlayer.play(AssetSource('beepwav.wav'));
                        }
                      }
                    });
                  },

                  controller: allController.countDownController,
                  width: 100,
                  height: 100,
                  duration: allController.duration,
                  initialDuration: 0,
                  strokeWidth: 10,
                  strokeCap: StrokeCap.round,
                  fillColor: Colors.green,
                  ringColor: Colors.white,
                  backgroundColor: Colors.white,
                  isReverse: true,
                  autoStart: false,
                  isReverseAnimation: true,
                  textFormat: CountdownTextFormat.MM_SS,
                  textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const Positioned(bottom: 80, left: 65,
                  child: Text('minutes remaining', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16)))
            ],
          ),
          const SizedBox(height: 50),
          Obx(() => Switch(
            // activeColor: Colors.green,
              focusColor: Colors.blue,
              value: allController.isSoundOn2.value,
              onChanged: (bool? value) async {
                allController.isSoundOn2.value = value!;
                allController.isSoundOff2.value = value;
                allController.isSoundOn2.value?
                print('ON'):
                print('OFF');
                allController.isSoundOn2.value?
                audioPlayer.setVolume(1.0):
                audioPlayer.setVolume(0.0);
                // AudioManager.volumeController.getLevel(AudioVolumeType.none);
              }),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Obx(() => Text(allController.isSoundOn2.value == true?
            'Sound on' : 'Sound off',
              style: TextStyle(color: Colors.white, fontSize: 18),)),
          ),
          Obx(() => allController.isStart1.value == true?
          Column(
            children: [
              ElevatedButton(onPressed: (){
                allController.countDownController.pause();
              },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide.none
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFA5D6A7)),
                  minimumSize: MaterialStateProperty.all(const Size(500, 60)),

                ), child: const Text('PAUSE', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: (){
              },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.grey)
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                  minimumSize: MaterialStateProperty.all(const Size(500, 60)),

                ), child: const Text("LET'S STOP I'M FULL NOW", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w400),),
              )
            ],
          ):
          ElevatedButton(onPressed: (){
            allController.isStart1.value = true;
            allController.countDownController.start();
            print('TIMER STARTED');
          },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide.none
                ),
              ),
              backgroundColor: MaterialStateProperty.all(const Color(0xFFA5D6A7)),
              minimumSize: MaterialStateProperty.all(const Size(500, 60)),
            ),
            child: const Text('START', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),),
          ))
        ],
      ),
    );
  }
}
