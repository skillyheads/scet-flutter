import 'dart:io';
import 'dart:vmservice_io';

import 'package:async_demo/Employee.dart';
import 'package:async_demo/Searcher.dart';
import 'package:async_demo/async_demo.dart' as async_demo;

Future<String> waitAndReturn(String req, int delay) async {
  await Future.delayed(Duration(seconds: delay));
  return "Response to the $req";
}

findTime() {
  Stopwatch sw = Stopwatch();
  sw.start();
  int count = 0;
  for (int i = 0; i < 1000000; i++) {
    stdout.write('.');
    count++;
  }
  sw.stop();
  print('${count}ed in ${sw.elapsed.inMilliseconds}');
}

void main(List<String> arguments) async {
  Employee emp1 = Employee(1, 'Ram');
  print(emp1);

  emp1.empName = "Ramesh";
  print(emp1);

  Employee emp2 = Employee(1, 'Ram');
  Employee? emp3 = emp1 + emp2;
  print(emp3?.empId);
  print(emp3?.empName);
  print(emp1 == emp2);
  print(emp1.hashCode);

  IntSearcher searcher = IntSearcher([10, 43, 56, 76, 89]);
  int foundAt = searcher.search(43);
  print(foundAt);

  StringSearcher strSearcher = StringSearcher(["Ram", "Raju", "Kiran"]);
  foundAt = strSearcher.search("Ram");
  print(foundAt);

  Searcher<int> intSearcher = Searcher([10, 43, 56, 76, 89]);
  foundAt = intSearcher.search(43);
  print(foundAt);

  Searcher stringSearcher = Searcher(["Ram", "Raju", "Kiran", 56, emp1]);
  foundAt = stringSearcher.search("Ram");
  print(foundAt);

  //findTime();

  String res = await waitAndReturn("Good Mornig", 5);
  print(res);

  Future<String> futureRes = waitAndReturn("Good Evening", 5);
  print(futureRes);
  futureRes.then((data) {
    print(data);
  });
  print('Program End');
}
