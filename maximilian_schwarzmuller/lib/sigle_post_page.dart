import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:maximilian_schwarzmuller/data/post_api_service.dart';
import 'package:maximilian_schwarzmuller/model/built_post.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;

  const SinglePostPage({Key key, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Chpper"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _futurePost(context),
      ),
    );
  }

  FutureBuilder<Response<BuiltPost>> _futurePost(BuildContext context) =>
      FutureBuilder<Response<BuiltPost>>(
        future: Provider.of<PostApiService>(context).getPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return _buildPost(context, snapshot.data.body);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );

  Column _buildPost(BuildContext context, BuiltPost post) => Column(
        children: <Widget>[
          Text(post.title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          Text(post.body, style: TextStyle(fontSize: 16)),
        ],
      );
}
