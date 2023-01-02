import '../record.dart';
import 'asset_view.dart';

class PostMediaView {
  // make sure keys don't overlap with keys in Event

  final _originAsset = 100;
  final _smThumbAsset = 101;
  final _mdThumbAsset = 102;
  final _lgThumbAsset = 103;

  final _type = 104;
  final _taken = 105;
  final _orientatedWidth = 106;
  final _orientatedHeight = 107;
  final _orientation = 108;
  final _duration = 109;

  final Record record;

  PostMediaView(this.record) {
    record.properties[_originAsset] ??= {};
    record.properties[_smThumbAsset] ??= {};
    record.properties[_mdThumbAsset] ??= {};
    record.properties[_lgThumbAsset] ??= {};
  }

  AssetView getOriginAsset() => AssetView(record.properties[_originAsset]);
  AssetView getSmThumbAsset() => AssetView(record.properties[_smThumbAsset]);
  AssetView getMdThumbAsset() => AssetView(record.properties[_mdThumbAsset]);
  AssetView getLgThumbAsset() => AssetView(record.properties[_lgThumbAsset]);

  int getType() => record.properties[_type];
  int getTaken() => record.properties[_taken];
  int getOrientatedWidth() => record.properties[_orientatedWidth];
  int getOrientatedHeight() => record.properties[_orientatedHeight];
  int getOrientation() => record.properties[_orientation];
  int getDuration() => record.properties[_duration];

  setType(int val) => record.properties[_type] = val;
  setTaken(int val) => record.properties[_taken] = val;
  setOrientatedWidth(int val) => record.properties[_orientatedWidth] = val;
  setOrientatedHeight(int val) => record.properties[_orientatedHeight] = val;
  setOrientation(int val) => record.properties[_orientation] = val;
  setDuration(int val) => record.properties[_duration] = val;
}
