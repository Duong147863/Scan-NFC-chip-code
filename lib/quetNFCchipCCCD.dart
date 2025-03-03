import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NfcReaderScreen extends StatefulWidget {
  @override
  _NfcReaderScreenState createState() => _NfcReaderScreenState();
}

class _NfcReaderScreenState extends State<NfcReaderScreen> {
  String _nfcResult = 'Chạm thẻ CCCD vào điện thoại để đọc thông tin';

  Future<void> _startNfc() async {
    try {
      setState(() {
        _nfcResult = 'Đang quét...';
      });

      final tag = await FlutterNfcKit.poll();

      if (tag != null) {
        setState(() {
          _nfcResult = 'Loại thẻ: ${tag.type}\nID: ${tag.id}\nStandard: ${tag.standard}\nATQA: ${tag.atqa}\nSAK: ${tag.sak}\nHistorical Bytes: ${tag.historicalBytes}';
        });
      }

      await FlutterNfcKit.finish();
    } catch (e) {
      setState(() {
        _nfcResult = 'Đã xảy ra lỗi khi quét thẻ: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quét NFC CCCD'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _nfcResult,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _startNfc,
              child: Text('Quét thẻ CCCD'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
