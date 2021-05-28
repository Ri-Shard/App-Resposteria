import 'dart:io';

import 'package:appreposteria/src/other/colors.dart';
import 'package:appreposteria/src/constants/controllers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mdi/mdi.dart';
import 'package:path/path.dart' as path;

class AdminHomePage extends StatefulWidget {
  static const String route = "/HomePage";
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  late double height, width;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      height = constraints.maxHeight;
      width = constraints.maxWidth;
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () {
              authController.signOut();
            },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
        ),

        ),
        bottomNavigationBar: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomNavItem(0, Mdi.home),
              _buildBottomNavItem(1, Mdi.cart),
              _buildBottomNavItem(2, Mdi.shoppingOutline),
              _buildBottomNavItem(3, Mdi.accountSettings),
            ],
          ),
        ),
        body: _buildBody(constraints),
      );
      }
    );
  }

  _buildBottomNavItem(int index, IconData icon) {
    return GestureDetector(
      onTap: () {
        this._currentIndex = index;
        setState(() {});
      },
      child: Container(
        decoration: BoxDecoration(
          color: index == _currentIndex ? AppColors.kCategorypinkColor : Colors.white,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          child: Icon(
            icon,
            color: index == _currentIndex
                ? Colors.white
                : AppColors.kCategorypinkColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
 _buildBody(constraints){
      var height = constraints.maxHeight;
      var width = constraints.maxWidth;
      return SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: 0.05 * height,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 10.0),
                  )
                ),
                 _buildRichText(),
                Container(
                  height: 0.56 * height,
                  width: width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(    
          children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: () => _upload('camera'),
                    icon: Icon(Icons.camera),
                    label: Text('camera')),
                ElevatedButton.icon(
                    onPressed: () => _upload('gallery'),
                    icon: Icon(Icons.library_add),
                    label: Text('Gallery')),
              ],
            ),
            Expanded(
                child: FutureBuilder(
                  future: _loadImages(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SizedBox(
                          height: 0.56 * height,
                          child: new ListView.builder(                     
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final image = snapshot.data![index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                dense: false,
                                leading: Image.network(image['url']),
                                title: Text(image['uploaded_by']),
                                subtitle: Text(image['description']),
                                trailing: IconButton(
                                  onPressed: () => _delete(image['path']),
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              
            ),
          ],
        ),
      ),],
                  ),
                ),
              ]
            )
          ]
        )
       );   
 }
 
FirebaseStorage storage = FirebaseStorage.instance;

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    PickedFile pickedImage;
    try {
      pickedImage = (await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920))!;

      final String fileName = path.basename(pickedImage.path);
      File imageFile = File(pickedImage.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'A bad guy',
              'description': 'Some description...'
            }));

        // Refresh the UI
        setState((){});
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
  }

  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata!['uploaded_by'],
        "description": fileMeta.customMetadata!['description']
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState((){});
  }
}
    _buildRichText() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 30,
            ),
            children: [
              TextSpan(
                  text: "Admin",
                  style: TextStyle(
                      fontWeight: FontWeight.w800, color: Colors.black)),
                      
            ]),
      ),
    );
  }
