import 'package:oops/post.dart';

void main(List<String> args) {
  // int postId = 1;
  // String postContent = "What a wonderful day...!";
  // String postedBy = "Ram";
  // int noOfLikes = 20;

  // int postId2 = 2;
  // String postContent2 = "What a nice day...!";
  // String postedBy2 = "Kumar";
  // int noOfLikes2 = 10;

  // List<int> postIds = [17, 12];
  // List<String> postContents = [
  //   "What a wonderful day...!",
  //   "What a nice day...!",
  // ];
  // List<String> postedBy = ["Ram", "Kumar"];
  // List<int> noOfLikes = [20, 10];

  // List<Post> posts = [
  //   Post(17, "What a wonderful day..", 10, 20),
  //   Post(12, "What a nice day..", 10, 20),
  // ];

  // Post myPost = Post(2, "Content", 10, 13);

  // //myPost.noOfLikes = 2;
  // //myPost.likedBy.add("Ram");

  // print(myPost.postContent);
  Post post = Post(10, "Default Content");
  print(post.postContent);

  post.setPostContent("New Content");
  print(post.getPostContent());

  post.postContent = "New Content through new setter";
  print(post.postContent);

  Post quick = Post.quickPost("Have a great day.....");
  print(quick.postContent);

  Post quick2 = Post.quickRedirectPost("Have a great day.....");
  print(quick2.postContent);

  Post obj = Post.instance("Content of the post");
  print(obj.postContent);

  Moderator moderator = SimplePostModeratorImpl();
  Repoter repoter = SimplePostModeratorImpl();
moderator.
  repoter.
}
