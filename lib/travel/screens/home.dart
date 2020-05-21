import 'package:discover/shop/providers/product.dart';
import 'package:discover/shop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:discover/travel/screens/details.dart';
import 'package:discover/travel/widgets/icon_badge.dart';
import 'package:discover/travel/util/places.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchControl = new TextEditingController();

  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        _showOnlyFavorites ? productsData.favoriteItems : productsData.items;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          IconButton(
            icon: IconBadge(
              icon: Icons.notifications_none,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Where are you \ngoing?",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.blueGrey[300],
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "E.g: New York, United States",
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.blueGrey[300],
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueGrey[300],
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
              ),
            ),
          ),
//           Container(
//             padding: EdgeInsets.only(top: 10, left: 20),
//             height: 250,
// //            color: Colors.red,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               primary: false,
//               itemCount: places == null ? 0 : places.length,
//               itemBuilder: (BuildContext context, int index) {
//                 Map place = places.reversed.toList()[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: InkWell(
//                     child: Container(
//                       height: 250,
//                       width: 140,
// //                      color: Colors.green,
//                       child: Column(
//                         children: <Widget>[
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.asset(
//                               "${place["img"]}",
//                               height: 178,
//                               width: 140,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           SizedBox(height: 7),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "${place["name"]}",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                               maxLines: 2,
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           SizedBox(height: 3),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "${place["location"]}",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 13,
//                                 color: Colors.blueGrey[300],
//                               ),
//                               maxLines: 1,
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     onTap: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) {
//                             return Details();
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
          Padding(
            padding: EdgeInsets.all(20),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products == null ? 0 : products.length,
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                      // builder: (c) => products[i],
                      value: products[i],

                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: InkWell(
                          child: Container(
                            height: 70,
//                    color: Colors.red,
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Hero(
                                    tag: products[i].id,
                                    child: FadeInImage(
                                      placeholder: AssetImage(
                                          'assets/images/product-placeholder.png'),
                                      image: NetworkImage(products[i].imageUrl),
                                      fit: BoxFit.cover,
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),

                                  //             child:
                                  //              Image.network(
                                  //           "${place.imageUrl}",
                                  //           height: 70,
                                  //               width: 70,
                                  //               fit: BoxFit.cover,
                                  // )
                                  // Image.asset(
                                  //   "${place.imageUrl}",
                                  //   height: 70,
                                  //   width: 70,
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  height: 80,
                                  width:
                                      MediaQuery.of(context).size.width - 175,
                                  child: ListView(
                                    primary: false,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${products[i].title}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            size: 13,
                                            color: Colors.blueGrey[300],
                                          ),
                                          SizedBox(width: 3),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${products[i].isFavorite}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: Colors.blueGrey[300],
                                              ),
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${products[i].price}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<Product>(
                                  builder: (ctx, product, _) => IconButton(
                                    icon: Icon(
                                      product.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                    ),
                                    color: Theme.of(context).accentColor,
                                    onPressed: () {
                                      product.toggleFavoriteStatus(
                                        "authData.token",
                                        "authData.userId",
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return Details();
                                },
                              ),
                            );
                          },
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
