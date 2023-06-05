import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_seoul/utils/colors.dart';

class TabScroll extends HookWidget {
  const TabScroll({super.key});

  @override
  Widget build(BuildContext context) {
    var tabController = useTabController(initialLength: 2);
    var gridController = useScrollController();
    var listController = useScrollController();
    var listPageNum = useState(20);
    var gridPageNum = useState(20);

    useEffect(() {
      listController.addListener(() {
        /// load date at when scroll reached -100
        if (listController.position.pixels >
            listController.position.maxScrollExtent - 100) {
          listPageNum.value += listPageNum.value;
        }
      });

      gridController.addListener(() {
        /// load date at when scroll reached -100
        if (gridController.position.pixels >
            gridController.position.maxScrollExtent - 100) {
          gridPageNum.value += gridPageNum.value;
        }
      });

      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('tab scroll'),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: TextStyle(
            color: AppColors.role.primary,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          unselectedLabelStyle: TextStyle(color: AppColors.text.placeholder),
          tabs: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Tab(
                text: 'grid',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Tab(
                text: 'list',
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                const Duration(seconds: 2),
                () {},
              );
            },
            child: GridView.builder(
              controller: gridController,
              padding: EdgeInsets.zero,
              itemCount: gridPageNum.value,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 9 / 14,
              ),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.amber,
                  child: Center(
                    child: Text('${index + 1}'),
                  ),
                );
              },
            ),
          ),
          RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                const Duration(seconds: 2),
                () {},
              );
            },
            child: ListView.builder(
              controller: listController,
              padding: EdgeInsets.zero,
              itemCount: listPageNum.value,
              itemExtent: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.green,
                  title: Text(
                    'Item ${index + 1}',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
