import 'package:flutter/material.dart';
import 'package:flutter_provider_example/future/login/viewModel/login_view_model.dart';
import 'package:flutter_provider_example/product/constant/image_enum.dart';
import 'package:flutter_provider_example/product/model/state/user_context.dart';
import 'package:flutter_provider_example/product/padding/page_padding.dart';
import 'package:flutter_provider_example/product/utility/input_decorations.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final name = 'Name';

  final login = 'Login';

  final rememberMe = 'Remember Me';

  late final LoginViewModel _loginViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(context.read<UserContext?>()?.name);
    _loginViewModel = LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loginViewModel,
      builder: (context, child) {
        return _bodyView(context);
      },
    );
  }

  Scaffold _bodyView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<UserContext?>()?.name ?? '',
          style: const TextStyle(color: Colors.black),
        ),
        leading: _loadingWidget(),
      ),
      body: Padding(
        padding: const PaddingPage.all(),
        child: Column(
          children: [
            AnimatedContainer(
              duration: context.durationLow,
              height: context.isKeyBoardOpen ? 0 : context.dynamicHeight(0.2),
              width: context.dynamicWidth(0.3),
              child: ImageEnums.door.toImage,
            ),
            Text(
              login,
              style: context.textTheme.headline3,
            ),
            TextField(
              decoration: ProjectInput(name),
            ),
            ElevatedButton(
              onPressed: _loginViewModel.isLoading
                  ? null
                  : () {
                      context.read<LoginViewModel>().controlTextValue();
                    },
              child: Center(child: Text(login)),
            ),
            CheckboxListTile(
              value: _loginViewModel.isCheckBoxOkay,
              title: Text(rememberMe),
              onChanged: (value) {
                _loginViewModel.checkBoxChange(value ?? false);
                // _loginViewModel.checkBoxChange(value ?? false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Selector<LoginViewModel, bool>(builder: ((context, value, child) {
      return value
          ? const Center(child: CircularProgressIndicator())
          : const SizedBox();
    }), selector: (context, viewModel) {
      return viewModel.isLoading == true;
    });
    // return Consumer<LoginViewModel>(
    //   builder: ((context, value, child) {
    //     return value.isLoading
    //         ? const Center(child: CircularProgressIndicator())
    //         : const SizedBox();
    //   }),
    // );
  }
}
