import 'package:flutter/material.dart';
import 'package:tugas3praktikum/form_data.dart';
import 'package:tugas3praktikum/profil.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Ubah warna latar belakang Drawer
        child: ListView(
          children: [
            Container(
              height: 150, // Tinggi header Drawer
              color: Colors.blue, // Ubah warna header
              child: Center(
                child: Text(
                  'Menu Aplikasi',
                  style: TextStyle(
                    color: Colors.white, // Ubah warna teks header
                    fontSize: 24, // Ubah ukuran teks header
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.blue, // Ubah warna ikon
              ),
              title: Text(
                'Form',
                style: TextStyle(
                  color: Colors.white, // Ubah warna teks menu
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FormData(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.blue, // Ubah warna ikon
              ),
              title: Text(
                'Profil Saya',
                style: TextStyle(
                  color: Colors.white, // Ubah warna teks menu
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profil(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
