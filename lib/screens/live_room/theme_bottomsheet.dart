import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:worldsocialintegrationapp/widgets/gaps.dart';

class ThemeBottomsheet extends StatefulWidget {
  const ThemeBottomsheet({super.key});

  @override
  State<ThemeBottomsheet> createState() => _ThemeBottomsheetState();
}

class _ThemeBottomsheetState extends State<ThemeBottomsheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6, // Set height to 60% of screen height
      child: ClipRRect(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.green,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                      ),
                      labelPadding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                      indicatorPadding: const EdgeInsets.only(bottom: 10),
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      tabs: const [
                        Tab(
                          text: 'THEME',
                        ),
                        Tab(
                          text: 'STORE',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    freeTheme(),
                    storeTheme(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  freeTheme() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            'Free',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        verticalGap(10),
        Expanded(
          child: GridView.builder(
            primary: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9),
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ36L_LsmTuC3V9RcegbAllAkZ-WUPfcHsEgg&s',
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text('Error ${error.toString()}'),
                    ),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  storeTheme() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            primary: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7),
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://64.media.tumblr.com/ff30f5bbc325a949470d2ee77e1ac731/tumblr_meu0bgLQhQ1r3bteso1_500.gif',
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text('Error ${error.toString()}'),
                        ),
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time_filled,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                horizontalGap(5),
                                const Text(
                                  '4 days',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.preview_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '8000 coins',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.red,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Buy',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Send',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
