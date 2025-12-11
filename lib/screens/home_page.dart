import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import 'note_editor_screen.dart';

const Color primaryColor = Color(0xFF6666FF);
const Color cardBackgroundColor = Color(0xFFF7F7F7);
const Color secondaryTextColor = Color(0xFF666666);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _navigateToAddNote(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const NoteEditorScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80.0),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: cardBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.landscape,
                              color: primaryColor,
                              size: 40,
                            ),
                            Text(
                              "Võ Tuấn Việt",
                              style: TextStyle(
                                fontSize: 12,
                                color: secondaryTextColor,
                              ),
                            ),
                            Text(
                              "2224801030324",
                              style: TextStyle(
                                fontSize: 10,
                                color: secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 80.0),
                  ],
                ),

                const Text(
                  'Start Your Journey',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Every big step starts with small step. Notes your first idea and start your journey!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryTextColor,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 100.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(width: 40.0),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () => _navigateToAddNote(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryTextColor,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Finished',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Sinished',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {},
      ),
    );
  }
}
