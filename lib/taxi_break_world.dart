import 'dart:developer';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:taxi_break_game/components/environment/wall_body.dart';
import 'package:taxi_break_game/components/people/man_1_sprite.dart';
import 'package:taxi_break_game/components/taxi/taxi_body.dart';
import 'package:taxi_break_game/taxi_break_game.dart';

const tileSize = 16.0;

class TaxiBreakWorld extends Forge2DWorld with DragCallbacks {
  final CameraComponent _taxiCamera;
  late final TaxiBody _taxiBody;

  Vector2? _dragStartPosition;

  TaxiBreakWorld({required CameraComponent taxiCamera}) : _taxiCamera = taxiCamera;

  @override
  Future<void> onLoad() async {
    _taxiCamera.world = this;
    _taxiBody = TaxiBody(camera: _taxiCamera);
    // TODO: move man creation from here to controller
    final man1 = Man1Sprite(size: Vector2.all(14) / gameZoom);

    const cityScale = 2.0 / gameZoom;

    final cityComponent = await TiledComponent.load('city_1_level.tmx', Vector2.all(tileSize));
    final List<Component> walls = await _createCityWalls(
      tiledCity: cityComponent,
      scale: cityScale,
    );
    cityComponent
      ..scale = Vector2.all(cityScale)
      ..position = Vector2.zero();

    await addAll([cityComponent, ...walls, man1, _taxiBody]);
  }

  @override
  void onDragStart(DragStartEvent event) {
    _dragStartPosition = event.canvasPosition;
    _taxiBody.isDragging = true;
    log('DRAG START');
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    final dragDelta = event.canvasEndPosition - _dragStartPosition!;
    dragDelta.clamp(Vector2(-30, -30), Vector2(30, 30));
    if (_taxiBody.currentDragDelta != dragDelta) {
      _taxiBody.currentDragDelta = dragDelta;
      log('DELTA: ${_taxiBody.currentDragDelta}');
    }
    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _dragStartPosition = null;
    _taxiBody.isDragging = false;
    log('DRAG END');
    super.onDragEnd(event);
  }

  Future<List<Component>> _createCityWalls({
    required TiledComponent tiledCity,
    required double scale,
  }) async {
    final List<Component> hitBoxes = [];
    final tileMap = tiledCity.tileMap;

    List<List<Gid>> getTileData({required String layerName}) =>
        tileMap.getLayer<TileLayer>(layerName)?.tileData ?? [];

    final buildings = getTileData(layerName: 'Buildings');
    final decor = getTileData(layerName: 'Decor');
    final decor2 = getTileData(layerName: 'Decor-2');
    final otherCars = getTileData(layerName: 'OtherCars');

    for (var r = 0; r < buildings.length; r++) {
      for (var c = 0; c < buildings[r].length; c++) {
        if (buildings[r][c].tile != 0 ||
            decor[r][c].tile != 0 ||
            decor2[r][c].tile != 0 ||
            otherCars[r][c].tile != 0) {
          final blockBody = WallBody(
            startPosition: Vector2(((c + 0.5) * tileSize) * scale, (r + 0.5) * tileSize * scale),
            size: Size(tileSize * scale, tileSize * scale),
          );
          hitBoxes.add(blockBody);
        }
      }
    }
    return hitBoxes;
  }
}
