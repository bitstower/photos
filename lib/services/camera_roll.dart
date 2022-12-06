import 'package:photo_manager/photo_manager.dart';

class CameraRoll {
  String? pathId;

  Future<String> getPathId() async {
    if (pathId != null) {
      return pathId!;
    }

    var results = await PhotoManager.getAssetPathList();
    for (var result in results) {
      if (result.name == 'Camera') {
        return pathId = result.id;
      }
    }

    throw Exception('Album not found');
  }

  Future<AssetPage> getPage(int minCreateDateSecond) async {
    var optionGroup = FilterOptionGroup();
    optionGroup = optionGroup.copyWith(
      createTimeCond: optionGroup.createTimeCond.copyWith(
        min: DateTime.fromMillisecondsSinceEpoch(minCreateDateSecond * 1000),
      ),
    );

    var path = await AssetPathEntity.obtainPathFromProperties(
      id: await getPathId(),
      optionGroup: optionGroup,
    );

    var total = await path.assetCountAsync;
    return AssetPage(path, 0, total);
  }
}

class AssetPage {
  static int defaultSize = 50;

  final AssetPathEntity path;
  final int page;
  final int total;

  AssetPage(this.path, this.page, this.total);

  Future<List<AssetEntity>> getEntities() async {
    return await path.getAssetListPaged(page: page, size: defaultSize);
  }

  AssetPage? getNextPage() {
    var newPage = page + 1;
    if (newPage < pageCount) {
      return AssetPage(path, newPage, total);
    } else {
      return null;
    }
  }

  int get pageCount {
    return (total / defaultSize).ceil();
  }
}
