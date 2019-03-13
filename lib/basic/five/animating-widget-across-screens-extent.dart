import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false; // Set to true for visual layout
  runApp(MyApp(
    imageList: List.generate(
      30,
      (i) => "images/pic$i.jpg",
    ),
  ));
}

class MyApp extends StatelessWidget {
  final List<String> imageList;

  MyApp({Key key, @required this.imageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(imageList[index]),
            // When a user taps on the ListTile, navigate to the DetailScreen.
            // Notice that we're not only creating a DetailScreen, we're
            // also passing the current todo through to it!
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyDetailScreen(imageURL: imageList[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }

  GestureDetector _buildImage(BuildContext context, int index) =>
      GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: Image.asset('images/pic$index.jpg'),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return MyDetailScreen(imageURL: 'images/pic$index.jpg');
          }));
        },
      );
}

class MyDetailScreen extends StatelessWidget {
  final String imageURL;

  MyDetailScreen({Key key, @required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.asset(imageURL),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
