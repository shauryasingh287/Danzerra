import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'dart:async';

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

import 'package:video_player/video_player.dart';
import 'package:meedu_player/meedu_player.dart';
import 'package:social_app_ui/bndbox.dart';

class HomeDancePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomeDancePage(this.cameras);

  @override
  _HomeDancePageState createState() => new _HomeDancePageState();
}

int score = 0;
int total = 0;
bool start = false;

class _HomeDancePageState extends State<HomeDancePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  // FlickManager flickManager;
  final _meeduPlayerController = MeeduPlayerController();
  @override
  void initState() {
    super.initState();
    _meeduPlayerController.setDataSource(
      DataSource(
        type: DataSourceType.asset,
        source: "assets/dance.mp4",
      ),
      autoplay: true,
    );
  }

  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  void dispose() {
    // flickManager.dispose();
    super.dispose();
  }

  bool free = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    Random random = new Random();
    const oneSec = const Duration(seconds: 7);
    return Scaffold(
      backgroundColor: const Color(0xffF95E0E),
      body: _model == ""
          ? (Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: const Text(
                      'Start Dancing',
                      style: TextStyle(fontSize: 24, fontFamily: 'Playfair'),
                    ),
                    onPressed: () => setState(() {
                      onSelect(posenet);
                      new Timer.periodic(
                          oneSec,
                          (Timer t) => setState(() {
                                if (active) {
                                  score = random.nextInt(20) * 10;
                                  total += score;
                                  score = 0;
                                }
                              }));
                    }),
                  ),
                  RaisedButton(
                    child: const Text(
                      'Freestyle',
                      style: TextStyle(fontSize: 24, fontFamily: 'Playfair'),
                    ),
                    onPressed: () => setState(() {
                      free = true;

                      onSelect(posenet);
                    }),
                  ),
                  RaisedButton(
                    child: const Text(
                      'Go back',
                      style: TextStyle(fontSize: 24, fontFamily: 'Playfair'),
                    ),
                    onPressed: () => setState(() {
                      Navigator.pop(context);
                    }),
                  ),
                ],
              ),
            ))
          : free
              ? (Stack(
                  children: [
                    Camera(
                      widget.cameras,
                      _model,
                      setRecognitions,
                    ),
                    BndBox(
                        _recognitions == null ? [] : _recognitions,
                        math.max(_imageHeight, _imageWidth),
                        math.min(_imageHeight, _imageWidth),
                        screen.height,
                        screen.width,
                        _model),
                  ],
                ))
              : Container(
                  //         color: Color(0xffF95E0E),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        height: 240,
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: MeeduVideoPlayer(
                            controller: _meeduPlayerController,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 225,
                      ),
                      Transform.scale(
                        alignment: Alignment.topRight,
                        scale: 0.6,
                        child: Container(
                          height: 40,
                          child: Stack(
                            children: [
                              Camera(
                                widget.cameras,
                                _model,
                                setRecognitions,
                              ),
                              BndBox(
                                  _recognitions == null ? [] : _recognitions,
                                  math.max(_imageHeight, _imageWidth),
                                  math.min(_imageHeight, _imageWidth),
                                  screen.height,
                                  screen.width,
                                  _model),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 120,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Score: $total',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blue.shade200,
                              //backgroundColor: Colors.white,
                            ),
                          ),
                          score > 100
                              ? Text(
                                  "Good",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green.shade100,
                                    //      backgroundColor: Colors.white,
                                  ),
                                )
                              : Text(
                                  "Need to step up",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red.shade100,
                                    //  backgroundColor: Colors.white,
                                  ),
                                ),
                          active
                              ? Text(
                                  "Player Detected",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green.shade100,
                                    //        backgroundColor: Colors.white,
                                  ),
                                )
                              : Text(
                                  "No Player Detected",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red.shade100,
                                    //        backgroundColor: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        width: 400,
                      ),
                    ],
                  ),
                ),
    );
  }
}
