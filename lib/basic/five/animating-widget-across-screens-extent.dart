import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  debugPaintSizeEnabled = false; // Set to true for visual layout
  runApp(MyApp(
    imageList: List.generate(
      20,
      (i) => "images/pic$i.jpg",
    ),
  ));
}

class MyApp extends StatelessWidget {
  final List<String> imageList;

  MyApp({Key key, @required this.imageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: GestureDetector(child: _buildGrid(context)),
      ),
    );
  }

  // #docregion grid
  Widget _buildGrid(BuildContext context) => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
//      children: _buildGridTileList(30));
      children: _buildGridImageListJust(context));

  Widget _buildGridBuild(BuildContext context) => GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.0),
        itemBuilder: (BuildContext context, int index) {
          return _buildImage(context, index);
        },
        itemCount: 30,
      );

  // The images are saved with names pic0.jpg, pic1.jpg...pic29.jpg.
  // The List.generate() constructor allows an easy way to create
  // a list when objects have a predictable naming pattern.
  List<Container> _buildGridTileList(int count) => List.generate(
      count,
      (i) => Container(
            child: Image.asset('images/pic$i.jpg'),
          ));

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

  List<GestureDetector> _buildGridImageListJust(BuildContext context) =>
      List.generate(
          30,
          (i) => GestureDetector(
                child: Hero(
                  tag: 'imageHero',
                  child: Image.asset('images/pic$i.jpg'),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MyDetailScreen(imageURL: 'images/pic$i.jpg');
                  }));
                },
              ));

  List<GestureDetector> _buildGridImageList(BuildContext context) {
    List<GestureDetector> gestureList = List(30);
    for (var i = 0; i < imageList.length; i++) {
      gestureList[i] = GestureDetector(
        child: Hero(
          tag: 'imageHero',
          child: Image.asset(imageList[i]),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return MyDetailScreen(imageURL: imageList[i]);
          }));
        },
      );
    }
    return gestureList;
  }
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
