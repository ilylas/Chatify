import 'package:dio/dio.dart';

class CloudinaryService {
  final String cloudName = 'dy0iygagk';
  final String apiKey = '-769779352826164';
  final String apiSecret = '-NXEzrKEM0JFdsPPGAzkdXHrAvY';

  Future<String?> uploadImage(String filePath) async {
    try {
      final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
        'upload_preset': 'my_upload_preset',
      });
      final response = await Dio().post(url, data: formData);
      return response.data['secure_url'];
    }
    catch (e) {
      print('Upload failed: $e');
      return null;
    }
  }
}
