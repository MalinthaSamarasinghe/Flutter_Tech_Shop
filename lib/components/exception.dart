/// Thrown during the Cloud Storage process if a failure occurs.
class CloudStorageFailure implements Exception {
  const CloudStorageFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase exception code.
  factory CloudStorageFailure.fromCode(String code) {
    switch (code) {
      case "storage/unknown":
        return const CloudStorageFailure(
          'An unknown error occurred.',
        );
      case "storage/object-not-found":
        return const CloudStorageFailure(
          'No object exists at the desired reference.',
        );
      case 'storage/bucket-not-found':
        return const CloudStorageFailure(
          'No bucket is configured for Cloud Storage.',
        );
      case 'storage/project-not-found':
        return const CloudStorageFailure(
          'No project is configured for Cloud Storage.',
        );
      case 'storage/quota-exceeded':
        return const CloudStorageFailure(
          "Quota on your Cloud Storage bucket has been exceeded. If you're on the no-cost tier, upgrade to a paid plan. If you're on a paid plan, reach out to Firebase support.",
        );
      case 'storage/unauthenticated':
        return const CloudStorageFailure(
          'User is not authorized to perform the desired action, check your security rules to ensure they are correct.',
        );
      case 'storage/retry-limit-exceeded':
        return const CloudStorageFailure(
          'The maximum time limit on an operation (upload, download, delete, etc.) has been exceeded. Try uploading again.',
        );
      case 'storage/invalid-checksum':
        return const CloudStorageFailure(
          'File on the client does not match the checksum of the file received by the server. Try uploading again.',
        );
      case 'storage/canceled':
        return const CloudStorageFailure(
          'User canceled the operation.',
        );
      case 'storage/invalid-event-name':
        return const CloudStorageFailure(
          'Invalid event name provided. Must be one of [running, progress, pause].',
        );
      case 'storage/invalid-url':
        return const CloudStorageFailure(
          'Invalid URL provided to refFromURL(). Must be of the form: gs://bucket/object or https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>.',
        );
      case 'storage/invalid-argument':
        return const CloudStorageFailure(
          'The argument passed to put() must be File, Blob, or UInt8 Array. The argument passed to putString() must be a raw, Base64, or Base64URL string.',
        );
      case 'storage/no-default-bucket':
        return const CloudStorageFailure(
          "No bucket has been set in your config's storageBucket property.",
        );
      case 'storage/cannot-slice-blob':
        return const CloudStorageFailure(
          "Commonly occurs when the local file has changed (deleted, saved again, etc.). Try uploading again after verifying that the file hasn't changed.",
        );
      case 'storage/server-file-wrong-size':
        return const CloudStorageFailure(
          'File on the client does not match the size of the file received by the server. Try uploading again.',
        );
      default:
        return const CloudStorageFailure();
    }
  }

  /// The associated error message.
  final String message;
}
