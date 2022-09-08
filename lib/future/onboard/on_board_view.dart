import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_example/future/login/view/login_view.dart';
import 'package:flutter_provider_example/product/model/state/product_context.dart';
import 'package:provider/provider.dart';

import '../../product/padding/page_padding.dart';
import '../../product/widget/onboard_card.dart';
import 'onboard_model.dart';
import 'tab_indicator.dart';
import 'package:kartal/kartal.dart';

part './module/start_fab_button.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView>
    with SingleTickerProviderStateMixin {
  final String _skipTile = 'Skip';

  int _selectedIndex = 0;
  bool get _isLastPage =>
      OnBoardModels.onBoardItems.length - 1 == _selectedIndex;
  bool get _isFirstPage => _selectedIndex == 0;

  //---xx
  ValueNotifier<bool> isBackEnable = ValueNotifier(false); //---xx
  void _incrementAndChange([int? value]) {
    if (_isLastPage && value == null) {
      _changeBackEnable(true);
      return;
    }
    _changeBackEnable(false);

    _incrementSelectedPage(value);
  }

  void _changeBackEnable(bool value) {
    if (value == isBackEnable.value) return;

    isBackEnable.value = value;
  }

  void _incrementSelectedPage([int? value]) {
    setState(() {
      if (value != null) {
        _selectedIndex = value;
      } else {
        _selectedIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const PaddingPage.all(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _pageViewItems(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TabIndicator(
                  selectedIndex: _selectedIndex,
                ),
                _StartFabButton(
                  isLastPage: _isLastPage,
                  onPressed: () {
                    _incrementAndChange();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        context.watch<ProductContext>().newUserName,
        style: const TextStyle(color: Colors.red),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      leading: _isFirstPage
          ? null
          : IconButton(
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: isBackEnable,
          builder: (BuildContext context, dynamic value, Widget? child) {
            return value
                ? const SizedBox()
                : TextButton(
                    onPressed: () {
                      context.read<ProductContext>().changeName('veli');
                      context.navigateToPage(const LoginView());
                    },
                    child: Text(
                      _skipTile,
                    ),
                  );
          },
        ),
      ],
    );
  }

  Widget _pageViewItems() {
    return PageView.builder(
      onPageChanged: (value) {
        _incrementAndChange(value);
      },
      itemCount: OnBoardModels.onBoardItems.length,
      itemBuilder: (context, index) {
        return OnboardCard(
          model: OnBoardModels.onBoardItems[index],
        );
      },
    );
  }
}
