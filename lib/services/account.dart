import 'package:photos/journal/remote_journal_dsc.dart';
import 'package:photos/utils/serializer.dart';
import 'package:uuid/uuid.dart';

import '../utils/context.dart';

class Account {
  final Uuid _uuid;
  final Context<AccountContext> _context;

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
    if (_context.data.deviceId == null) {
      _context.data.deviceId = _uuid.v4();
      await _context.persist();
    }
    return _context.data.deviceId!;
  }

  Future<List<RemoteJournalInfo>> getRemoteJournalInfos() async {
    return [];
  }
}

class AccountContext {
  String? deviceId;

  AccountContext({this.deviceId});
}

class AccountContextSerializer extends Serializer<AccountContext> {
  final _deviceId = 'deviceId';

  @override
  AccountContext fromJson(Map json) {
    return AccountContext(
      deviceId: json[_deviceId] as String?,
    );
  }

  @override
  Map toJson(AccountContext src) {
    var json = <String, dynamic>{};
    json[_deviceId] = src.deviceId;
    return Map.unmodifiable(json);
  }
}
