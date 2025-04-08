import 'package:flutter/material.dart';
import 'question3.dart'; // Ensure this path matches your actual file structure

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://th.bing.com/th/id/R.2a5fd36dbc1724922bb2206b35a4dcda?rik=ukSa06cIVmJ9zQ&pid=ImgRaw&r=0',
            ), // Replace with your image URL
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      'Aweis Audio Player',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Question3Page(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          246,
                          243,
                          243,
                        ),
                        foregroundColor: const Color.fromARGB(255, 68, 96, 255),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text('Launch App'),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Text(
                  'Developed by Aweis',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
