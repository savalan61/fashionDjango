import 'package:fashion_django/const/resource.dart';
import 'package:fashion_django/src/categories/models/categories_model.dart';
import 'package:flutter/cupertino.dart';

import '../common/utils/kcolors.dart';
import '../src/products/models/product_model.dart';

LinearGradient kGradient = const LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kWhite,
    Kolors.kPrimary,
  ],
);

LinearGradient kPGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kPrimaryLight.withOpacity(0.7),
    Kolors.kPrimary,
  ],
);

LinearGradient kBtnGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.bottomRight,
  colors: [
    Kolors.kPrimaryLight,
    Kolors.kWhite,
  ],
);

BorderRadiusGeometry kClippingRadius = const BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

BorderRadiusGeometry kRadiusAll = BorderRadius.circular(12);

BorderRadiusGeometry kRadiusTop = const BorderRadius.only(
  topLeft: Radius.circular(9),
  topRight: Radius.circular(9),
);

BorderRadiusGeometry kRadiusBottom = const BorderRadius.only(
  bottomLeft: Radius.circular(12),
  bottomRight: Radius.circular(12),
);

Widget Function(BuildContext, String)? placeholder = (p0, p1) => Image.asset(
      R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
      fit: BoxFit.cover,
    );

Widget Function(BuildContext, String, Object)? errorWidget = (p0, p1, p3) => Image.asset(
      R.ASSETS_IMAGES_PLACEHOLDER_WEBP,
      fit: BoxFit.cover,
    );

List<String> images = [
  'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3',
  'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3',
  'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3',
  'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3',
  'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fslider1.png?alt=media&token=8b27e621-e5ea-4ba4-ab15-0302d02c75f3',
];

List<CategoryModel> categories = [
  CategoryModel(
    id: 1,
    title: 'Pants',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjeans.svg?alt=media&token=eb62f916-a4c2-441a-a469-5684f1a62526',
  ),
  CategoryModel(
    id: 5,
    title: 'T-Shirts',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjersey.svg?alt=media&token=6ca7eabd-54b3-47bb-bb8f-41c3a8920171',
  ),
  CategoryModel(
    id: 3,
    title: 'Sneakers',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Frunning_shoe.svg?alt=media&token=0dcb0e57-315e-457c-89dc-1233f6421368',
  ),
  CategoryModel(
    id: 2,
    title: 'Dresses',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fdress.svg?alt=media&token=cf832383-4c8a-4ee1-9676-b66c4d515a1c',
  ),
  CategoryModel(
    id: 4,
    title: 'Jackets',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjacket.svg?alt=media&token=ffdc9a1e-917f-4e8f-b58e-4df2e6e8587e',
  ),
  CategoryModel(
    id: 11,
    title: 'Pants',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjeans.svg?alt=media&token=eb62f916-a4c2-441a-a469-5684f1a62526',
  ),
  CategoryModel(
    id: 15,
    title: 'T-Shirts',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjersey.svg?alt=media&token=6ca7eabd-54b3-47bb-bb8f-41c3a8920171',
  ),
  CategoryModel(
    id: 13,
    title: 'Sneakers',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Frunning_shoe.svg?alt=media&token=0dcb0e57-315e-457c-89dc-1233f6421368',
  ),
  CategoryModel(
    id: 12,
    title: 'Dresses',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fdress.svg?alt=media&token=cf832383-4c8a-4ee1-9676-b66c4d515a1c',
  ),
  CategoryModel(
    id: 14,
    title: 'Jackets',
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Fjacket.svg?alt=media&token=ffdc9a1e-917f-4e8f-b58e-4df2e6e8587e',
  ),
];

final List<ProductModel> products = [
  ProductModel(
    id: 3,
    title: 'Converse Chuck Taylor All Star',
    price: 60,
    description:
        'The classic Chuck Taylor All Star sneaker from Converse, featuring a timeless design and comfortable fit.',
    isFeatured: true,
    clothesType: 'kids',
    rating: 4.333333333333333,
    colors: ['black', 'white', 'red'],
    imageUrls: [
      'https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fw.png?alt=media&token=2b56983c-1fb0-4961-b3b2-8e6739303df8',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Ftbr.png?alt=media&token=10290e90-da19-48c4-8a01-f0cf6a8f3082',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fs.png?alt=media&token=51f757de-4bdb-4cd1-99e7-a2b91acefb12',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fqwe.png?alt=media&token=095b461e-90e2-45a1-a0c6-e5ae1a330cf5',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fimage1.png?alt=media&token=8e484d55-1980-4755-83d1-8e2a211aa399',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fimage.png?alt=media&token=ad864eae-2e0b-4b2a-b36f-cd53468c3d65',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fim1age.png?alt=media&token=17c57ae9-5960-45a4-b2e1-eae7303c560a',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fi1mage.png?alt=media&token=9eddb03c-b40a-4650-bb4a-2418ce15077f',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Few.png?alt=media&token=6b5e087e-52af-489a-b911-e0f0c0ee726b',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Feq.png?alt=media&token=f6dbf6b9-1977-4154-97c2-5745278a094b',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fed.png?alt=media&token=dc80d4a8-09a3-4d10-912e-031e2aeeb1c0',
      'https://firebasestorage.googleapis.com/v0/b/e-commerce-app-a468c.appspot.com/o/fashion_django%2Fproducts%2Fall%2Fds.png?alt=media&token=54b74441-0c19-4a26-8749-f54724f38253',
    ],
    sizes: ['7', '8', '9', '10', '11'],
    createdAt: DateTime.parse('2024-06-06T07:57:45Z'),
    category: 3,
    brand: 1,
  ),
  ProductModel(
    id: 1,
    title: 'LV Trainers',
    price: 798.88,
    description:
        'LV Trainers blend sleek style with athletic functionality, featuring bold logos, premium materials, and comfortable designs that elevate your everyday look with a touch of luxury.',
    isFeatured: true,
    clothesType: 'women',
    rating: 4.5,
    colors: ['white', 'black', 'red'],
    imageUrls: [
      'https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp',
      'https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp'
    ],
    sizes: ['7', '8', '9'],
    createdAt: DateTime.parse('2024-06-06T07:49:15Z'),
    category: 3,
    brand: 1,
  ),
  ProductModel(
    id: 2,
    title: 'Adidas Ultraboost',
    price: 180,
    description: 'Experience the comfort and energy return of the Ultraboost, designed for running and everyday wear.',
    isFeatured: true,
    clothesType: 'unisex',
    rating: 5.0,
    colors: ['navy', 'grey', 'blue'],
    imageUrls: [
      'https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp',
      'https://media.cnn.com/api/v1/images/stellar/prod/220210051008-04-lv-virgil-abloh.jpg?q=w_2000,c_fill/f_webp'
    ],
    sizes: ['7', '8', '9', '10', '11', '12', '13'],
    createdAt: DateTime.parse('2024-06-06T07:55:20Z'),
    category: 3,
    brand: 1,
  ),
];

String avatar =
    'https://firebasestorage.googleapis.com/v0/b/authenification-b4dc9.appspot.com/o/uploads%2Favatar.png?alt=media&token=7da81de9-a163-4296-86ac-3194c490ce15';
