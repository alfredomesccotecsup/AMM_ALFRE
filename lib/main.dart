import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation with Images Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://www.shutterstock.com/image-vector/chat-bot-logo-design-concept-600nw-1938811039.jpg',
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: 16),
            buildElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondScreen()),
                );
              },
              label: 'AGREGAR TAREAS',
              icon: FontAwesomeIcons.arrowRight,
            ),
            SizedBox(height: 8),
            buildElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdScreen()),
                );
              },
              label: 'ALBUM DE FOTOS ',
              icon: FontAwesomeIcons.arrowRight,
            ),
            SizedBox(height: 8),
            buildElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FourthScreen()),
                );
              },
              label: 'USARIOS REGISTRADOS',
              icon: FontAwesomeIcons.arrowRight,
            ),
            SizedBox(height: 8),
            buildElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FifthScreen()),
                );
              },
              label: 'BUSCAR NOTICAS ',
              icon: FontAwesomeIcons.arrowRight,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildElevatedButton({
    required VoidCallback onPressed,
    required String label,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }
}


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Task> tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas Pendientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    task: tasks[index],
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      hintText: 'Añadir nueva tarea',
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: InputDecoration(
                      hintText: 'URL de la imagen',
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _addTask();
                    },
                    child: Text('Agregar'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver a la Pantalla Principal'),
            ),
          ],
        ),
      ),
    );
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty &&
        _imageUrlController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(
          title: _taskController.text,
          imageUrl: _imageUrlController.text,
        ));
        _taskController.clear();
        _imageUrlController.clear();
      });
    }
  }
}

class Task {
  final String title;
  final String imageUrl;

  Task({required this.title, required this.imageUrl});
}

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: CachedNetworkImage(
          imageUrl: task.imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.contain,
          width: 40, // Ajusta el ancho de la imagen según tus preferencias
          height: 40, // Ajusta la altura de la imagen según tus preferencias
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'https://placekitten.com/200/300',
    'https://placekitten.com/201/301',
    'https://placekitten.com/202/302',
    'https://placekitten.com/203/303',
    'https://placekitten.com/204/304',
    'https://placekitten.com/205/305',
    'https://placekitten.com/206/306',
    'https://placekitten.com/207/307',
    'https://placekitten.com/208/308',
    'https://placekitten.com/209/309',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return buildImageCard(imageUrls[index]);
        },
      ),
    );
  }

  Widget buildImageCard(String imageUrl) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildReactionIcon(Icons.thumb_up),
                buildReactionIcon(Icons.favorite),
                buildReactionIcon(Icons.star),
                buildReactionIcon(Icons.sentiment_satisfied),
                buildReactionIcon(Icons.sentiment_very_satisfied),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReactionIcon(IconData icon) {
    return Icon(icon, color: Colors.blue);
  }
}

class User {
  final String name;
  final String imageUrl;

  User({required this.name, required this.imageUrl});
}

class Reaction {
  final IconData icon;
  final String label;

  Reaction({required this.icon, required this.label});
}

class FourthScreen extends StatelessWidget {
  final List<User> users = [
    User(name: 'Usuario 1', imageUrl: 'https://picsum.photos/200/300'),
    User(name: 'Usuario 2', imageUrl: 'https://picsum.photos/200/300'),
    User(name: 'Usuario 3', imageUrl: 'https://picsum.photos/200/300'),
    User(name: 'Usuario 4', imageUrl: 'https://picsum.photos/200'),
    User(name: 'Usuario 5', imageUrl: 'https://picsum.photos/200/300'),
    User(name: 'Usuario 6', imageUrl: 'https://picsum.photos/200'),
    User(name: 'Usuario 7', imageUrl: 'https://picsum.photos/200/300'),
    User(name: 'Usuario 8', imageUrl: 'https://picsum.photos/200/300'),
    User(name: 'Usuario 9', imageUrl: 'https://picsum.photos/200/300'),
    User(name: 'Usuario 10', imageUrl: 'https://picsum.photos/200/300'),
  ];

  final List<Reaction> reactions = [
    Reaction(icon: Icons.thumb_up, label: 'Me gusta'),
    Reaction(icon: Icons.favorite, label: 'Love'),
    Reaction(icon: Icons.star, label: 'Estrella'),
    Reaction(icon: Icons.sentiment_satisfied, label: 'Feliz'),
    Reaction(icon: Icons.sentiment_very_satisfied, label: 'Muy feliz'),
    Reaction(icon: Icons.sentiment_dissatisfied, label: 'Insatisfecho'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fourth Screen'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return buildUserCard(users[index]);
        },
      ),
    );
  }

  Widget buildUserCard(User user) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user.imageUrl),
        ),
        title: Text(user.name),
        subtitle: Row(
          children: reactions.map((reaction) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: buildReactionIcon(reaction.icon),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildReactionIcon(IconData icon) {
    return Icon(icon, color: Colors.blue);
  }
}

class News {
  final String title;
  final String description;
  final String imageUrl;

  News(
      {required this.title, required this.description, required this.imageUrl});
}

class FifthScreen extends StatefulWidget {
  @override
  _FifthScreenState createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  TextEditingController searchController = TextEditingController();
  List<News> newsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fifth Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar noticias...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                searchNews(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return buildNewsCard(newsList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNewsCard(News news) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: ListTile(
        title: Text(news.title),
        subtitle: Text(news.description),
        leading: Image.network(
          news.imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> searchNews(String query) async {
    final apiKey =
        'a25e4f592c674d948b4bcb1ed2b3d4c5'; // Reemplaza con tu clave de API de noticias
    final apiUrl = 'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        newsList = (data['articles'] as List)
            .map((article) => News(
                  title: article['title'],
                  description: article['description'],
                  imageUrl: article['urlToImage'] ??
                      'https://via.placeholder.com/100', // URL de imagen de reemplazo si no hay imagen disponible
                ))
            .toList();
      });
    } else {
      // Manejar errores aquí
      print(
          'Error al cargar noticias. Código de estado: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');
    }
  }
}
