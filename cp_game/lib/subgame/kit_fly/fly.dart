import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'game.dart';

class Fly{
  final KitFlyGame game;
  Rect flyRect;
  Paint flyPaint;
  bool isDead = false;
  bool isOffScreen = false;

  Fly(this.game, double x, double y){
    flyRect = Rect.fromLTWH(x, y, game.flySize, game.flySize);
    flyPaint = Paint();
    flyPaint.color = Color(0xff7ea00e);
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    canvas.drawRect(flyRect, flyPaint);
  }

  @override
  void update(double t) {
    // TODO: implement update
    if (isDead) {
      flyRect = flyRect.translate(0, game.flySize * 5 * t);
      // 记录是否已经掉出屏幕范围
      if (flyRect.top > game.screenSize.height) {
        isOffScreen = true;
      }
    }
  }

  void onTapDown(TapDownDetails d) {
    isDead = true;
    flyPaint.color = Color(0xfffa897b);
    game.spawnFly();
  }
}