import 'package:bonfire/bonfire.dart';
import 'package:flame/position.dart';
import 'package:humerus/constants.dart';
import 'package:humerus/decorations/lava.dart';

class DungeonMap {
  static MapWorld map() {
    final floor = Sprite('tile/floor_1.png');
    List<Tile> tileList = List();
    List.generate(75, (indexRow) {
      List.generate(75, (indexColumm) {
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
    List.generate(75, (indexRow) {
      List.generate(75, (indexColumm) {
        if (indexRow > 25 &&
            indexRow < 40 &&
            indexColumm > 25 &&
            indexColumm < 40) {
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
// import 'dart:math';

// import 'package:bonfire/bonfire.dart';
// import 'package:flame/position.dart';

// class DungeonMap {
//   static const double tileSize = 45;

//   static MapWorld map() {
//     List<Tile> tileList = List();
//     List.generate(35, (indexRow) {
//       List.generate(70, (indexColumm) {
//         if (indexRow == 3 && indexColumm > 2 && indexColumm < 30) {
//           tileList.add(Tile('tile/wall_bottom.png',
//               Position(indexColumm.toDouble(), indexRow.toDouble()),
//               collision: true, size: tileSize));
//           return;
//         }
//         if (indexRow == 4 && indexColumm > 2 && indexColumm < 30) {
//           tileList.add(Tile('tile/wall.png',
//               Position(indexColumm.toDouble(), indexRow.toDouble()),
//               collision: true, size: tileSize));
//           return;
//         }

//         if (indexRow == 9 && indexColumm > 2 && indexColumm < 30) {
//           tileList.add(Tile('tile/wall_top.png',
//               Position(indexColumm.toDouble(), indexRow.toDouble()),
//               collision: true, size: tileSize));
//           return;
//         }

//         if (indexRow > 4 &&
//             indexRow < 9 &&
//             indexColumm > 2 &&
//             indexColumm < 30) {
//           tileList.add(Tile(randomFloor(),
//               Position(indexColumm.toDouble(), indexRow.toDouble()),
//               size: tileSize));
//           return;
//         }

//         if (indexRow > 3 && indexRow < 9 && indexColumm == 2) {
//           tileList.add(Tile('tile/wall_left.png',
//               Position(indexColumm.toDouble(), indexRow.toDouble()),
//               collision: true, size: tileSize));
//         }
//         if (indexRow == 9 && indexColumm == 2) {
//           tileList.add(Tile('tile/wall_bottom_left.png',
//               Position(indexColumm.toDouble(), indexRow.toDouble()),
//               collision: true, size: tileSize));
//         }

//         if (indexRow > 3 && indexRow < 9 && indexColumm == 30) {
//           tileList.add(Tile('tile/wall_right.png',
//               Position(indexColumm.toDouble(), indexRow.toDouble()),
//               collision: true, size: tileSize));
//         }

//         if (indexRow == 13 && indexColumm == 31) {
//           tileList.add(Tile(
//               '', Position(indexColumm.toDouble(), indexRow.toDouble()),
//               size: tileSize));
//           return;
//         }
//       });
//     });

//     return MapWorld(tileList);
//   }

//   static List<GameDecoration> decorations() {
//     return [
//       GameDecoration.sprite(
//         Sprite('itens/barrel.png'),
//         initPosition: getRelativeTilePosition(10, 6),
//         width: tileSize,
//         height: tileSize,
//         collision: Collision(
//           width: tileSize / 1.5,
//           height: tileSize / 1.5,
//           align: CollisionAlign.CENTER,
//         ),
//       ),
//       GameDecoration.sprite(
//         Sprite('itens/table.png'),
//         initPosition: getRelativeTilePosition(15, 7),
//         width: tileSize,
//         height: tileSize,
//         collision: Collision(
//           height: tileSize * 0.8,
//           width: tileSize,
//           align: CollisionAlign.TOP_CENTER,
//         ),
//       ),
//       GameDecoration.sprite(
//         Sprite('itens/table.png'),
//         initPosition: getRelativeTilePosition(27, 6),
//         width: tileSize,
//         height: tileSize,
//         collision: Collision(
//           height: tileSize * 0.8,
//           width: tileSize,
//           align: CollisionAlign.TOP_CENTER,
//         ),
//       ),
//       GameDecoration.sprite(
//         Sprite('itens/flag_red.png'),
//         initPosition: getRelativeTilePosition(24, 4),
//         width: tileSize,
//         height: tileSize,
//       ),
//       GameDecoration.sprite(
//         Sprite('itens/flag_red.png'),
//         initPosition: getRelativeTilePosition(6, 4),
//         width: tileSize,
//         height: tileSize,
//       ),
//       GameDecoration.sprite(
//         Sprite('itens/prisoner.png'),
//         initPosition: getRelativeTilePosition(10, 4),
//         width: tileSize,
//         height: tileSize,
//       ),
//       GameDecoration.sprite(
//         Sprite('itens/flag_red.png'),
//         initPosition: getRelativeTilePosition(14, 4),
//         width: tileSize,
//         height: tileSize,
//       )
//     ];
//   }

//   static String randomFloor() {
//     int p = Random().nextInt(6);
//     String sprite = "";
//     switch (p) {
//       case 0:
//         sprite = 'tile/floor_1.png';
//         break;
//       case 1:
//         sprite = 'tile/floor_1.png';
//         break;
//       case 2:
//         sprite = 'tile/floor_2.png';
//         break;
//       case 3:
//         sprite = 'tile/floor_2.png';
//         break;
//       case 4:
//         sprite = 'tile/floor_3.png';
//         break;
//       case 5:
//         sprite = 'tile/floor_4.png';
//         break;
//     }
//     return sprite;
//   }

//   static Position getRelativeTilePosition(int x, int y) {
//     return Position(
//       (x * tileSize).toDouble(),
//       (y * tileSize).toDouble(),
//     );
//   }
// }
