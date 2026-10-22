import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainMenuScreen(),
  ));
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Модульний контроль')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Task1Screen())),
              child: const Text('Завдання №1'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Task2Screen())),
              child: const Text('Завдання №2'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
              child: const Text('Завдання №3'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Task4Screen())),
              child: const Text('Завдання №4'),
            ),
          ],
        ),
      ),
    );
  }
}

// Завдання №1
abstract class LibraryItem {
  final String title;
  final int year;
  LibraryItem({required this.title, required this.year});
  String describe();
}

class Book extends LibraryItem {
  final String author;
  Book({required String title, required int year, required this.author}) : super(title: title, year: year);
  @override String describe() => '$title ($year) — $author';
}

class Magazine extends LibraryItem {
  final int issueNumber;
  Magazine({required String title, required int year, required this.issueNumber}) : super(title: title, year: year);
  @override String describe() => '$title ($year), випуск $issueNumber';
}

class Library {
  final List<LibraryItem> _items = [];
  void addItem(LibraryItem item) => _items.add(item);
  List<LibraryItem> findByYear(int year) => _items.where((item) => item.year == year).toList();
  List<String> get allDescriptions => _items.map((item) => item.describe()).toList();
  LibraryItem? findOldest() {
    if (_items.isEmpty) return null;
    return _items.reduce((curr, next) => curr.year < next.year ? curr : next);
  }
}

class Task1Screen extends StatefulWidget {
  const Task1Screen({Key? key}) : super(key: key);
  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  final Library library = Library();
  List<String> results = [];

  @override
  void initState() {
    super.initState();
    library.addItem(Book(title: 'Dart у дії', year: 2022, author: 'І. Петренко'));
    library.addItem(Magazine(title: 'Mobile Dev', year: 2023, issueNumber: 5));
    results = library.allDescriptions;
    results.add('Найстаріший: ${library.findOldest()?.describe()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Завдання №1')),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: results.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              results[index],
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

// Завдання №2
class RatingBadge extends StatelessWidget {
  final double rating;
  final String? label;
  const RatingBadge({Key? key, required this.rating, this.label}) : super(key: key);

  Color _getBadgeColor() {
    if (rating >= 4.0) return Colors.green;
    if (rating >= 2.5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: _getBadgeColor()),
            const SizedBox(width: 4),
            Text(rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        if (label != null) ...[const SizedBox(height: 4), Text(label!)],
      ],
    );
  }
}

class Task2Screen extends StatelessWidget {
  const Task2Screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Завдання №2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            RatingBadge(rating: 4.7, label: 'Відмінно'),
            SizedBox(height: 20),
            RatingBadge(rating: 3.2, label: 'Нормально'),
            SizedBox(height: 20),
            RatingBadge(rating: 1.2, label: 'Погано'),
          ],
        ),
      ),
    );
  }
}

// Завдання №3
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  void _increment() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Завдання №3')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Лічильник: $_counter', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _increment, child: const Text('+1')),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => DetailScreen(counter: _counter)),
              ),
              child: const Text('Детальніше'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final int counter;
  const DetailScreen({Key? key, required this.counter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Завдання №3 > Детальний екран')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Значення лічильника: $counter', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Назад')),
          ],
        ),
      ),
    );
  }
}

// Завдання №4
class WeatherService {
  Future<Map<String, dynamic>> fetchCurrentWeather(String city) async {
    if (city.isEmpty) throw ArgumentError('Місто не вказано');
    await Future.delayed(const Duration(seconds: 1));
    return {'city': city, 'temp': 15 + Random().nextInt(15), 'condition': 'Хмарно'};
  }
  Stream<int> temperatureUpdates({int times = 5}) async* {
    for (int i = 0; i < times; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield 10 + Random().nextInt(20);
    }
  }
}

class Task4Screen extends StatefulWidget {
  const Task4Screen({Key? key}) : super(key: key);
  @override
  State<Task4Screen> createState() => _Task4ScreenState();
}

class _Task4ScreenState extends State<Task4Screen> {
  final WeatherService _service = WeatherService();
  String _weatherResult = "Натисніть кнопку для завантаження";
  String _streamResult = "Чекаю на потік";

  void _fetchWeather() async {
    setState(() => _weatherResult = "Завантаження");
    try {
      final res = await _service.fetchCurrentWeather('Київ');
      setState(() => _weatherResult = "Погода: ${res['city']}, ${res['temp']}°C, ${res['condition']}");
    } catch (e) {
      setState(() => _weatherResult = "Помилка: $e");
    }
  }

  void _startStream() {
    setState(() => _streamResult = "Запуск потоку");
    _service.temperatureUpdates(times: 5).listen(
      (temp) => setState(() => _streamResult = "Температура: $temp°C"),
      onDone: () => setState(() => _streamResult = "Потік завершено"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Завдання №4')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weatherResult, textAlign: TextAlign.center),
            ElevatedButton(onPressed: _fetchWeather, child: const Text('Отримати погоду')),
            const SizedBox(height: 30),
            Text(_streamResult, textAlign: TextAlign.center),
            ElevatedButton(onPressed: _startStream, child: const Text('Слухати оновлення')),
          ],
        ),
      ),
    );
  }
}