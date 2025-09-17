import 'package:flutter/material.dart';
import 'package:flutter_sportly_2/presentation/views/home_view.dart';
import 'package:flutter_sportly_2/presentation/widgets/customer_navigatior.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';
  final int pageIndex;
  final String code;

  const HomeScreen({
    super.key,
    required this.pageIndex,
    required this.code,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Lógica para actualizar la vista según el pageIndex
    if (pageController.hasClients) {
      pageController.animateToPage(
        widget.pageIndex,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250),
      );
    }

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
        HomeView(code: widget.code),
         Placeholder(),
         Placeholder()
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: widget.pageIndex,
        code: widget.code,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}