import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class FualDetailsScreen extends StatefulWidget {
  const FualDetailsScreen({Key key}) : super(key: key);

  @override
  State<FualDetailsScreen> createState() => _FualDetailsScreenState();
}

class _FualDetailsScreenState extends State<FualDetailsScreen> {
  Razorpay razorpay;

  TextEditingController quantity = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController textEditingController = new TextEditingController();

  FocusNode quantitynode = FocusNode();
  FocusNode pricenode = FocusNode();
  List<String> fuels = [
    'Petrol',
    'Diesel',
  ];
  String selectedfuel;
  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    quantitynode.dispose();
    pricenode.dispose();
    super.dispose();
    razorpay.clear();
  }

  void handlerPaymentSuccess() {
    print("Pament success");
    Toast.show("Pament success", context);
  }

  void handlerErrorFailure() {
    print("Pament error");
    Toast.show("Pament error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    Toast.show("External Wallet", context);
  }

  openCheckout() {
    var options = {
      "key": "rzp_test_2yTOiAOJBkqRol",
      "amount": num.parse(price.text) * 100,
      "name": "Sample App",
      "description": "Payment for ${selectedfuel} ",
      "prefill": {
        "contact": "9586829533",
        "email": "prajapatihet2611@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text(
            "Fuel Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Enter Details",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Fuel Type",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                                right: 8,
                              ),
                              child: DropdownButton(
                                hint: const Text(
                                  'Please choose a fuel type',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                underline: const SizedBox(),
                                borderRadius: BorderRadius.circular(15),
                                isExpanded: true,
                                value: selectedfuel,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedfuel = newValue;
                                  });
                                },
                                items: fuels.map((fuel) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      fuel,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    value: fuel,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Quantity (In Liters)",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            enabled: selectedfuel != null,
                            controller: quantity,
                            focusNode: quantitynode,
                            onSubmitted: (value) {
                              quantitynode.unfocus();
                              price.text = (double.parse(quantity.text) * 98.1)
                                  .toString();
                            },
                            onChanged: (value) {
                              if (value != "") {
                                price.text =
                                    (double.parse(value) * 98.1).toString();
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Enter Quantity",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            selectedfuel == null
                                ? ""
                                : selectedfuel == "Petrol"
                                    ? "1 Liter = 98.1 rupees"
                                    : "1 Liter = 98.1 rupees",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "Price (In Rupees)",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            enabled: selectedfuel != null,
                            controller: price,
                            focusNode: pricenode,
                            onChanged: (value) {
                              if (value != "") {
                                quantity.text =
                                    (double.parse(value) / 98.1).toString();
                              }
                            },
                            onSubmitted: (value) {
                              pricenode.unfocus();
                              quantity.text =
                                  (double.parse(price.text) / 98.1).toString();
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: "Enter Quantity",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            selectedfuel == null
                                ? ""
                                : selectedfuel == "Petrol"
                                    ? "98.1 rupees = 1 Liter"
                                    : "98.1 rupees = 1 Liter",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (selectedfuel != null) {
                        if (quantity != null && quantity.text != "") {
                          if (price != null && price.text != "") {
                            //Todo: Remove this Widget After Connecting Next Page
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: openCheckout(),
                                  );
                                  // return AlertDialog(
                                  //   title: const Center(
                                  //     child: Text(
                                  //       "Thank You!",
                                  //       style: TextStyle(
                                  //         color: Colors.black,
                                  //         fontSize: 20,
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   content: Column(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         "Type : $selectedfuel ",
                                  //       ),
                                  //       Text(
                                  //         "Quantity : ${quantity.text} liters",
                                  //       ),
                                  //       Text(
                                  //         "Price : ${price.text} rupees",
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   actions: [
                                  //     Center(
                                  //       child: RaisedButton(
                                  //         onPressed: () {
                                  //           Navigator.pop(context);
                                  //           Navigator.pop(context);
                                  //         },
                                  //         child: const Text(
                                  //           "Close",
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // );
                                });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: const [
                                    Icon(
                                      Icons.warning,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Please enter price"),
                                  ],
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: const [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Please enter quantity"),
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: const [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("Please Select Fuel Type"),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
