class Account {
  String getS3Bucket() {
    return const String.fromEnvironment('S3_BUCKET_NAME');
  }

  String getS3SecretKeyId() {
    return const String.fromEnvironment('S3_ACCESS_KEY_ID');
  }

  String getS3SecretKey() {
    return const String.fromEnvironment('S3_SECRET_ACCESS_KEY');
  }
}
