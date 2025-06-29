import 'dart:io';

import 'package:dartpostv2/dartpostv2.dart' as dartpostv2;

void main(List<String> arguments) {
  int postId = 1;
  String postedBy = "Krishna";
  String postBody = "Hello, what a nice day... ${postId}!";
  DateTime postdOn = DateTime.now();
  bool isVisible = true;
  int noOfLikes = 10;
  int noOfReposts = 0;

  int? reportedBy = 10;
  reportedBy = null;

  dynamic iconId = "Like Icon";
  iconId = 9;

  print(iconId.runtimeType);

  Set<String> hashTags = {"#dart", "#spring", "flutter"};
  hashTags.add("#sql");

  List comments = ['good', 'hi', 45];
  comments.add("");
  comments.insert(3, "");
  comments.addAll([]);
  comments[0];

  Map<String, int> shareCountsByTag = {'#dart': 10, '#spring': 20};
  shareCountsByTag["#dart"] = 30;

  print(postId);
  print(postedBy);
  print(postBody);
  print(postdOn);
  String myMessage = returnIfExists("My Message");
  print(myMessage);
  returnIfExistsNamed(name: "", whatIfMissing: "");
  String? value = display(null);
  print(value);

  print("Enter your name");
  String? name = stdin.readLineSync();
  print("Entered name is $name");
  int.tryParse(name??"0");
}

String returnIfExists(String message, {String whatIfMissing = 'nothing'}) {
  return '$message and $whatIfMissing';
}

String returnIfExistsNamed({required String name, String? whatIfMissing}) {
  return "".toUpperCase();
}

String? display(String? message) {
  return message?.toUpperCase();
}

List sort(List ages) {
  return [];
}
