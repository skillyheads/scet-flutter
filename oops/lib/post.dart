import 'dart:math';

class Post {
  int _postId;
  String _postContent;
  int _noOfLikes = 0;
  int _noOfShares = 0;
  List<String> _likedBy = [];
  List<String> _sharedBy = [];
  static Post? _post;
  Post(int postId, String postContent)
    : this._postId = postId,
      this._postContent = postContent {}

  Post.quickPost(String postContent)
    : _postId = 0,
      _postContent = postContent.substring(0, 10);

  Post.quickRedirectPost(String postContent)
    : this(0, postContent.substring(0, 10));

  String getPostContent() {
    return this._postContent;
  }

  factory Post.instance(String postContent) {
    _post ??= Post(10, postContent);
    return _post!;
  }

  int get noOfLikes {
    return _noOfLikes;
  }

  set noOfLike(int noOfLike) {
    _noOfLikes = noOfLike;
  }

  String get postContent => _postContent;

  set postContent(String post) => _postContent = post;

  getNoOfLikes() {
    return this._noOfLikes;
  }

  getNoOfShares() {
    return this._noOfShares;
  }

  setPostContent(String content) {
    this._postContent = content;
  }

  like(String by) {
    this._noOfLikes++;
    this._likedBy.add(by);
  }

  share(String by) {
    this._noOfShares++;
    this._sharedBy.add(by);
  }
}

class VideoPost extends Post {
  String _videoUrl;
  VideoPost(int id, String postContent, String videoUrl)
    : this._videoUrl = videoUrl,
      super(id, postContent);
}

abstract class Moderator {
  moderateThePost();
  rejectThePost();
}

abstract class Repoter {
  rejectThePost();
  reportThePost();
}

class SimplePostModeratorImpl implements Moderator, Repoter {
  moderateThePost() {
    print('Moderated Post');
  }

  rejectThePost() {
    print('Rejected Post');
  }

  reportThePost() {
    print('Reported Post');
  }
}
