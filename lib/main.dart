import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/gesture/pointer_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humerus/constants.dart';
import 'package:humerus/interface/knight_interface.dart';
import 'package:humerus/maps/map.dart';
import 'package:humerus/players/player.dart';
import 'package:flame/animation.dart' as FlameAnimation;
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Flame.util.setLandscape();
  // await Flame.util.fullScreen();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game(),
    ),
  );
}

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> implements GameListener {
  final GameController _controller = GameController();
  List<Enemy> _enemies = [];
  IO.Socket socket;

  @override
  void initState() {
    super.initState();

    // socket = IO.io('http://localhost:3000', <String, dynamic>{
    //   'transports': ['websocket'],
    // });

    // socket.on('connect', (value) {
    //   print("connected!");
    // });

    // socket.on('newPlayer', (data) {
    //   _controller.addEnemy(
    //     SimpleEnemy(
    //       animationIdleRight: FlameAnimation.Animation.sequenced(
    //         "enemy/goblin_idle.png",
    //         6,
    //         textureWidth: 16,
    //         textureHeight: 16,
    //       ),
    //       animationIdleLeft: FlameAnimation.Animation.sequenced(
    //         "enemy/goblin_idle_left.png",
    //         6,
    //         textureWidth: 16,
    //         textureHeight: 16,
    //       ),
    //       animationRunRight: FlameAnimation.Animation.sequenced(
    //         "enemy/goblin_run_right.png",
    //         6,
    //         textureWidth: 16,
    //         textureHeight: 16,
    //       ),
    //       animationRunLeft: FlameAnimation.Animation.sequenced(
    //         "enemy/goblin_run_left.png",
    //         6,
    //         textureWidth: 16,
    //         textureHeight: 16,
    //       ),
    //       width: TILE_SIZE,
    //       height: TILE_SIZE,
    //       initPosition: Position(27 * TILE_SIZE, 27 * TILE_SIZE),
    //       // name: data['id'],
    //     ),
    //   );
    // });

    // socket.on('movement', (data) {
    //   _controller.livingEnemies.forEach((element) {
    //     element.position = Rect.fromLTWH(data['x'], data['y'], TILE_SIZE, TILE_SIZE);
    //   });
    // });

    // socket.on('disconnectedPlayer', (data) {
    //   _controller.livingEnemies.forEach((element) {
    //     final enemy = element as SimpleEnemy;
    //     // if (enemy.name == data['id']) {
    //     //   enemy.remove();
    //     //   enemy.die();
    //     // }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: MyJoystick(),
      player: Knight(
        Position(17 * TILE_SIZE, 17 * TILE_SIZE),
        socket
      ),
      map: DungeonMap.map(),
      interface: KnightInterface(),
      enemies: _enemies,
      decorations: DungeonMap.decorations(),
      background: BackgroundColorGame(Colors.blueGrey[900]),
      gameController: _controller..setListener(this),
    );
  }

  void updateGame() {}
  void changeCountLiveEnemies(_) {}
}

class MyJoystick extends Joystick with PointerDetector {
  MyJoystick() : super(actions: []);

  @override
  void onKeyboard(RawKeyEvent event) {
    if (gameRef?.player == null) return;
    final player = gameRef.player as Knight;

    if (event.data.keyLabel == 'a') {
      player.movingDirections[0] = (event is RawKeyDownEvent);
    }
    if (event.data.keyLabel == 'd') {
      player.movingDirections[1] = (event is RawKeyDownEvent);
    }
    if (event.data.keyLabel == 's') {
      player.movingDirections[2] = (event is RawKeyDownEvent);
    }
    if (event.data.keyLabel == 'w') {
      player.movingDirections[3] = (event is RawKeyDownEvent);
    }
  }

  @override
  void onPointerDown(event) {
    if (gameRef?.player == null) return;
    final player = gameRef.player as Knight;

    player.actionAttackRange(event.position);
  }
}
