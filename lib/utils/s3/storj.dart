import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:photos/utils/s3/s3.dart';

class Storj extends S3 {
  static const _defaultRegion = 'us-east-1';
  static const _defaultEndpoint = 'gateway.storjshare.io';

  final AWSSigV4Signer _signer;
  final AWSCredentialScope _credentialScope;
  final S3ServiceConfiguration _serviceConfiguration;
  final AWSCustomHttpClient _httpClient;

  Storj(
    String bucket,
    String secretKeyId,
    String secretKey,
  )   : _signer = AWSSigV4Signer(
          credentialsProvider: StaticCredentialsProvider(
            AWSCredentials(secretKeyId, secretKey),
          ),
        ),
        _credentialScope = AWSCredentialScope(
          region: _defaultRegion,
          service: AWSService.s3,
        ),
        _serviceConfiguration = S3ServiceConfiguration(),
        _httpClient = _Http11Client(),
        super(_defaultEndpoint, bucket, secretKeyId, secretKey);

  @override
  AWSSigV4Signer getSigner() {
    return _signer;
  }

  @override
  AWSCredentialScope getCredentialScope() {
    return _credentialScope;
  }

  @override
  ServiceConfiguration getServiceConfiguration() {
    return _serviceConfiguration;
  }

  @override
  AWSCustomHttpClient getHttpClient() {
    return _httpClient;
  }
}

class _Http11Client extends AWSCustomHttpClient {
  _Http11Client() {
    // Storj supports only HTTP 1.1
    supportedProtocols = SupportedProtocols.http1;
  }
}
