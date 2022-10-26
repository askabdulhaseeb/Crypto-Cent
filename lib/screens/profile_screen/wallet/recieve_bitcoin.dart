import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/custom_widgets/custom_widget.dart';

class RecieveBitcoinScreen extends StatefulWidget {
  const RecieveBitcoinScreen({super.key});

  @override
  State<RecieveBitcoinScreen> createState() => _RecieveBitcoinScreenState();
}

class _RecieveBitcoinScreenState extends State<RecieveBitcoinScreen> {
  bool temp = false;
  @override
  Widget build(BuildContext context) {
    //WalletProvider walletPro = Provider.of<WalletProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const ForText(
                        name: 'Your Balance',
                        color: Colors.white,
                        bold: true,
                        size: 28,
                      ),
                      const ForText(
                        name: '\$ 0',
                        color: Colors.white,
                        bold: true,
                        size: 24,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)),
                        child: const Center(child: ForText(name: 'Bitcoin')),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  send(context, 'Add Money', Icons.add, () {}),
                  recieve(context, 'Send Money', Icons.arrow_drop_down_sharp,
                      () {}),
                ],
              ),
              const SizedBox(height: 20),
              temp == false
                  ? const SizedBox()
                  : Column(
                      children: <Widget>[
                        const Text(
                          'Your BTC Address :',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'walletPro.wallet!.coinsWallet.address',
                          //walletPro.walletadd,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        TextButton.icon(
                          onPressed: () async {
                            await Clipboard.setData(const ClipboardData(
                              text: 'walletPro.wallet!.coinsWallet.address',
                            ));
                          },
                          icon: const Icon(Icons.copy),
                          label: const Text('Copy Address'),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget send(
      BuildContext context, String name, IconData? icon, VoidCallback ontap) {
    return GestureDetector(
      onTap: () {
        setState(() {
          temp = !temp;
        });
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          color: temp
              ? Theme.of(context).primaryColor
              : Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                color: temp ? Colors.white : Colors.black,
                size: 46,
              ),
              ForText(
                name: name,
                color: temp ? Colors.white : Colors.black,
                bold: true,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget recieve(
      BuildContext context, String name, IconData? icon, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.black,
                size: 46,
              ),
              ForText(
                name: name,
                color: Colors.black,
                bold: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
