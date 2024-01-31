import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  XFile? _image;
  XFile? _video;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _loadFromPreferences();
  }

  Future<void> _saveToPreferences(String path) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profilePath', path);
  }

  Future<void> _loadFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profilePath = prefs.getString('profilePath');

    if (profilePath != null) {
      if (profilePath.endsWith('.jpg') || profilePath.endsWith('.png')) {
        setState(() {
          _image = XFile(profilePath);
        });
      } else if (profilePath.endsWith('.mp4')) {
        setState(() {
          _video = XFile(profilePath);
          _videoController = VideoPlayerController.file(File(profilePath))
            ..initialize().then((_) {
              setState(() {});
            });
        });
      }
    }
  }

  Future<void> _getMulitiImage() async {
    try {
      List<XFile> resultList =
          await ImagePicker().pickMultiImage(imageQuality: 50);

      if (resultList.isNotEmpty) {
        // Convert images to PDF
        final pdf = await _convertImagesToPdf(resultList);

        // Save and share the PDF
        await _saveAndSharePdf(pdf);
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  Future<pw.Document> _convertImagesToPdf(List<XFile> images) async {
    final pdf = pw.Document();

    for (final image in images) {
      final Uint8List imageData = await image.readAsBytes();
      final imageProvider = pw.MemoryImage(imageData);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageProvider),
            );
          },
        ),
      );
    }
    return pdf;
  }

  Future<void> _saveAndSharePdf(pw.Document pdf) async {
    final downloadsDirectory = await getDownloadsDirectory();
    final file = File("${downloadsDirectory!.path}/multi_images.pdf");
    print('downloadsDirectory... $file');
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
    print('file path... ${file.path}');

    // Share the PDF
    // Share.shareFiles([file.path]);
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage != null) {
        if (_videoController != null) {
          _videoController!.dispose();
        }
        _saveToPreferences(pickedImage.path);
        setState(() {
          _image = pickedImage;
          _videoController = null;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _getVideo(ImageSource source) async {
    try {
      final pickedVideo = await ImagePicker().pickVideo(
        source: source,
        maxDuration: const Duration(seconds: 3),
      );

      if (pickedVideo != null) {
        if (_videoController != null) {
          _videoController!.dispose();
        }
        _saveToPreferences(pickedVideo.path);
        setState(() {
          _image = null;
          _video = pickedVideo;
          _videoController = VideoPlayerController.file(File(_video!.path))
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized
              setState(() {});
            });
          // _videoController!.seekTo(Duration(seconds: 0));
        });
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

  Future<void> _showImageSourceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showVideoSourceDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Video'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getVideo(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _getVideo(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: _image == null
                  ? _video == null
                      ? Image.asset(
                          'assets/images/blank-profile.png',
                          fit: BoxFit.cover,
                        )
                      : GestureDetector(
                          onTap: () {
                            if (_videoController != null) {
                              if (_videoController!.value.isPlaying) {
                                _videoController!.pause();
                              } else {
                                _videoController!.play();
                                _videoController!.setVolume(0.0);
                              }
                            }
                          },
                          child: AspectRatio(
                            aspectRatio: _videoController!.value.aspectRatio,
                            child: VideoPlayer(_videoController!),
                          ),
                        )
                  : Image.file(
                      File(_image!.path),
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _showImageSourceDialog,
                  child: const Text('Select Image'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _showVideoSourceDialog,
                  child: const Text('Select Video'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getMulitiImage,
              child: const Text('Images to pdf'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}


  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Profile Upload'),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Container(
  //             width: 150,
  //             height: 150,
  //             clipBehavior: Clip.antiAlias,
  //             decoration: const BoxDecoration(
  //               shape: BoxShape.circle,
  //             ),
  //             child: _image == null
  //                 ? Image.asset(
  //                     'assets/images/blank-profile.png',
  //                     fit: BoxFit.cover,
  //                   )
  //                 : Image.file(
  //                     File(_image!.path),
  //                     fit: BoxFit.cover,
  //                   ),
  //           ),
  //           const SizedBox(height: 20),
  //           Container(
  //             width: 150,
  //             height: 150,
  //             alignment: Alignment.center,
  //             clipBehavior: Clip.antiAlias,
  //             decoration: const BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: Colors.amber,
  //             ),
  //             child: _video == null
  //                 ? const Text(
  //                     'No video selected.',
  //                     textAlign: TextAlign.center,
  //                   )
  //                 : Stack(
  //                     alignment: Alignment.center,
  //                     children: [
  //                       AspectRatio(
  //                         aspectRatio: _videoController!.value.aspectRatio,
  //                         child: VideoPlayer(_videoController!),
  //                       ),
  //                       GestureDetector(
  //                         onTap: () {
  //                           // Play or pause the video when clicked
  //                           if (_videoController != null) {
  //                             if (_videoController!.value.isPlaying) {
  //                               _videoController!.pause();
  //                             } else {
  //                               _videoController!.play();
  //                             }
  //                           }
  //                         },
  //                         child: _videoController!.value.isPlaying
  //                             ? Container() // Empty container when playing
  //                             : const Icon(
  //                                 Icons.play_arrow,
  //                                 color: Colors.white,
  //                                 size: 40,
  //                               ),
  //                       ),
  //                     ],
  //                   ),
  //             // : GestureDetector(
  //             //     onTap: () {
  //             //       // Play or pause the video when clicked
  //             //       if (_videoController != null) {
  //             //         if (_videoController!.value.isPlaying) {
  //             //           _videoController!.pause();
  //             //         } else {
  //             //           _videoController!.play();
  //             //         }
  //             //       }
  //             //     },
  //             //     child: Container(
  //             //       width: double.infinity,
  //             //       child: AspectRatio(
  //             //         aspectRatio: _videoController!.value.aspectRatio,
  //             //         child: VideoPlayer(_videoController!),
  //             //       ),
  //             //     ),
  //             //   ),
  //           ),
  //           const SizedBox(height: 20),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               ElevatedButton(
  //                 onPressed: _showImageSourceDialog,
  //                 child: const Text('Select Image'),
  //               ),
  //               const SizedBox(width: 10),
  //               ElevatedButton(
  //                 onPressed: _showVideoSourceDialog,
  //                 child: const Text('Select Video'),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }