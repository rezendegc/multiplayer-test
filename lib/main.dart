import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/gesture/pointer_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:humerus/constants.dart';
import 'package:humerus/interface/knight_interface.dart';
import 'package:humerus/maps/map.dart';
import 'package:humerus/players/player.dart';
import 'package:humerus/socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Flame.util.setLandscape();
  // await Flame.util.fullScreen();

  var socket = IO.io('http://localhost:3000', <String, dynamic> {
    'transports': ['websocket'],
    'autoConnect': false,
  });
  socket.connect();

  socket.on('connect', (value) {
    print('connected - $value');
  });

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Game(),
    ),
  );
}

class Game extends StatelessWidget implements GameListener {
  final GameController _controller = GameController();

  @override
  Widget build(BuildContext context) {
    return BonfireWidget(
      joystick: MyJoystick(),
      player: Knight(
        Position(27 * TILE_SIZE, 27 * TILE_SIZE),
      ),
      map: DungeonMap.map(),
      interface: KnightInterface(),
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