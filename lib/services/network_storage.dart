import 'package:crypto/crypto.dart';
import 'dart:convert';

class NetworkStorage {
  final String endpoint;
  final String bucketName;
  final String accessKey;
  final String secretKey;

  NetworkStorage(
      this.endpoint, this.bucketName, this.accessKey, this.secretKey);

  String sign(String input, String secret) {
    var inputBytes = utf8.encode(input);
    var secretBytes = utf8.encode(secret);
    var outputBytes = Hmac(sha1, secretBytes).convert(inputBytes).bytes;
    return Uri.encodeComponent(base64.encoder.convert(outputBytes));
  }

  String buildUrl(String filePath) {
    final secondsSinceEpoch =
        (DateTime.now().toUtc().microsecondsSinceEpoch / 1000).floor();
    final expires = secondsSinceEpoch + (10 * 60);
    final stringToSign = "GET\n\n\n$expires\n/$bucketName$filePath";
    final signature = sign(stringToSign, secretKey);
    return 'https://$endpoint/$bucketName$filePath'
        '?AWSAccessKeyId=$accessKey&Signature=$signature&Expires=$expires';
  }
}

class StorjStorage extends NetworkStorage {
  StorjStorage(var bucketName, var accessKey, var secretKey)
      : super('gateway.storjshare.io', bucketName, accessKey, secretKey);
}

NetworkStorage buildNetworkStorage() {
  const bucketName = String.fromEnvironment("S3_BUCKET_NAME");
  const accessKey = String.fromEnvironment("S3_ACCESS_KEY");
  const secretKey = String.fromEnvironment("S3_SECRET_KEY");

  assert(bucketName.isNotEmpty);
  assert(accessKey.isNotEmpty);
  assert(secretKey.isNotEmpty);

  return StorjStorage(bucketName, accessKey, secretKey);
}
