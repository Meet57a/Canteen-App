import 'package:canteenflutter/api/user-side-api/home-screen-components-api/delete_ordered_data.dart';
import 'package:canteenflutter/api/user-side-api/home-screen-components-api/get_orderd_data.dart';
import 'package:flutter/material.dart';

class GetOrderedDataForUser extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final userId;
  const GetOrderedDataForUser({Key? key, required this.userId})
      : super(key: key);

  @override
  State<GetOrderedDataForUser> createState() => _GetOrderedDataForUserState();
}

class _GetOrderedDataForUserState extends State<GetOrderedDataForUser> {
  @override
  void initState() {
    super.initState();
    GetOrderedDataToUser.getOrderProduct(widget.userId);
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      GetOrderedDataToUser.getOrderProduct(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 75),
            child: SizedBox(
              height: 50,
              width: 200,
              // decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Orders"),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: GetOrderedDataToUser.getOrderProduct(widget.userId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<GetOrderedData> pdata = snapshot.data;
              if (pdata.isEmpty) {
                return const Center(
                  child: Text("No Order"),
                );
              }
              return ListView.builder(
                itemCount: pdata.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.white,
                            shadowColor: Colors.grey[400],
                            child: SizedBox(
                              height: 200,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff65b08),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.network(
                                          'https://pub-c2ce9a1d454a457ba9303eb6f3de07a2.r2.dev/${pdata[index].productId}')),
                                  Container(
                                    height: 180,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Coustomer Name : ${pdata[index].coustomerName}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "Product Name : ${pdata[index].proname}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "Total Price : ${pdata[index].proprice}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "Cabin No : ${pdata[index].cabinno}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            DeleteOrderedDataApiUser
                                                .deleteOrderedDatUser(
                                                    pdata[index].orderId);
                                            pdata.removeAt(index);
                                            setState(() {});
                                          },
                                          child: const Text("Cancle Order"),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
