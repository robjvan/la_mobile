import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:camera/camera.dart';
import 'package:la_mobile/secrets.dart';

class AppWriteService {
  // Singleton pattern for shared instance
  static final AppWriteService _instance = AppWriteService._internal();

  // Public factory constructor to return the same instance
  factory AppWriteService() => _instance;

  // Private constructor
  AppWriteService._internal() {
    _client =
        Client()
          ..setEndpoint(AppSecrets.appwriteUrl)
          ..setProject(AppSecrets.appWriteProjectId)
          ..setSelfSigned(status: true); // For self-hosted dev environments

    _storage = Storage(_client);
  }

  late final Client _client;
  late final Storage _storage;

  /// Uploads an image file to the Appwrite storage bucket and returns the public view URL
  Future<String?> uploadImage(final XFile file) async {
    try {
      final File result = await _storage.createFile(
        bucketId: AppSecrets.appWriteBucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path, filename: file.name),
      );

      // Return a public URL to access the uploaded file
      return '${AppSecrets.appwriteUrl}/storage/buckets/${AppSecrets.appWriteBucketId}/files/${result.$id}/view?project=${AppSecrets.appWriteProjectId}';
    } on Exception catch (e) {
      print('Upload error: $e');
      return null;
    }
  }
}
