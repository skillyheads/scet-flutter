import 'dart:io';

void main(List<String> args) {
  var sw = Stopwatch()..start();
  int counter = 0;
  for (int i = 0; i < 1000000; i++) {
    //stdout.write('.');
    counter++;
  }
  sw.stop();
  print(counter);
  print(sw.elapsedMilliseconds);
}
