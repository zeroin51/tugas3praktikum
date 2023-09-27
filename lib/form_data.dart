import 'package:flutter/material.dart';
import 'package:tugas3praktikum/profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormData extends StatefulWidget {
  const FormData({Key? key}) : super(key: key);

  @override
  _FormDataState createState() => _FormDataState();
}

class _FormDataState extends State<FormData> {
  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _nohpController = TextEditingController();
  final _emailController = TextEditingController();
  final _fakultasController = TextEditingController();
  final _jurusanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? profil = prefs.getStringList('mhs');
    if (profil != null) {
      setState(() {
        _nimController.text = profil[0];
        _namaController.text = profil[1];
        _nohpController.text = profil[2];
        _emailController.text = profil[3];
        _fakultasController.text = profil[4];
        _jurusanController.text = profil[5];
      });
    }
  }

  TextFormField _textbox(String label, controller,
      {bool isEmail = false, bool isNumeric = false}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue), // Ubah warna garis tepi
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        labelStyle: TextStyle(color: Colors.blue), // Ubah warna label
      ),
      style: TextStyle(color: Colors.white), // Ubah warna teks
      controller: controller,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : (isNumeric ? TextInputType.phone : TextInputType.text),
      validator: (value) {
        if (isEmail && !isValidEmail(value)) {
          return 'Masukkan alamat email yang valid';
        }
        if (isNumeric && !isNumericString(value)) {
          return 'Masukkan nomor HP yang valid';
        }
        return null;
      },
    );
  }

  bool isValidEmail(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    if (!value.contains('@')) {
      return false;
    }

    final emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegExp.hasMatch(value);
  }

  bool isNumericString(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final numericRegExp = RegExp(r'^[0-9]+$');
    return numericRegExp.hasMatch(value);
  }

  _savedata(key, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Profil'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black, // Ubah warna latar belakang
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            _textbox('NIM', _nimController),
            _textbox('Nama', _namaController),
            _textbox('No HP', _nohpController, isNumeric: true),
            _textbox('E-mail', _emailController, isEmail: true),
            _textbox('Fakultas', _fakultasController),
            _textbox('Jurusan', _jurusanController),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                if (_nimController.text.isEmpty ||
                    _namaController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'NIM dan Nama harus diisi.',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (_emailController.text.isNotEmpty &&
                    !isValidEmail(_emailController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Masukkan alamat email yang valid.',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (_nohpController.text.isNotEmpty &&
                    !isNumericString(_nohpController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Masukkan nomor HP yang valid.',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  List<String> profil = [
                    _nimController.text,
                    _namaController.text,
                    _nohpController.text,
                    _emailController.text,
                    _fakultasController.text,
                    _jurusanController.text,
                  ];
                  _savedata('mhs', profil);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Profil(),
                  ));
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: Text(
                'Simpan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
