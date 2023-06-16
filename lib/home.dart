// // Copyright 2018-present the Flutter authors. All Rights Reserved.
// //
// // Licensed under the Apache License, Version 2.0 (the "License");
// // you may not use this file except in compliance with the License.
// // You may obtain a copy of the License at
// //
// // http://www.apache.org/licenses/LICENSE-2.0
// //
// // Unless required by applicable law or agreed to in writing, software
// // distributed under the License is distributed on an "AS IS" BASIS,
// // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// // See the License for the specific language governing permissions and
// // limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/profile.dart';
import 'package:shrine/roulette.dart';
import 'package:shrine/selectgame.dart';

import 'add.dart';
import 'model/product.dart';
import 'model/products_repository.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.person,
            semanticLabel: 'profile',
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          },
        ),
        title: const Text('Gollaba'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('logos/logo_black.png'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectGameApp()),
                      );
                    },
                    child: const Text('선택장애 골라바',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1170C3),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RouletteApp()),
                      );
                    },
                    child: const Text('룰렛으로 골라바',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1170C3),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                    },
                    child: Text('마니또를 골라바'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1170C3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);

//   get selectedProduct => null;

//   List<StatelessWidget> _buildGridCards(BuildContext context) {
//     List<Product> products = ProductsRepository.loadProducts(Category.all);

//     if (products.isEmpty) {
//       return const <Card>[];
//     }

//     final ThemeData theme = Theme.of(context);
//     final NumberFormat formatter = NumberFormat.simpleCurrency(
//         locale: Localizations.localeOf(context).toString());

//     return products.map((product) {
//       return GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SelectGameApp(),
//             ),
//           );
//         },
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               AspectRatio(
//                 aspectRatio: 18 / 11,
//                 child: Image.asset(
//                   product.assetName,
//                   package: product.assetPackage,
//                   fit: BoxFit.fitWidth,
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         product.name,
//                         style: theme.textTheme.titleLarge,
//                         maxLines: 1,
//                       ),
//                       const SizedBox(height: 8.0),
//                       Text(
//                         formatter.format(product.price),
//                         style: theme.textTheme.titleSmall,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(
//             Icons.person,
//             semanticLabel: 'profile',
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ProfilePage()),
//             );
//           },
//         ),
//         title: const Text('Gollaba'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.add,
//               semanticLabel: 'add',
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => AddPage()),
//               );
//             },
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.search,
//               semanticLabel: 'search',
//             ),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(
//               Icons.tune,
//               semanticLabel: 'filter',
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         padding: const EdgeInsets.all(16.0),
//         childAspectRatio: 8.0 / 9.0,
//         children: _buildGridCards(context),
//       ),
//       resizeToAvoidBottomInset: false,
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shrine/roulette.dart';
// import 'selectgame.dart';





