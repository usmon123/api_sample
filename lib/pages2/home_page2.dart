import 'package:flutter/material.dart';

import '../animations/animations.dart';
import '../service/api_respons.dart';
import '../viewmodels/home_page.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          title: const Text(
            'Valyuta kurslari',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _viewModel.apiResponse.status = Status.INITIAL;
                    _viewModel.getData().then((value) {
                      if (_viewModel.apiResponse.status != Status.ERROR) {
                        bottomSheet();
                      }
                    });
                  });
                },
                icon:   const Icon(
                  Icons.refresh,
                  color: Colors.black,
                  size: 24,
                ))
          ],
        ),
        body: FutureBuilder(
            future: _viewModel.getData(),
            builder: (context, AsyncSnapshot<ApiResponse> snapshot) {
              if (snapshot.data?.status == Status.LOADING) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data?.status == Status.ERROR) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Image(
                            height: 200,
                            width: 200,
                            image: AssetImage('assets/gifs/signal.gif'),
                          ),
                          Text(
                            'Qurilma internetga ulanmagan bo\'lishi mumkin, Iltimos internetingizni tekshirib ko\'ring',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _viewModel.apiResponse.status = Status.INITIAL;
                            _viewModel.getData().then((value) {
                              if (_viewModel.apiResponse.status !=
                                  Status.ERROR) {
                                bottomSheet();
                              }
                            });
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Qayta harakat qilib ko\'ring',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.green),
                            ),
                            Icon(
                              Icons.refresh,
                              color: Colors.green,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              if (snapshot.data?.status == Status.SUCCESS) {
                return ListView.builder(
                    itemCount: snapshot.data?.data.length,
                    itemBuilder: (ctx, index) {
                      var obj = snapshot.data?.data[index];
                      return Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0xfff5f5f5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: 15,
                                        width: 40,
                                        child: obj?.code != null
                                            ? Image.asset(
                                                'assets/images/${obj?.code}.jpg')
                                            : const Icon(Icons.flag_rounded)),
                                    Text(
                                      snapshot.data?.data[index].code ?? '..',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Expanded(child: Container()),
                                    InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.notifications_active_outlined,
                                          color: Colors.grey,
                                        ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        const Text(
                                          'MB kursi',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                        Text(snapshot
                                                .data?.data[index].cb_price ??
                                            '...'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Sotib olish',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                        Text(obj?.nbu_buy_price ?? '...'),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'Sotish',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                        Text(obj?.nbu_sell_price ?? '0'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
              return ColorLoader2(
                  color1: Colors.amber,
                  color2: Colors.green,
                  color3: Colors.orange);
            }));
  }

  void bottomSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'updated',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
