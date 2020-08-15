import 'dart:math';

List invalidPaths = [
  [1, 3],
  [3, 1],
  [2, 4],
  [4, 2],
  [5, 6],
  [6, 5],
];

List<List<int>> getAnimationPaths(int start, int end, int minimumSteps) {
  List<List<int>> paths = [];
  int lastDice;

  do {
    int random = Random().nextInt(5) + 1;
    if (lastDice != random) {
      List<int> possibleSet = [lastDice ?? start, random];
      if (!_isInvalid(possibleSet)) {
        paths.add(possibleSet);
        lastDice = random;
      }
    }
    if (paths.length >= minimumSteps) {
      while (end != lastDice) {
        List<int> possibleSet = [lastDice, end];
        if (!_isInvalid(possibleSet)) {
          paths.add(possibleSet);
          lastDice = end;
        }
      }
    }
  } while (paths.length < minimumSteps);
  print(paths);
  return paths;
}

_isInvalid(List a) {
  for (List i in invalidPaths)
    if (a.first == i.first && a.last == i.last) return true;
  return false;
}
