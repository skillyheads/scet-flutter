import 'package:oops/oops.dart' as oops;
import 'package:oops/post.dart' as post;

void main() {
  // Parallel arrays for social media posts
  List<String> postIds = ['p001', 'p002', 'p003'];
  List<String> contents = ['Hello World!', 'Learning Dart', 'OOP is fun!'];
  List<String> postedOn = ['2024-01-01', '2024-01-02', '2024-01-03'];
  List<String> postedBy = ['alice', 'bob', 'charlie'];
  List<int> likesCounts = [10, 25, 5];
  List<int> shareCounts = [2, 8, 1];

  // Function to fetch post by ID
  void fetchPostById(String id) {
    int index = postIds.indexOf(id);
    if (index != -1) {
      print('Post ID: ${postIds[index]}');
      print('Content: ${contents[index]}');
      print('Posted On: ${postedOn[index]}');
      print('Posted By: ${postedBy[index]}');
      print('Likes: ${likesCounts[index]}');
      print('Shares: ${shareCounts[index]}');
    } else {
      print('Post not found!');
    }
  }

  // Function to fetch posts by user
  void fetchPostsByUser(String user) {
    print('Posts by $user:');
    for (int i = 0; i < postedBy.length; i++) {
      if (postedBy[i] == user) {
        print('- ${postIds[i]}: ${contents[i]}');
      }
    }
  }

  // Test the functions
  fetchPostById('p002');
  print('\n');
  fetchPostsByUser('alice');
}
