import 'package:photos/services/account.dart';
import 'package:photos/utils/s3/s3.dart';
import 'package:photos/utils/s3/s3_factory.dart';
import 'package:photos/utils/s3/storj.dart';

class StorjFactory extends S3Factory {
  final Account _account;

  StorjFactory(this._account);

  @override
  S3 build() {
    return Storj(
      _account.getS3Bucket(),
      _account.getS3SecretKeyId(),
      _account.getS3SecretKey(),
    );
  }
}
