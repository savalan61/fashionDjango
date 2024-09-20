import 'package:fashion_django/common/utils/kcolors.dart';
import 'package:fashion_django/common/widgets/app_style.dart';
import 'package:fashion_django/common/widgets/reusable_text.dart';
import 'package:fashion_django/src/wishList/viewModel/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../auth/controllers/riverpod/auth_notifier.dart';
import '../../auth/view/login_screen.dart';
import '../../products/views/widgets/staggered_tile_widget.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(authNotifierProvider).isLoggedIn;

    if (!isLoggedIn) {
      return const LoginScreen();
    }
    final wishListState = ref.watch(wishListNotifierProvider);
    return wishListState.when(
      data: (wishListProducts) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: ReusableText(
            text: 'Wishlist',
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  wishListProducts.length,
                  (index) {
                    final wishListProduct = wishListProducts[index];
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2.4,
                      child: StaggeredTileWidget(
                        i: index,
                        product: wishListProduct.product,
                        isWished: wishListProduct.isWished,
                        onTap: () {
                          // ref
                          //     .read(wishListNotifierProvider.notifier)
                          //     .toggleWishList(wishListProduct.product.id.toString());
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      error: (error, stackTrace) => const Center(child: Text('Something went wrong')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
// class WishlistScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Hesabım'),
//           actions: [
//             Icon(Icons.notifications),
//             SizedBox(width: 16),
//             Icon(Icons.more_vert),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // Search bar and avatar
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.blueAccent,
//                     child: Icon(Icons.person),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'İşCep\'te Ara',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//
//               // Account info
//               Card(
//                 elevation: 2,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Uydukent-Kurtköy/İstanbul', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 8),
//                       Text('TR11 0006 4000 0011 3550 1419 02'),
//                       SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Bakiye', style: TextStyle(fontSize: 16)),
//                           Text('485,70 TL', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 16),
//
//               // Recommendations
//               Card(
//                 elevation: 2,
//                 child: ListTile(
//                   leading: Icon(Icons.watch_later),
//                   title: Text('Günün özeti hazır! İncelemek ister misiniz?'),
//                   trailing: TextButton(onPressed: () {}, child: Text('İNCELE')),
//                 ),
//               ),
//
//               SizedBox(height: 16),
//
//               // Quick shortcuts
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ShortcutWidget(icon: Icons.receipt, label: 'Kayıtlı Faturalarım'),
//                   ShortcutWidget(icon: Icons.repeat, label: 'İşlem Tekrarla'),
//                   ShortcutWidget(icon: Icons.receipt_long, label: 'Dekontlarım'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
//             BottomNavigationBarItem(icon: Icon(Icons.sync_alt), label: 'Para Aktar'),
//             BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'İşlemler'),
//             BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Ödemeler'),
//             BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Harcamalar'),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ShortcutWidget extends StatelessWidget {
//   final IconData icon;
//   final String label;
//
//   ShortcutWidget({required this.icon, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, size: 32),
//         SizedBox(height: 8),
//         Text(label, style: TextStyle(fontSize: 12)),
//       ],
//     );
//   }
// }
