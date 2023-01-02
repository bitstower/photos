enum RecordType {
  postMedia(0);

  final int idx;

  const RecordType(this.idx);

  static RecordType fromNum(int idx) {
    switch (idx) {
      case 0:
        return postMedia;
      default:
        throw Exception('Unknown value');
    }
  }
}
