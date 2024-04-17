import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:taxi_break_game/components/brick_surface.dart';
import 'package:taxi_break_game/components/taxi_body.dart';

class TaxiBreakWorld extends Forge2DWorld with DragCallbacks {
  final CameraComponent _taxiCamera;
  late final TaxiBody _taxiBody;

  Vector2? _dragStartPosition;

  TaxiBreakWorld({required CameraComponent taxiCamera}) : _taxiCamera = taxiCamera;

  @override
  Future<void> onLoad() async {
    _taxiCamera.world = this;
    _taxiBody = TaxiBody(camera: _taxiCamera);
    final bricksSurface = BrickSurface();
    await addAll([bricksSurface, _taxiBody]);
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
}
