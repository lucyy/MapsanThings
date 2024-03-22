
abstract class UbicacionEvent{}

class UbicacionTriggerEvent extends UbicacionEvent{
  final bool ubicando;

  UbicacionTriggerEvent(this.ubicando);
}