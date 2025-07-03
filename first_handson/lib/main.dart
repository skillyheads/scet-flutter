import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Image Viewer'),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String url;
  const ImageViewer({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(child: Image.asset(url));
          },
        );
      },
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Image.asset(fit: BoxFit.fitWidth, url),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, super.key});
  void _showAlert(BuildContext context, [String message = "Alert"]) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade50,
        title: Text('My App'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ImageViewer(url: 'assets/images/image11.jpg'),
          ImageViewer(url: 'assets/images/image12.jpg'),
          ImageViewer(url: 'assets/images/image13.jpg'),
          ImageViewer(url: 'assets/images/image14.jpg'),
          ImageViewer(url: 'assets/images/image15.jpg'),
          ImageViewer(url: 'assets/images/image16.jpg'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.back_hand), label: 'Help'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_showAlert(context, 'Menu Clicked')},
        child: Icon(Icons.menu),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      drawer: Drawer(
        child: Row(
          children: [
            DrawerHeader(child: Text('Menu')),
            Text('Menu-Item'),
            SizedBox(height: 15),
            Text('Menu-Item2', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}

class ImageGalleryScreen extends StatelessWidget {
  // List of sample asset image paths
  // Replace these with your actual asset image paths
  final List<String> imageAssets = [
    'assets/images/image1.webp',
    'assets/images/image2.webp',
    'assets/images/image3.webp',
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
    'assets/images/image6.jpg',
    'assets/images/image7.jpg',
    'assets/images/image8.jpg',
    'assets/images/image9.jpg',
    'assets/images/image10.jpg',
    'assets/images/image11.jpg',
    'assets/images/image12.jpg',
    'assets/images/image13.jpg',
    'assets/images/image14.jpg',
    'assets/images/image15.jpg',
    'assets/images/image16.jpg',
    'assets/images/image17.jpg',
    'assets/images/image18.jpg',
    'assets/images/image19.jpg',
    'assets/images/image20.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Gallery'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: imageAssets.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: GestureDetector(
              onTap: () => _showImageDialog(context, imageAssets[index]),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.asset(
                    imageAssets[index],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Fallback for missing assets
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey[600],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Image ${index + 1}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Tap to view',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              // Main image container
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              size: 80,
                              color: Colors.grey[600],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Image not found',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Close button
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Liker extends StatefulWidget {
  const Liker({super.key});
  @override
  State<Liker> createState() => _MyCounterState();
}

class _MyCounterState extends State<Liker> {
  int likeCount = 0;
  void _onLike() {
    setState(() {
      likeCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton.icon(
                label: Text('Like'),
                icon: Icon(Icons.thumb_up),
                onPressed: _onLike,
              ),
              Text('$likeCount', style: TextStyle(fontSize: 30)),
            ],
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  int likesCount = 0;
  void liked() {
    setState(() {
      likesCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(25),
            child: ElevatedButton(
              onPressed: liked,
              child: Icon(Icons.favorite),
            ),
          ),
          Text('$likesCount', style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
