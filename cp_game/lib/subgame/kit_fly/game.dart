import 'dart:math';
import 'dart:ui';

import 'package:cpgame/subgame/kit_fly/fly.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

class KitFlyGame extends Game {
  Size screenSize;
  double flySize;
  List<Fly> flies;
  Random rnd;

  KitFlyGame(){
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - flySize);
    double y = rnd.nextDouble() * (screenSize.height - flySize);
    flies.add(Fly(this, x, y));
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    // 背景
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff1f4f59);
    canvas.drawRect(bgRect, bgPaint);
    // 同时触发每个苍蝇的render
    flies.forEach((Fly fly) => fly.render(canvas));
  }

  @override
  void update(double t) {
    // TODO: implement update
    // 同时触发每个苍蝇的update
    flies.forEach((Fly fly) => fly.update(t));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
  }

  @override
  void resize(Size size) {
    // TODO: implement resize
    screenSize = size;
    flySize = screenSize.width / 9;
  }
  
  void onTapDown(TapDownDetails d) {
    Fly target;
    try{
      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          target= fly;
          throw 'find the target fly!';
        }
      });
    } catch (err) {
      target.onTapDown(d);
      print(err);
    }

  }

}