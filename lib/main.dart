import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  String name = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Перший екран"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: nameController,
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                name = nameController.text;
                nameController.clear();

                Map<String, String> result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(name: name),
                  ),
                );
                setState(() {
                  name = result['name']!;
                  gender = result['gender']!;
                });
              },
              child: const Text(
                'Передати дані',
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            if (gender != '') Text('$name є $gender імʼям'),

            // gender == '' ? const SizedBox() : Text('$name є $gender імʼям'),
          ],
        ),
      ),
    );
  }
}





class SecondScreen extends StatefulWidget {
  final String name;

  const SecondScreen({super.key, required this.name});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  Gender selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              Text(
                widget.name,
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 50),
              ListTile(
                title: const Text('Жіноче'),
                leading: Radio(
                  value: Gender.female,
                  groupValue: selectedGender,
                  onChanged: (Gender? value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              ListTile(
                title: const Text('Чоловіче'),
                leading: Radio(
                  value: Gender.male,
                  groupValue: selectedGender,
                  onChanged: (Gender? value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'name': widget.name,
                    'gender': selectedGender == Gender.male ? 'Чоловічий' : 'Жіночий',
                  });
                },
                child: const Text(
                  'Повернути дані',
                ),
              )
            ],
          ),
        ));
  }
}

enum Gender { male, female }
