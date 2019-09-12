import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:maximilian_schwarzmuller/data/post_api_service.dart';
import 'package:maximilian_schwarzmuller/sigle_post_page.dart';
import 'package:built_collection/built_collection.dart';

import 'package:provider/provider.dart';

import 'model/built_post.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Chpper"),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final post = BuiltPost((builder) => builder
            ..title = "New Title"
            ..body = "New Body");

          final response =
              await Provider.of<PostApiService>(context).postPost(post);
          print(response.body);
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) =>
      FutureBuilder<Response<BuiltList<BuiltPost>>>(
        future: Provider.of<PostApiService>(context).getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            final posts = snapshot.data.body;
            return _builderPosts(context, posts);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );

  ListView _builderPosts(BuildContext context, BuiltList<BuiltPost> posts) {
    return ListView.builder(
        itemCount: posts.length,
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            child: ListTile(
              title: Text(
                posts[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(posts[index].body),
              onTap: () => _navigateToPost(context, posts[index].id),
            ),
          );
        });
  }

  void _navigateToPost(BuildContext context, int postId) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SinglePostPage(postId: postId)));
  }
}
