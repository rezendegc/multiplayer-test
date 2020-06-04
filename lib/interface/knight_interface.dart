import 'dart:ui';

import 'package:bonfire/util/game_interface/game_interface.dart';
import 'package:flutter/material.dart';
import 'package:humerus/interface/bar_life_component.dart';

class KnightInterface extends GameInterface {
  @override
  void resize(Size size) {
    add(BarLifeComponent());
    super.resize(size);
  }
}
