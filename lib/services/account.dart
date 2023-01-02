import 'package:photos/journal/remote_journal_dsc.dart';
import 'package:uuid/uuid.dart';

import '../utils/context.dart';

class Account {
  final Uuid _uuid;
  final AccountContext _context;

  Account(this._uuid, this._context);

  String getS3Bucket() {
    return const String.fromEnvironment('S3_BUCKET_NAME');
  }

  String getS3SecretKeyId() {
    return const String.fromEnvironment('S3_ACCESS_KEY_ID');
  }

  String getS3SecretKey() {
    return const String.fromEnvironment('S3_SECRET_ACCESS_KEY');
  }

  Future<String> getDeviceUuid() async {
    var uuid = _context.getDeviceUuid();
    if (uuid == null) {
      uuid = _uuid.v4();
      await _context.setDeviceUuid(uuid);
    }
    return uuid;
  }

  Future<List<RemoteJournalInfo>> getRemoteJournalInfos() async {
    return [];
  }
}

class AccountContext extends Context {
  static const _deviceUuid = 'deviceId';

  AccountContext(super.jarId, super.jarDao);

  String? getDeviceUuid() => getValue(_deviceUuid);
  Future setDeviceUuid(String value) => setValue(_deviceUuid, value);
}
