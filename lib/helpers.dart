import 'dart:ui';

double lerpDoubleWithStops(
  double start,
  double end,
  double value, {
  double stop,
}) {
  if (stop == null) return lerpDouble(start, end, value);
  if (value < 0.5)
    return lerpDouble(start, stop, value * 2);
  else if (value > .5) return lerpDouble(stop, end, (value - .5) * 2);
  return stop;
}
