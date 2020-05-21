import 'package:discover/chat/main_chat.dart';
import 'package:discover/chat/screens/auth_screen.dart';
import 'package:discover/chat/screens/chat_screen.dart';
import 'package:discover/prod/main_app_screen.dart';
import 'package:discover/travel/util/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './screens/cart_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';
import './helpers/custom_route.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items,
              ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders,
              ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
              // title: 'MyShop',
              // theme: ThemeData(
              //   primarySwatch: Colors.purple,
              //   accentColor: Colors.deepOrange,
              //   fontFamily: 'Lato',
              //   pageTransitionsTheme: PageTransitionsTheme(
              //     builders: {
              //       TargetPlatform.android: CustomPageTransitionBuilder(),
              //       TargetPlatform.iOS: CustomPageTransitionBuilder(),
              //     },
              //   ),
              // ),
                 debugShowCheckedModeBanner: false,
               title: Constants.appName,
               theme: Constants.lightTheme,
              darkTheme: Constants.darkTheme,
                home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged, builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return SplashScreen();
                  }
                  if (userSnapshot.hasData) {
                    return MainAppScreenNavigation();
                   //return ProductsOverviewScreen();
                  }
                  return Auth2Screen();
                }),

              // home: auth.isAuth
              //     ? ProductsOverviewScreen()
              //     : FutureBuilder(
              //         future: auth.tryAutoLogin(),
              //         builder: (ctx, authResultSnapshot) =>
              //             authResultSnapshot.connectionState ==
              //                     ConnectionState.waiting
              //                 ? SplashScreen()
              //                 : AuthScreen(),
              //       ),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
                ChatScreen.routeName: (ctx) => ChatScreen(),
              },
            ),
      ),
    );
  }
}
