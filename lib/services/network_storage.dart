import 'dart:io';

import 'package:aws_common/aws_common.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:aws_signature_v4/aws_signature_v4.dart';

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

  Future upload(String name, File file) async {
    const region = 'us-east-1';
    const host = 'gateway.storjshare.io';

    const signer = AWSSigV4Signer();

    final scope = AWSCredentialScope(
      region: region,
      service: AWSService.s3,
    );

    final serviceConfiguration = S3ServiceConfiguration();

    final stream = file.openRead();
    final path = '/$bucketName/$name';
    print('==>' + Uri.https(host, path).toString());
    final uploadRequest = AWSStreamedHttpRequest.put(
      Uri.https(host, path),
      body: stream,
      headers: {
        AWSHeaders.host: host,
        AWSHeaders.contentType: 'text/plain',
      },
    );

    print('Uploading file to $path...');
    final signedUploadRequest = await signer.sign(
      uploadRequest,
      credentialScope: scope,
      serviceConfiguration: serviceConfiguration,
    );
    try {
      final uploadResponse =
          await signedUploadRequest.send(client: MyHttpClient()).response;
      final body = await uploadResponse.decodeBody();
      final uploadStatus = uploadResponse.statusCode;
      print('Upload File Response: $uploadStatus body=$body');
    } catch (e) {
      print('==>');
      print(e.toString());
    }
  }
}

class MyHttpClient extends AWSCustomHttpClient {
  MyHttpClient() {
    supportedProtocols = SupportedProtocols.http1;
  }
}

class StorjStorage extends NetworkStorage {
  StorjStorage(var bucketName, var accessKey, var secretKey)
      : super('gateway.storjshare.io', bucketName, accessKey, secretKey);
}

NetworkStorage buildNetworkStorage() {
  const bucketName = String.fromEnvironment("S3_BUCKET_NAME");
  const accessKey = String.fromEnvironment("AWS_ACCESS_KEY_ID");
  const secretKey = String.fromEnvironment("AWS_SECRET_ACCESS_KEY");

  assert(bucketName.isNotEmpty);
  assert(accessKey.isNotEmpty);
  assert(secretKey.isNotEmpty);

  return StorjStorage(bucketName, accessKey, secretKey);
}
