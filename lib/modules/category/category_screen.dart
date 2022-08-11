import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: HomeCubit.get(context).categoriesModel != null,
      builder: (context)=>ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index) =>Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Row(
            children: [
           CachedNetworkImage(
               imageUrl: '${HomeCubit.get(context).categoriesModel?.data?.data[index].image}',
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Center(child: Image(image: AssetImage('assets/image/loading.gif'))),
               height: 100.0,
               width: 100.0,
               fit: BoxFit.cover,
              ),

              const SizedBox(
                width: 10.0,
              ),
              Text(
                '${HomeCubit.get(context).categoriesModel?.data?.data[index].name}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(
                Icons.arrow_forward_ios_sharp,
              ))

            ],

          ),
        ),
        separatorBuilder: (context,index) =>const SizedBox(
          height: 10.0,
        ) ,
        itemCount: HomeCubit.get(context).categoriesModel!.data!.data.length,
      ),
      fallback: (context)=>const Center(child:CircularProgressIndicator()),
    );
  }
}
