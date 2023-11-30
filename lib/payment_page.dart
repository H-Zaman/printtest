import 'package:flutter/material.dart';
import 'package:ezetap_sdk/ezetap_sdk.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  String? result1;
  String? result2;
  String? error;

  final keyController = TextEditingController();
  final amountController = TextEditingController();
  final mNameController = TextEditingController();
  final uNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Payment demo'),),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        children: [

          TextField(
            controller: keyController,
            decoration: InputDecoration(
              hintText: 'Enter key'
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: mNameController,
            decoration: InputDecoration(
              hintText: 'Enter merchant name'
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: uNameController,
            decoration: InputDecoration(
              hintText: 'Enter user name'
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: amountController,
            decoration: InputDecoration(
                hintText: 'Enter amount'
            ),
          ),
          SizedBox(height: 12),

          if(result1 != null) Text(result1!),
          SizedBox(height: 12),
          if(result2 != null) Text(result2!),
          SizedBox(height: 12),
          if(error != null) Text(error!),

          ElevatedButton(onPressed: () async{
            try{
              final json = {
                "prodAppKey": keyController.text,
                "demoAppKey": keyController.text,
                "merchantName": mNameController.text,
                "userName": uNameController.text,
                "currencyCode": 'INR',
                "appMode": "DEMO",
                "captureSignature": 'true',
                "prepareDevice": 'false',
                "captureReceipt": 'false'
              };
              final result = await EzetapSdk.initialize(json);
              setState(() {
                result1 = result;
              });

              var data = {
                "amount": amountController.text,
                "options": {
                  "paymentMode": 'UPI',
                  "customer": {
                    "name": "user_name",
                    "mobileNo": "1234567890",
                    "email": "user@email.com"
                  }
                }
              };
              final response = await EzetapSdk.pay(data);
              setState(() {
                result2 = response;
              });
            }catch(err){
              setState(() {
                error = err.toString();
              });
            }

          }, child: Text('Initialize and Pay')),

        ],
      )
    );
  }
}
