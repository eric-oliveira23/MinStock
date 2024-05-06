import 'package:flutter/material.dart';
import 'package:minstock/features/inventory/inventory_page/inventory_page.dart';
import 'package:minstock/features/main_holder/main_holder_provider.dart';
import 'package:provider/provider.dart';

class HolderPage extends StatefulWidget {
  const HolderPage({Key? key}) : super(key: key);

  @override
  State<HolderPage> createState() => _HolderPageState();
}

class _HolderPageState extends State<HolderPage> with TickerProviderStateMixin {
  final List<String> _appBarTitles = ['Vendas', 'Estoque', 'Relatórios'];
  final MainHolderProvider _mainHolderProvider = MainHolderProvider();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => _mainHolderProvider.selectedIndex = _tabController.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _mainHolderProvider,
      child: Scaffold(
        appBar: AppBar(
          title: ListenableBuilder(
            listenable: _mainHolderProvider,
            builder: (_, child) => Text(
              _appBarTitles[_mainHolderProvider.selectedIndex],
            ),
          ),
          centerTitle: true,
        ),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(),
                    const InventoryPage(),
                    Container(),
                  ],
                ),
              ),
              Material(
                color: Theme.of(context).primaryColor,
                child: TabBar(
                  controller: _tabController,
                  splashBorderRadius: const BorderRadius.all(Radius.circular(20)),
                  // splashFactory: NoSplash.splashFactory,
                  dividerHeight: 0,
                  tabs: const [
                    Tab(child: Center(child: Icon(Icons.sell_outlined))),
                    Tab(child: Center(child: Icon(Icons.inventory_2_outlined))),
                    Tab(child: Center(child: Icon(Icons.stacked_bar_chart_sharp))),
                  ],
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
