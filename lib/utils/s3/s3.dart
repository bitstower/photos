import 'dart:io';

import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:flutter/cupertino.dart';

abstract class S3 {
  static const contentType = 'application/octet-stream';

  @protected
  final String host;

  @protected
  final String bucket;

  @protected
  final String secretKeyId;

  @protected
  final String secretKey;

  S3(
    this.host,
    this.bucket,
    this.secretKeyId,
    this.secretKey,
  );

  @protected
  Uri getUri(String path) {
    return Uri.https(host, '/$bucket$path');
  }

  Future<AWSBaseHttpResponse> get(String path) async {
    return await send(AWSStreamedHttpRequest.get(
      getUri(path),
      headers: {
        AWSHeaders.host: host,
        AWSHeaders.contentType: contentType,
      },
    ));
  }

  Future<AWSBaseHttpResponse> put(File content, String path) async {
    return await send(
      AWSStreamedHttpRequest.put(
        getUri(path),
        body: content.openRead(),
        headers: {
          AWSHeaders.host: host,
          AWSHeaders.contentType: contentType,
        },
      ),
    );
  }

  @protected
  Future<AWSBaseHttpResponse> send(AWSBaseHttpRequest request) async {
    final signedRequest = await getSigner().sign(
      request,
      credentialScope: getCredentialScope(),
      serviceConfiguration: getServiceConfiguration(),
    );

    return await signedRequest.send(client: getHttpClient()).response;
  }

  @protected
  AWSSigV4Signer getSigner();

  @protected
  AWSCredentialScope getCredentialScope();

  @protected
  ServiceConfiguration getServiceConfiguration();

  @protected
  AWSCustomHttpClient getHttpClient();
}
