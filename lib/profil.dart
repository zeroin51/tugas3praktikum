import 'package:flutter/material.dart';
import 'package:tugas3praktikum/side_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  var profil;

  @override
  void initState() {
    super.initState();
    _loadProfil();
  }

  _loadProfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profil = prefs.getStringList('mhs');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil Saya',
          style: TextStyle(
            color: Colors.blue, // Ubah warna teks judul
          ),
        ),
        backgroundColor: Colors.black, // Ubah warna latar belakang AppBar
      ),
      body: Center(
        child: _buildProfilCard(),
      ),
      drawer: const SideMenu(),
      backgroundColor: Colors.black, // Ubah warna latar belakang body
    );
  }

  Widget _buildProfilCard() {
    if (profil == null || profil.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: <Widget>[
          CircleAvatar(
            radius: 60.0,
            backgroundImage: AssetImage(
                'assets/images/profile_image.png'), // Ganti dengan path ke gambar profil
          ),
          SizedBox(height: 20),
          Card(
            elevation: 4.0,
            color: Colors.blue, // Ubah warna latar belakang Card
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    title: const Text(
                      'NIM',
                      style: TextStyle(color: Colors.white), // Ubah warna teks judul
                    ),
                    subtitle: Text(
                      profil[0],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white, // Ubah warna teks subtitle
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Nama',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      profil[1],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'No HP',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      profil[2],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'E-mail',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      profil[3],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Fakultas',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      profil[4],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Jurusan',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      profil[5],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
