import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worldsocialintegrationapp/main.dart';
import 'package:worldsocialintegrationapp/models/games_model.dart';
import 'package:worldsocialintegrationapp/utils/prefs_key.dart';
import 'package:worldsocialintegrationapp/widgets/custom_webview.dart';
import 'package:worldsocialintegrationapp/widgets/default_page_loader.dart';

import '../../../providers/api_call_provider.dart';
import '../../../utils/dimensions.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<GamesModel> list = [];
  List<GamesModel> bettingGames = [];
  List<GamesModel> nonbettingGames = [];
  late ApiCallProvider apiCallProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData();
    });
  }

  loadData() async {
    await apiCallProvider
        .getRequest(
            'https://xrdsimulators.tech/wow_project/index.php/listGameSectionDetails')
        .then((value) {
      list.clear();
      if (value['data'] != null) {
        for (var item in value['data']) {
          list.add(GamesModel.fromJson(item));
          bettingGames =
              list.where((item) => item.gameType == 'Betting').toList();
          nonbettingGames =
              list.where((item) => item.gameType == 'Nonbetting').toList();
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    apiCallProvider = Provider.of<ApiCallProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: apiCallProvider.status == ApiStatus.loading
          ? const DefaultPageLoader()
          : ListView(
              padding: EdgeInsets.zero,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    'Betting Games',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: const EdgeInsets.all(10),
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1),
                  itemCount: bettingGames.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          CustomWebview.route,
                          arguments:
                              '${bettingGames.elementAt(index).link}${prefs.getString(PrefsKey.userId)}&gameId=${bettingGames.elementAt(index).id}'),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          imageUrl: bettingGames.elementAt(index).image ?? '',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Text('Error ${error.toString()}'),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    'Non-Betting Games',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                GridView.builder(
                  padding: const EdgeInsets.all(10),
                  primary: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1),
                  itemCount: nonbettingGames.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).pushNamed(
                          CustomWebview.route,
                          arguments:
                              '${nonbettingGames.elementAt(index).link}${prefs.getString(PrefsKey.userId)}&gameId=${nonbettingGames.elementAt(index).id}'),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              nonbettingGames.elementAt(index).image ?? '',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Center(
                            child: Text('Error ${error.toString()}'),
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }

  Padding getPopulerGamesButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: pagePadding,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xfff83302),
                      Color(0xfffbc100),
                      Color(0xfff83302),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'Popular Games',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
