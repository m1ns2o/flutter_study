import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inflearn/common/const/data.dart';
import 'package:inflearn/restaurant/component/restaurant_card.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(
        headers: {
          'authorization': 'Bearer $accessToken',
        },
      ),
    );
    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder<List>(
                future: paginateRestaurant(),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      final item = snapshot.data![index];
                      return RestaurantCard(
                          image: Image.network(
                            'http://$ip${item['thumbUrl']}',
                            fit: BoxFit.cover,
                          ),
                          // image: Image.asset(
                          //   'asset/img/food/ddeok_bok_gi.jpg',
                          //   fit: BoxFit.cover, //전체 차지하게 설정
                          // ),
                          name: item['name'],
                          tags: List<String>.from(item['tags']),
                          ratingsCount: item['ratingsCount'],
                          deliveryTime: item['deliveryTime'],
                          deliveryFee: item['deliveryFee'],
                          ratings: item['ratings']);
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        height: 16.0,
                      );
                    },
                  );
                },
              )),
        ),
      ),
    );
  }
}
