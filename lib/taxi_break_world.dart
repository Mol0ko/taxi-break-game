import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:taxi_break_game/components/brick_surface.dart';
import 'package:taxi_break_game/components/taxi_body.dart';

class TaxiBreakWorld extends Forge2DWorld with DragCallbacks {
  final CameraComponent _taxiCamera;
  late final TaxiBody _taxiBody;

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
    _taxiBody.isDragging = true;
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    _taxiBody.currentDragDelta = event.canvasDelta;
    super.onDragUpdate(event);
  }

@override
  void onDragEnd(DragEndEvent event) {
    _taxiBody.isDragging = false;
    super.onDragEnd(event);
  }
}
