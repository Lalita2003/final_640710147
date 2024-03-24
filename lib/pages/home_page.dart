import 'dart:convert';
import 'package:final_640710147/models/todo_item.dart';
import 'package:flutter/material.dart';
import '../helpers/api_caller.dart';
import '../helpers/dialog_utils.dart';
import '../models/todo_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _url = '';
  String _details = '';
  String _selectedWebType = '';

  List<Map<String, dynamic>> webTypes = [
    {
      "id": "gambling",
      "title": "เว็บพนัน",
      "subtitle": "การพนัน แทงบอล และอื่นๆ",
      "image": "/images/webby_fondue/gambling.jpg"
    },
    {
      "id": "fraud",
      "title": "เว็บปลอมแปลง",
      "subtitle": "หลอกให้กรอกข้อมูลส่วนตัว/รหัสผ่าน",
      "image": "/images/webby_fondue/fraud.png"
    },
    {
      "id": "fake-news",
      "title": "เว็บข่าวมั่ว",
      "subtitle": "Fake news, ข้อมูลที่ทำให้เข้าใจผิด",
      "image": "/images/webby_fondue/fake_news_2.jpg"
    },
    {
      "id": "share",
      "title": "เว็บแชร์ลูกโซ่",
      "subtitle": "หลอกลงทุน",
      "image": "/images/webby_fondue/thief.jpg"
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitReport() async {
    if (_url.isEmpty) {
      await showOkDialog(
        context: context,
        title: 'Error',
        message: 'ต้องกรอก URL และเลือกประเภทเว็บ',
      );
      return;
    }

    try {
      final data = await ApiCaller().post(
        "2_2566/final/report_web",
        params: {
          "url": _url,
          "description": _details,
          "type": "default_web_type_id", // ระบุ ID ของประเภทเว็บที่ต้องการส่งเข้าไปที่นี่
        },
      );
      Map<String, dynamic> result = jsonDecode(data);
      Map<String, dynamic> insertItem = result['insertItem'];
      String message = 'Report submitted successfully!\n\n';
      message += '- ID: ${insertItem['id']}\n';
      message += '- URL: ${insertItem['url']}\n';
      await showOkDialog(context: context, title: 'Success', message: message);
    } on Exception catch (e) {
      await showOkDialog(context: context, title: 'Error', message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Webby Fondue',
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                'ระบบรายงานเว็บเลวๆ',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'URL',
                filled: true,
                fillColor: Colors.white10,
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _url = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'รายละเอียด',
                filled: true,
                fillColor: Colors.white10,
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _details = value;
                });
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'ระบุประเภทเว็บเลว *',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w100,
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var item in webTypes)
                  Container(
                    height: 80, // Adjust the height as needed
                    margin: EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      //color: Colors.grey.shade200, // Gray-blue tinted background
                      color: Colors.blue[50],
                    ),
                    child: ListTile(
                      title: Text(item['title']),
                      subtitle: Text(item['subtitle']),
                      leading: CircleAvatar(
                        radius: 30, // Adjust the radius as needed
                        backgroundImage: NetworkImage('https://cpsu-api-49b593d4e146.herokuapp.com${item['image']}'),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedWebType = item['id'];
                        });
                      },
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Todo_pages(
                      todoItem: TodoItem(
                        id: 0,
                        url: _url,
                        description: _details,
                        type: _selectedWebType,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'ส่งข้อมูล',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
            ),

          ],
        ),
      ),
    );
  }
}