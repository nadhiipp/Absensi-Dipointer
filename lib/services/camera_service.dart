import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraService {
  final ImagePicker _picker = ImagePicker();
  
  // Get available cameras
  Future<List<CameraDescription>> getAvailableCameras() async {
    try {
      return await availableCameras();
    } catch (e) {
      print('Error getting cameras: $e');
      return [];
    }
  }
  
  // Take photo using camera
  Future<File?> takePicture() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 85,
      );
      
      if (photo != null) {
        return File(photo.path);
      }
      return null;
    } catch (e) {
      print('Error taking picture: $e');
      return null;
    }
  }
  
  // Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }
  
  // Save photo to app directory
  Future<String?> savePhoto(File photo, String prefix) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileName = '${prefix}_$timestamp.jpg';
      final String filePath = path.join(directory.path, fileName);
      
      await photo.copy(filePath);
      return filePath;
    } catch (e) {
      print('Error saving photo: $e');
      return null;
    }
  }
  
  // Delete photo
  Future<bool> deletePhoto(String photoPath) async {
    try {
      final file = File(photoPath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting photo: $e');
      return false;
    }
  }
}
