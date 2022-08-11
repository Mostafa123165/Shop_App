import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_state.dart';
import 'package:shopapp/modules/search/cubit/cubitSearch.dart';
import 'package:shopapp/modules/search/cubit/state.dart';

import 'package:shopapp/style/colors/color.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchControler = TextEditingController();
    var  searchKey = GlobalKey<FormState>() ;
    return BlocConsumer<SearchCubit,SearchState>(
      listener:(context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search Products',
              style: TextStyle(
              ),
            ),
            elevation: 0.0,
          ),
          body:Form(
            key: searchKey ,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      lapel:"Search",
                      controler: searchControler,
                      icon: Icon(Icons.search),
                      validator:(value){
                        if(value == null || value.isEmpty ){
                          return "Enter text to search ";
                        }
                        return null;
                      },
                      onFieldSubmitted:(value){
                        SearchCubit.get(context).search(value);
                      }
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if(state is LoadingSearchState)
                    const LinearProgressIndicator(),
                    const SizedBox(height:10,),
                     if(SearchCubit.get(context).modelSearch != null)
                     Expanded(
                     child:ListView.separated(
                       physics: BouncingScrollPhysics(),
                      itemBuilder:(context,index)=> builderFavouriteItems(index,context),
                      separatorBuilder:(context,state)=>const SizedBox(height: 15.0,),
                      itemCount:SearchCubit.get(context).modelSearch!.data!.data.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget builderFavouriteItems(int index, context) =>  Container(
    width: double.infinity,
    height: 100,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CachedNetworkImage(
              imageUrl:'${SearchCubit.get(context).modelSearch!.data!.data[index].image}',
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(child: Image(image: AssetImage('assets/image/loading.gif'))),
              height: 100.0,
              width: 100.0,
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  '${SearchCubit.get(context).modelSearch!.data!.data[index].name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${SearchCubit.get(context).modelSearch!.data!.data[index].price}',
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
                    const Spacer(),

                         BlocConsumer<HomeCubit,HomeMainState>(
                           listener: (context,state){},
                           builder: (context,state){
                             return IconButton(
                               padding: EdgeInsetsDirectional.zero,
                               onPressed: () {
                                 HomeCubit.get(context).changeFavorites(SearchCubit.get(context).modelSearch!.data!.data[index].id, index);
                               },
                               icon: CircleAvatar(
                                 radius: 15.0,
                                 backgroundColor: HomeCubit.get(context).favourite[SearchCubit.get(context).modelSearch!.data!.data[index].id] == false ? Colors.grey[400] : defaultColor,
                                 child: const Icon(
                                   Icons.favorite_border,
                                   size: 18.0,
                                   color: Colors.white,
                                 ),
                               ),
                             );
                           },
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
