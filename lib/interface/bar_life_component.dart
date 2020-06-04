import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/game_interface/interface_component.dart';
import 'package:flutter/material.dart';

class BarLifeComponent extends InterfaceComponent {
  double padding = 20;
  double widthBar = 90;
  double strokeWidth = 12;

  double maxLife = 1;
  double life = 0;

  BarLifeComponent()
      : super(
          id: 1,
          position: Position(20, 20),
          sprite: Sprite('health_ui.png'),
          width: 120,
          height: 40,
        );

  @override
  void update(double t) {
    if (this.gameRef.player != null) {
      life = this?.gameRef?.player?.life ?? 0;
      maxLife = this?.gameRef?.player?.maxLife ?? 1;
    }
    super.update(t);
  }

  @override
  void render(Canvas c) {
    _drawLife(c);
    super.render(c);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 48;
    double yBar = 31.5;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
