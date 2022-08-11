import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_state.dart';
import 'package:shopapp/lay_out/shop_lay_out/model_shop/mode_shop.dart';
import 'package:shopapp/modules/category/model/model_categories.dart';
import 'package:shopapp/style/colors/color.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeMainState>(
      listener: (context, state) {
        if (state is ChangeSuccessFavoritesState) {
          if (state.model.status == false) {
            showToast(message: state.model.message.toString(),
                toastState: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit
              .get(context)
              .shopModel != null && HomeCubit
              .get(context)
              .categoriesModel != null,
          builder: (context) =>
              productsBuilder(HomeCubit
                  .get(context)
                  .shopModel, HomeCubit
                  .get(context)
                  .categoriesModel, context),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(ModelShop? shopModel, ModelCategories? categoriesModel,
      context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: shopModel?.data?.banners.length,
              itemBuilder: (context, index, _) {
                var item = shopModel!.data!.banners;
                return CachedNetworkImage(
                  imageUrl: item[index].image!,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Image(image: AssetImage('assets/image/loading.gif'))),
                  height: 250.0,
                  width: double.infinity,
                  fit:BoxFit.cover,
                );

              },
              options: CarouselOptions(
                height: 250.0,
                reverse: false,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 100.0,
                  width: double.infinity,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) =>
                        categoriesBuilder(categoriesModel!.data!.data[index]),
                    separatorBuilder: (context, index) =>
                    const SizedBox(
                      width: 10.0,
                    ),
                    itemCount: categoriesModel!.data!.data.length,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
            ),
            Container(
              //color: Colors.white,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.65,
                children: List.generate(
                  shopModel!.data!.products.length, (index) =>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            CachedNetworkImage(
                              imageUrl: '${shopModel.data!.products[index].image}',
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Center(child: Image(image: AssetImage('assets/image/loading.gif'))),
                              height: 200.0,
                                width: double.infinity,
                            ),

                            if(shopModel.data!.products[index].discount != 0 )
                              Container(
                                color: Colors.red,
                                child: Text(
                                  'DISCOUNT',
                                  style: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${shopModel.data!.products[index]
                                    .nameProduct}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${shopModel.data!.products[index].price}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: defaultColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  if(shopModel.data!.products[index].discount !=
                                      0 )
                                    Text(
                                      '${shopModel.data!.products[index]
                                          .oldPrice}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  const Spacer(),
                                  IconButton(
                                    padding: EdgeInsetsDirectional.zero,
                                    onPressed: () {
                                      HomeCubit.get(context).changeFavorites(
                                          shopModel.data!.products[index].id,
                                          index);
                                    },
                                    icon: CircleAvatar(
                                      radius: 15.0,
                                      backgroundColor: HomeCubit
                                          .get(context)
                                          .favourite[shopModel.data!
                                          .products[index].id] == false ? Colors
                                          .grey[400] : defaultColor,
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 18.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget categoriesBuilder(ModelData data) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl: '${data.image}',
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Center(child: Image(image: AssetImage('assets/image/loading.gif'))),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.0,
            height: 20.0,
            color: Colors.black.withOpacity(0.7),
            alignment: AlignmentDirectional.center,
            child: Text(
              '${data.name}',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );

}

