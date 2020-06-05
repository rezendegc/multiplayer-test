import 'package:bonfire/bonfire.dart';
import 'package:flame/position.dart';
import 'package:humerus/constants.dart';
import 'package:humerus/decorations/lava.dart';

class DungeonMap {
  static MapWorld map() {
    final floor = Sprite('tile/floor_1.png');
    List<Tile> tileList = List();
    List.generate(45, (indexRow) {
      List.generate(45, (indexColumm) {
        tileList.add(
          Tile.fromSprite(
            floor,
            Position(indexColumm.toDouble(), indexRow.toDouble()),
            size: TILE_SIZE,
          ),
        );
      });
    });

    return MapWorld(tileList);
  }

  static List<GameDecoration> decorations() {
    final spike = Sprite('itens/spikes.png');
    List<GameDecoration> _decorationList = List();
    List.generate(45, (indexRow) {
      List.generate(45, (indexColumm) {
        if (indexRow > 15 &&
            indexRow < 30 &&
            indexColumm > 15 &&
            indexColumm < 30) {
        } else {
          _decorationList.add(
            Spikes(
              Position(indexColumm.toDouble() * TILE_SIZE, indexRow.toDouble() * TILE_SIZE),
              spike
            ),
          );
        }
      });
    });
    return _decorationList;
  }
}