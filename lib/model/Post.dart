class PostList {
  //This class is to handle the list of objects, the data within the {}
  //Which is within [], a list

  //Creating a List of type Posts, which is created below
  final List<Post> posts;

  PostList({this.posts});

  //We have to retrieve it from JSON
  //Passing a List because the date retrieved is a List
  factory PostList.fromJson(List<dynamic> parsedJson) {
    //Making the List into a Dart Object. Data is assigned as it is retrieved
    //Map the entire list in the URL to a List which will contain posts
    List<Post> posts = new List<Post>();
    // TODO: Research!!!
    posts = parsedJson.map((i) => Post.fromJson(i)).toList();

    return new PostList(posts: posts);
    //Now since it is an array, we can do Post[0].userId
  }
}

class Post {
  //This is the PODO [PLAIN OLD DART OBJECT] Class
  //We have to map the properties of each field to the JSON
  int userId;
  int id;
  String title;
  String body;

  Post({this.userId, this.id, this.title, this.body});

  //Factory Constructor which will allow us to do the Mapping
  //factory will prevent the class from creating multiple instance of itself
  // when we invoke the class
  //The data which is received is a Map so as the data is being received, it is
  // assigned to the Map, the post object
  //dynamic is any loose type (String, int, double, etc.) to prevent any type errors
  //Reason for passing a Map because each post on the URL is a Map, key-value pair
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
