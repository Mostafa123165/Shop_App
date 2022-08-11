import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_state.dart';
import 'package:shopapp/style/colors/color.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getDateFavourite(),
      child: BlocConsumer<HomeCubit, HomeMainState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ConditionalBuilder(
             // condition: state is! GetDataFavouriteLoadingState,
              condition: state is ! GetDataFavouriteLoadingState,
              //condition: state is! GetDataFavouriteLoadingState ,
              builder:(context)=>ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    BuilderFavouriteItems(index, context),
                     separatorBuilder: (context, index) =>
                    const SizedBox(
                      height: 10,
                    ),
                    itemCount: HomeCubit.get(context).modeGetDateFavourite!.data!.dateProducts.length,
              ),
              fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
            );
          }
      ),
    );
  }


  Widget BuilderFavouriteItems(int index, context) =>  Container(
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                CachedNetworkImage(
                  imageUrl: '${HomeCubit.get(context).modeGetDateFavourite!.data!.dateProducts[index].products!.image}',
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Image(image: AssetImage('assets/image/loading.gif'))),
                  height: 100.0,
                  width: 100.0,
                ),

                  if(HomeCubit.get(context).modeGetDateFavourite!.data!.dateProducts[index].products!.discount != 0 ) // discount
                Container(
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      '${HomeCubit
                          .get(context)
                          .modeGetDateFavourite!
                          .data!
                          .dateProducts[index].products!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${HomeCubit
                              .get(context)
                              .modeGetDateFavourite!
                              .data!
                              .dateProducts[index].products!.price}',
                          // '${shopModel.data!.products[index].price}',
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
                        if(HomeCubit
                            .get(context)
                            .modeGetDateFavourite!
                            .data!
                            .dateProducts[index].products!.discount != 0 )
                          Text(
                            '${HomeCubit
                                .get(context)
                                .modeGetDateFavourite!
                                .data!
                                .dateProducts[index].products!.oldPrice}',
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
                            print('hell');
                            HomeCubit.get(context).changeFavorites(HomeCubit
                                .get(context)
                                .modeGetDateFavourite!
                                .data!
                                .dateProducts[index].products!.id, index);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: HomeCubit.get(context).favourite[HomeCubit.get(context).modeGetDateFavourite!.data!.dateProducts[index].products!.id] == false ? Colors.grey[400] : defaultColor,
                            child: const Icon(
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
              ),
            )
          ],
        ),
      );
}
