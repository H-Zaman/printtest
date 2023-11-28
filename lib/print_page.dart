import 'package:flutter/material.dart';
import 'package:flutter_pax_printer_utility/flutter_pax_printer_utility.dart';

class PrintPage extends StatefulWidget {
  const PrintPage({super.key});

  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Print demo'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/splash_logo.png'),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.large(
          onPressed: () async{
            try{
              await FlutterPaxPrinterUtility.init;

              PrinterStatus status = await FlutterPaxPrinterUtility.getStatus;

              if(status == PrinterStatus.SUCCESS){
                await FlutterPaxPrinterUtility.spaceSet(0, 10);
                await FlutterPaxPrinterUtility.setGray(1);
                await FlutterPaxPrinterUtility.printStr('TEST PRINT IMAGE', null);
                await FlutterPaxPrinterUtility.printImageAsset('assets/splash_logo.png');
                await FlutterPaxPrinterUtility.printStr('\nQR test\n', null);
                await FlutterPaxPrinterUtility.printQRCode('190237901273akshfaksdh', 512, 512);
                await FlutterPaxPrinterUtility.step(150);
                await FlutterPaxPrinterUtility.start();
              }else{
                debugPrint(status.name);
              }

            }catch(err){
              debugPrint(err.toString());
            }
          },
          child: const Text(
            'Print'
          ),
        ),
      ),
    );
  }
}
