import 'dart:math';
import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:humerus/constants.dart';

class Knight extends SimplePlayer {
  final Position initPosition;
  double attack = 50;
  bool showObserveEnemy = false;
  bool showTalk = false;
  List<bool> movingDirections = [false, false, false, false];

  Knight(this.initPosition)
      : super(
          animIdleLeft: FlameAnimation.Animation.sequenced(
            "player/knight_idle_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animIdleRight: FlameAnimation.Animation.sequenced(
            "player/knight_idle.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunRight: FlameAnimation.Animation.sequenced(
            "player/knight_run.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          animRunLeft: FlameAnimation.Animation.sequenced(
            "player/knight_run_left.png",
            6,
            textureWidth: 16,
            textureHeight: 16,
          ),
          width: TILE_SIZE,
          height: TILE_SIZE,
          initPosition: initPosition,
          life: 200,
          speed: 100,
          collision: Collision(height: 32, width: 16),
        );


  void _handleMovement() {
    var direction = JoystickMoveDirectional.IDLE;

    if (movingDirections[0]) {
      direction = JoystickMoveDirectional.MOVE_LEFT;
    }
    if (movingDirections[1]) {
      direction = JoystickMoveDirectional.MOVE_RIGHT;
    }
    if (movingDirections[2]) {
      if (direction == JoystickMoveDirectional.MOVE_LEFT) direction = JoystickMoveDirectional.MOVE_DOWN_LEFT;
      else if (direction == JoystickMoveDirectional.MOVE_RIGHT) direction = JoystickMoveDirectional.MOVE_DOWN_RIGHT;
      else direction = JoystickMoveDirectional.MOVE_DOWN;
    }
    if (movingDirections[3]) {
      if (direction == JoystickMoveDirectional.MOVE_LEFT) direction = JoystickMoveDirectional.MOVE_UP_LEFT;
      else if (direction == JoystickMoveDirectional.MOVE_RIGHT) direction = JoystickMoveDirectional.MOVE_UP_RIGHT;
      else direction = JoystickMoveDirectional.MOVE_UP;
    }

    joystickChangeDirectional(JoystickDirectionalEvent(directional: direction));
  }

  @override
  void joystickAction(_) {}

  @override
  void die() {
    remove();
    gameRef.addDecoration(
      GameDecoration(
        initPosition: Position(
          position.left,
          position.top,
        ),
        height: 30,
        width: 30,
        sprite: Sprite('player/crypt.png'),
      ),
    );
    super.die();
  }

  void actionAttackRange(Offset pointerPosition) {
    final playerCenter = this.gameRef.gameCamera.worldPositionToScreen(this.position.center);
    final angle = atan2(pointerPosition.dy - playerCenter.dy, pointerPosition.dx - playerCenter.dx);

    this.simpleAttackRangeByAngle(
      animationTop: FlameAnimation.Animation.sequenced(
        'player/fireball_top.png',
        3,
        textureWidth: 23,
        textureHeight: 23,
      ),
      animationDestroy: FlameAnimation.Animation.sequenced(
        'player/explosion_fire.png',
        6,
        textureWidth: 32,
        textureHeight: 32,
      ),
      width: 25,
      height: 25,
      damage: 10,
      radAngleDirection: angle,
      speed: 350,
      collision: Collision(
        height: 25,
        width: 25/2
      ),
    );
  }

  @override
  void update(double dt) {
    if (this.isDead) return;
    this.gameRef?.gameCamera?.moveToPlayer(horizontal: 0, vertical: 0);
    _handleMovement();
    super.update(dt);
  }

  @override
  void render(Canvas c) {
    super.render(c);
  }

  @override
  void receiveDamage(double damage, int from) {
    this.showDamage(damage);
    super.receiveDamage(damage, from);
  }
}
