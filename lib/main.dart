import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_provider_example/future/onboard/on_board_view.dart';
import 'package:flutter_provider_example/product/model/state/product_context.dart';
import 'package:flutter_provider_example/product/model/state/user_context.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductContext()),

        // Provider(create: (context) => UserContext('a')),
        ProxyProvider<ProductContext, UserContext?>(
          update: ((context, productContext, userContext) {
            return userContext != null
                ? userContext.copyWith(name: productContext.newUserName)
                : UserContext(productContext.newUserName);
          }),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: const OnBoardView(),
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          backgroundColor: Colors.grey[100],
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromRGBO(11, 23, 84, 1),
          ),
        ),
      ),
    );
  }
}
