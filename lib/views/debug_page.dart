import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photos/services/local_media_replicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/media.dart';
import '../services/database.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  List<_Property> cfgProps = [];
  List<_Property> dbProps = [];

  Future resetDatabase() async {
    var database = GetIt.I.get<Database>();
    var connection = database.open();
    await connection.writeTxn(() async {
      await connection.clear();
    });
  }

  Future resetConfiguration() async {
    var configuration = await GetIt.I.getAsync<SharedPreferences>();
    await configuration.clear();
  }

  Future resetCache() async {
    imageCache.clear();
    imageCache.clearLiveImages();
    await PhotoManager.clearFileCache();
  }

  Future synchronize() async {
    var localMediaStore = await GetIt.I.getAsync<LocalMediaReplicator>();
    await localMediaStore.replicate();
  }

  Future<List<_Property>> loadCfgProps() async {
    var c = await GetIt.I.getAsync<SharedPreferences>();
    var kMinCreateDateSecondKey = LocalMediaReplicator.kMinCreateDateSecondKey;
    return [
      _Property(
        kMinCreateDateSecondKey,
        c.getInt(kMinCreateDateSecondKey).toString(),
      ),
    ];
  }

  Future<List<_Property>> loadDbProps() async {
    var database = GetIt.I.get<Database>();
    var connection = database.open();

    var mediasCount = await connection.medias.count();
    var dbSize = await connection.getSize(
      includeIndexes: true,
      includeLinks: true,
    );

    return [
      _Property(
        'db.medias.count',
        mediasCount.toString(),
      ),
      _Property(
        'db.sizeInBytes',
        dbSize.toString(),
      ),
    ];
  }

  refresh() {
    loadCfgProps().then((props) {
      setState(() {
        cfgProps = props;
      });
    });
    loadDbProps().then((props) {
      setState(() {
        dbProps = props;
      });
    });
  }

  @override
  initState() {
    super.initState();
    refresh();
  }

  ListTile buildTile(_Property property) {
    return ListTile(
      title: Text(property.key),
      subtitle: Text(property.value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Back',
            onPressed: () => GoRouter.of(context).pop(),
          ),
          actions: [
            PopupMenuButton<_Menu>(
              onSelected: (_Menu item) async {
                if (item == _Menu.resetConfiguration) {
                  await resetConfiguration();
                  refresh();
                }
                if (item == _Menu.resetDatabase) {
                  await resetDatabase();
                  refresh();
                }
                if (item == _Menu.resetCache) {
                  await resetCache();
                }
                if (item == _Menu.synchronize) {
                  await synchronize();
                  refresh();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<_Menu>>[
                const PopupMenuItem<_Menu>(
                  value: _Menu.resetConfiguration,
                  child: Text('Reset Configuration'),
                ),
                const PopupMenuItem<_Menu>(
                  value: _Menu.resetDatabase,
                  child: Text('Reset Database'),
                ),
                const PopupMenuItem<_Menu>(
                  value: _Menu.resetCache,
                  child: Text('Reset Cache'),
                ),
                const PopupMenuItem<_Menu>(
                  value: _Menu.synchronize,
                  child: Text('Synchronize'),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Configuration'),
              Tab(text: 'Database'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: cfgProps.length,
              itemBuilder: (BuildContext context, int index) {
                return buildTile(cfgProps[index]);
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: dbProps.length,
              itemBuilder: (BuildContext context, int index) {
                return buildTile(dbProps[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Property {
  final String key;
  final String value;

  _Property(this.key, this.value);
}

enum _Menu {
  resetDatabase,
  resetConfiguration,
  resetCache,
  synchronize,
}
