import 'package:bonfire/bonfire.dart';
import 'package:flame/position.dart';
import 'package:humerus/constants.dart';

const TIME_BETWEEN_HITS = 1.5;

class Spikes extends GameDecoration {
  final Position initPosition;
  double _timeSinceLastHit = 0;

  Spikes(this.initPosition, Sprite sprite)
      : super.sprite(
          sprite,
          initPosition: initPosition,
          width: TILE_SIZE,
          height: TILE_SIZE,
          isSensor: false,
          // collision: Collision(
          //   width: TILE_SIZE,
          //   height: TILE_SIZE,
          //   align: CollisionAlign.CENTER,
          // ),
        );

  @override
  void update(double dt) {
    if (_timeSinceLastHit > 0) {
      _timeSinceLastHit -= dt;
    }
  }

  @override
  void onContact(collision) {
    // only allows hit player after 1.5s from last hit
    if (_timeSinceLastHit > 0) return;

    // only triggers on collision with player
    if (collision.runtimeType.toString() == 'Knight') {
      _timeSinceLastHit = TIME_BETWEEN_HITS;
      gameRef.player.receiveDamage(3, 1);
    }
  }
}
