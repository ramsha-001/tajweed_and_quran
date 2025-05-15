

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'tajweed_pronunciation_screen.dart';
import 'profile_screen.dart';
import 'auth_screen.dart';
import 'auth_service.dart';

class QuizScreen extends StatefulWidget {
  final bool isAuthenticated;

  const QuizScreen({Key? key, this.isAuthenticated = false}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  Timer? _timer;
  int _timeLeft = 15; // 10 seconds timer
  bool isAnswered = false;
  bool showResult = false;
  bool quizCompleted = false;
  String emoji = '';
  String message = '';
  String explanation = '';
  int selectedLevel = 0; // 0 = Easy, 1 = Moderate, 2 = Difficult
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String? selectedAnswer; // Add this to track the selected answer


// Update the initState in quiz_screen.dart
  @override
  void initState() {
    super.initState();
    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null || !user.emailVerified) {
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please verify your email first. A new verification link has been sent to ${user.email}'),
                duration: Duration(seconds: 5),
              ),
            );
          }
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const AuthScreen()),
        );
      } else if (!AuthService.isAuthenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (ctx) => const AuthScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }


// List of questions for Easy Level
  final List<Map<String, Object>> easyQuestions = [

    {
      'question': 'What is Tajweed?',
      'options': [
        'A) Reading the Quran without mistakes',
        'B) Beautifying Quranic recitation',
        'C) Both A and B',
        'D) Memorizing the Quran'
      ],
      'answer': 'C) Both A and B',
    },
    {
      'question': 'What does the rule of Ikhfaa mean?',
      'options': [
        'A) To make a clear sound',
        'B) To hide the sound slightly',
        'C) To stretch the sound',
        'D) To join two words'
      ],
      'answer': 'B) To hide the sound slightly',
    },
    {
      'question': 'What does the symbol “لا” mean in Quran recitation?',
      'options': [
        'A) Stop quickly',
        'B) Optional stop',
        'C) Do not stop',
        'D) Long pause'
      ],
      'answer': 'C) Do not stop',
    },
    {
      'question': 'What does the circle symbol at the end of a verse usually mean?',
      'options': ['A) Start of a new verse', 'B) Stop and take breath', 'C) Continue reading', 'D) Ignore and skip'],
      'answer': 'B) Stop and take breath',
    },
    {
      'question': 'What does the rule of Ghunna mean?',
      'options': [
        'A) A heavy sound',
        'B) A nasal sound',
        'C) A bouncing sound',
        'D) A prolonged sound'
      ],
      'answer': 'B) A nasal sound',
    },
    {
      'question': 'How many main articulation points (Makhaarij) are there in Tajweed?',
      'options': ['A) 3', 'B) 5', 'C) 7', 'D) 10'],
      'answer': 'B) 5',
    },
    {
      'question': 'How many letters are there in the rule of Ikhfaa?',
      'options': ['A) 10', 'B) 12', 'C) 15', 'D) 17'],
      'answer': 'C) 15',
    },
    {
      'question': 'Which of these letters is NOT a Qalqalah letter?',
      'options': ['A) Qaaf', 'B) Meem', 'C) Daal', 'D) Jeem'],
      'answer': 'B) Meem',
    },
    {
      'question': 'When a Noon has a Shaddah on it (نّ), what should be done?',
      'options': ['A) Just read it', 'B) Read it loudly/forcely', 'C) Do Ghunna', 'D) Make it silent'],
      'answer': 'C) Do Ghunna',
    },
    {
      'question': 'How many stops (waqf) are there in Surah Al-Ikhlas?',
      'options': ['A) 3', 'B) 2', 'C) 4', 'D) 5'],
      'answer': 'A) 3',
    },
    {
      'question': 'Which of the following is NOT a rule of Tajweed?',
      'options': ['A) Madd', 'B) Qalqalah', 'C) Shaddah', 'D) Idghaam'],
      'answer': 'C) Shaddah',
    },
    {
      'question': 'Which of the following letters is pronounced with a “whistling” sound (الصّفير)',
      'options': ['A) ص', 'B) ق', 'C) ط', 'D) ر'],
      'answer': 'A) ص',
    },
  ];


  // List of questions for Moderate Level
  final List<Map<String, Object>> moderateQuestions = [

    {
      'question': 'Which rule applies when Noon Sakinah is followed by a Qaaf?',
      'options': ['A) Ghunna', 'B) Idghaam', 'C) Ikhfaa', 'D) Ikhfa Meem Sakin'],
      'answer': 'C) Ikhfaa',
    },
    {
      'question': 'Which part of the mouth is used to pronounce the letter “ف” (Fa)?',
      'options': ['A) Tongue', 'B) Throat', 'C) Lips', 'D) Nose'],
      'answer': 'C) Lips',
    },
    {
      'question': 'Which Waqf symbol tells you to stop and make a supplication (Dua)?',
      'options': ['A) قف', 'B) وقف غفران', 'C) لا', 'D) ط'],
      'answer': 'B) وقف غفران',
    },
    {
      'question': 'Which mnemonic helps us remember the Hams (whisper) letters?',
      'options': ['A)  فَرَّ مِنْ لُبٍّ', 'B) أَجِدْ قَطٍ بَكَتْ', 'C) خُصَّ ضَغْطٍ قِط', 'D)  فَحَثَّهُ شَخْصٌ سَكَتَ'],
      'answer': 'D)  فَحَثَّهُ شَخْصٌ سَكَتَ',
    },
    {
      'question': 'Which of the following is an example of Noon Mushaddadah (النون المشددة),',
      'options': ['A)  أَنْتُمْ', 'B) إِنَّ', 'C) تَرْمِيهِمْ', 'D) لَهَبٍ'],
      'answer': 'B) إِنَّ',
    },
    {
      'question': 'Which of the following is a throat (Halq) letter?',
      'options': ['A) ق', 'B) ل', 'C) ع', 'D) م'],
      'answer': 'C) ع',
    },
    {
      'question': 'What is the correct way to pronounce a Mushaddad letter (e.g., نّ or مّ)?',
      'options': ['A)  Quickly without stopping', 'B)  With strong echo', 'C)  Holding sound with nasal vibration', 'D) Silent without breath'],
      'answer': 'C) Holding sound with nasal vibration',
    },
    {
      'question': 'What is the difference between “Al-Isti’laa” (الاستعلاء) and “Al-Istifal” (الاستفال)?',
      'options': ['A) Both mean bouncing sound', 'B) One is thick and the other is light pronunciation', 'C) Both are same', 'D) They are types of Madd'],
      'answer': 'B) One is thick and the other is light pronunciation',
    },
    {
      'question': 'What is the Tajweed rule in وَمَا خَلَقَ?',
      'options': ['A) Qalqalah on Qaaf', 'B) Ikhfaa', 'C) Ghunna', 'D) Idghaam'],
      'answer': 'A) Qalqalah on Qaaf',
    },

    {
      'question': 'What is the rule of Idghaam?',
      'options': [
        'A) Merging sounds',
        'B) Prolonging sounds',
        'C) Bouncing sounds',
        'D) Hiding sounds'
      ],
      'answer': 'A) Merging sounds',
    },
    {
      'question': 'Which of the following Waqf signs indicates a compulsory stop?',
      'options': [
        'A) ط',
        'B) مـ ',
        'C) ج',
        'D) س'
      ],
      'answer': 'A) A hidden sound with Meem',
    },
    {
      'question': 'Which letters are part of Ghunna?',
      'options': ['A)  ن اور م', 'B) ب اور ف', 'C) د اور ط', 'D) ق اور ع'],
      'answer': 'A) ن اور م',
    },
    {
      'question': 'What is the meaning of the sign “وقف منزل”?',
      'options': ['A) Pause where Jibrael A.S. stopped ', 'B) Prophet’s ﷺ pause', 'C) Must stop', 'D) Do not stop here'],
      'answer': 'A) Pause where Jibrael A.S. stopped',
    },
  ];

  // List of questions for Difficult Level with audio


  final List<Map<String, Object>> difficultQuestions = [
    {
      'question': 'Which tajweed rule is applied in "يَجْعَلْ"?',
      'options': ['A) Ikhfaa', 'B) Qalqalah', 'C) Idgham', 'D) Ghunnah'],
      'answer': 'B) Qalqalah',
      'audio': 'assets/audios/yajal.mp3', // Add your audio file path here

    },
    {
      'question': 'What tajweed rule is applied between the meem and baa in "تَرْمِيهِمْ بِحِجَارَةٍٍ"?',
      'options': ['A) Qalb', 'B) Ikhfaa', 'C) Ikhfaa Meem Saakin', 'D) Idgham'],
      'answer': 'C) Ikhfaa Meem Saakin',
      'audio': 'assets/audios/ikhfa_meemSaakin_tarmeehimm_behijaratin.mp3',
    },
    {
      'question': 'Which tajweed rule is applied in "بِحِجَارَةٍ مِنْ"?',
      'options': ['A) Qalb', 'B) Idgham', 'C) Ikhfaa', 'D) Qalqalah'],
      'answer': 'B) Idgham',
      'audio': 'assets/audios/bikhijaratimmin.mp3',
    },
    {
      'question': 'What is the tajweed rule applied between faa and meem in "كَعَصْفٍ مَأْكُولٍ"?',
      'options': ['A) Idgham', 'B) Qalqalah', 'C) Ghunnah', 'D) Ikhfaa'],
      'answer': 'A) Idgham',
    },
    {
      'question': 'Which tajweed rule is applied in "أَطْعَمَهُمْ"?',
      'options': ['A) Qalqalah', 'B) Ikhfaa', 'C) Ghunnah', 'D) Idgham'],
      'answer': 'A) Qalqalah',
      'audio': 'assets/audios/itamahum.mp3',
    },
    {
      'question': 'What tajweed rule is applied on the meem in "أَطْعَمَهُمْ مِنْ"?',
      'options': ['A) Qalb', 'B) Ikhfaa', 'C) Idgham Meem Saakin', 'D) Ghunnah'],
      'answer': 'C) Idgham Meem Saakin',
      'audio': 'assets/audios/itamahummin.mp3',
    },
    {
      'question': 'In "مِنْ جُوعٍ," what tajweed rule is applied to the letter jeem?',
      'options': ['A) Ikhfaa', 'B) Qalqalah', 'C) Idgham', 'D) Ghunnah'],
      'answer': 'A) Ikhfaa',
      'audio': 'assets/audios/minjooin.mp3',
    },
    {
      'question': 'What tajweed rule is applied on the wow in "جُوعٍ وَآمَنَهُمْ"?',
      'options': ['A) Qalb', 'B) Idgham', 'C) Ikhfaa', 'D) Qalqalah'],
      'answer': 'B) Idgham',
      'audio': 'assets/audios/joinwamanhum.mp3',
    },
    {
      'question': 'Which tajweed rule is applied in "إِنَّا"?',
      'options': ['A) Qalb', 'B) Ikhfaa', 'C) Ghunnah', 'D) Idgham'],
      'answer': 'C) Ghunnah',
      'audio': 'assets/audios/ina mad.mp3',
    },
    {
      'question': 'Which Tajweed rule is applied on the letter د in the word "أَحَدٌ"?',
      'options': ['A) Qalqalah', 'B) Ikhfaa', 'C) Idgham', 'D) Ghunnah'],
      'answer': 'A) Qalqalah',
      'audio': 'assets/audios/qalqalah_aahadd.mp3',
    },
    {
      'question': 'What tajweed rule is applied on baa in "الْأَبْتَرُ"?',
      'options': ['A) Qalqalah', 'B) Ikhfaa', 'C) Idgham', 'D) Ghunnah'],
      'answer': 'A) Qalqalah',
    },
    {
      'question': 'Which tajweed rule is applied on noon in "أَنْتُمْ"?',
      'options': ['A) Ikhfaa', 'B) Idgham', 'C) Ghunnah', 'D) Qalqalah'],
      'answer': 'A) Ikhfaa',
      'audio' : 'assets/audios/ikhfa_annn_tum.mp3',
    },
    {
      'question': 'What tajweed rule is applied on daal in "أَعْبُدُ"?',
      'options': ['A) Ghunnah', 'B) Qalqalah', 'C) Ikhfaa', 'D) Idgham'],
      'answer': 'B) Qalqalah',
    },
    {
      'question': 'Which tajweed rule is applied between meem in "عَابِدٌ مَا"?',
      'options': ['A) Qalqalah', 'B) Idgham', 'C) Ghunnah', 'D) Ikhfaa Meem Saakin'],
      'answer': 'B) Idgham',
    },
    {
      'question': 'What tajweed rule is applied on noon in "النَّاسَ"?',
      'options': ['A) Qalqalah', 'B) Idgham', 'C) Ghunnah', 'D) Ikhfaa'],
      'answer': 'C) Ghunnah',
    },
    {
      'question': 'Which tajweed rule is applied on daal in "يَدْخُلُونَ"?',
      'options': ['A) Qalqalah', 'B) Ikhfaa', 'C) Ghunnah', 'D) Idgham'],
      'answer': 'A) Qalqalah',
    },
    {
      'question': 'Which tajweed rule is applied on noon in "إِنَّهُ"?',
      'options': ['A) Qalqalah', 'B) Ghunnah', 'C) Ikhfaa', 'D) Idgham'],
      'answer': 'B) Ghunnah',
    },
    {
      'question': 'What tajweed rule is applied on wow in "لَهَبٍ وَ"?',
      'options': ['A) Ikhfaa', 'B) Idgham', 'C) Ghunnah', 'D) Qalqalah'],
      'answer': 'B) Idgham',

    },
    {
      'question': 'Which tajweed rule is applied on baa in "وَتَبَّ"?',
      'options': ['A) Ikhfaa', 'B) Qalqalah', 'C) Idgham', 'D) Ghunnah'],
      'answer': 'B) Qalqalah',
      'audio' : 'assets/audios/qalqalah_watabb.mp3',
    },
    {
      'question': 'Which tajweed rule is applied on baa in "كَسَبَ"?',
      'options': ['A) Ghunnah', 'B) Qalqalah', 'C) Idgham', 'D) Ikhfaa'],
      'answer': 'B) Qalqalah',
    },
    {
      'question': 'Which tajweed rule is applied on laam in "حَبْلٌ مِنْ"?',
      'options': ['A) Ghunnah', 'B) Qalqalah', 'C) Idgham', 'D) Ikhfaa'],
      'answer': 'C) Idgham',
    },
    {
      'question': 'What tajweed rule is applied between noon and meem in "مِنْ مَسَدٍ"?',
      'options': ['A) Ghunnah', 'B) Ikhfaa', 'C) Idgham', 'D) Qalqalah'],
      'answer': 'C) Idgham',
    },
    {
      'question': 'What tajweed rule is applied on daal in "مَسَدٍ"?',
      'options': ['A) Qalqalah', 'B) Ghunnah', 'C) Ikhfaa', 'D) Idgham'],
      'answer': 'A) Qalqalah',
    },
    {
      'question': 'Which tajweed rule is applied on daal in "يَلِدْ"?',
      'options': ['A) Ikhfaa', 'B) Qalqalah', 'C) Idgham', 'D) Ghunnah'],
      'answer': 'B) Qalqalah',
    },
    {
      'question': 'What tajweed rule is applied on noon in "الْجِنَّةِ"?',
      'options': ['A) Ikhfaa', 'B) Idgham', 'C) Ghunnah', 'D) Qalqalah'],
      'answer': 'C) Ghunnah',
    },
  ];


  void _startTimer() {
    _timer?.cancel(); // Safe cancel if already running
    _timeLeft = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        timer.cancel();
        setState(() {
          selectedAnswer = null; // 🛑 User didn’t answer
          emoji = '😞';
          message = 'Time up! No answer selected';
          isAnswered = true;
          showResult = true;
        });
      }
    });
  }



  List<Map<String, Object>> get questions {
    switch (selectedLevel) {
      case 1:
        return moderateQuestions;
      case 2:
        return difficultQuestions;
      default:
        return easyQuestions;
    }
  }

  void _moveToNextQuestion() {
    setState(() {
      isAnswered = true;
      showResult = true;
    });
  }

  void _checkAnswer(String selected) {
    _timer?.cancel(); // stop the timer
    setState(() {
      selectedAnswer = selected;
      isAnswered = true;
      showResult = true;

      // Check answer
      if (selected == questions[currentQuestionIndex]['answer']) {
        score++;
        emoji = '👏';
        message = 'Correct!';
      } else {
        emoji = '😞';
        message = 'Incorrect!';
        explanation = 'Correct Answer: ${questions[currentQuestionIndex]['answer']}';
        // User will press "Next" manually
      }
    });
  }


  Future<void> _playAudio() async {
    if (isPlaying) {
      await audioPlayer.stop();
      setState(() {
        isPlaying = false;
      });
      return;
    }

    setState(() {
      isPlaying = true;
    });

    try {
      await audioPlayer.setAsset(questions[currentQuestionIndex]['audio'] as String);
      await audioPlayer.play();

      audioPlayer.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            isPlaying = false;
          });
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not play audio: $e')),
      );
      setState(() {
        isPlaying = false;
      });
    }
  }

  void _nextQuestion() async {
    if (quizCompleted) return; // ⛔ Prevent double execution
    quizCompleted = true; // ✅ Mark as completed

    await audioPlayer.stop();

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswered = false;
        showResult = false;
        isPlaying = false;
        selectedAnswer = null;
        quizCompleted = false; // ✅ Reset here
        _startTimer();
      });
    } else {
      // ✅ Save result to Firebase
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('quiz_scores').add({
            'userId': user.uid,
            'email': user.email ?? 'anonymous',
            'score': score,
            'total': questions.length,
            'level': selectedLevel == 0
                ? 'Easy'
                : selectedLevel == 1
                ? 'Moderate'
                : 'Difficult',
            'timestamp': FieldValue.serverTimestamp(),
          });
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to store quiz result: $e'),
            ),
          );
        }
      }

      // ✅ Show dialog after storing
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Quiz Completed!'),
            content: Text('Your score is: $score/${questions.length}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    isAnswered = false;
                    showResult = false;
                    isPlaying = false;
                    selectedAnswer = null;
                    _startTimer();
                  });
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    bool hasAudio = selectedLevel == 2 &&
        questions[currentQuestionIndex].containsKey('audio') &&
        questions[currentQuestionIndex]['audio'] != null;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tajweed Quiz'),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                selectedLevel = index;
                currentQuestionIndex = 0;
                score = 0;
                isAnswered = false;
                showResult = false;
                isPlaying = false;
                selectedAnswer = null; // Reset selectedAnswer
                _startTimer();
              });
            },
            tabs: const [
              Tab(text: 'Easy 🟢'),
              Tab(text: 'Moderate 🟡'),
              Tab(text: 'Difficult 🔴'),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade100, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instructions: Select the correct answer for each question. Points are based on difficulty level!',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    if (hasAudio) ...[
                      ElevatedButton.icon(
                        onPressed: _playAudio,
                        icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                        label: Text(isPlaying ? 'Stop Audio' : 'Play Audio'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade300,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Listen carefully to the audio and identify the Tajweed rule:',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 10),
                    ],

                    Text(
                      questions[currentQuestionIndex]['question'] as String,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    ...(questions[currentQuestionIndex]['options'] as List<String>)
                        .map((option) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAnswered
                                ? option == questions[currentQuestionIndex]['answer']
                                ? Colors.green.shade300
                                : option == selectedAnswer
                                ? Colors.red.shade300
                                : Colors.lightGreen.shade200
                                : Colors.lightGreen.shade200,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: isAnswered
                              ? null
                              : () {
                            _checkAnswer(option);
                          },
                          child: Text(
                            option,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),

                    if (showResult)
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            '$emoji $message',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          if (isAnswered && selectedAnswer != questions[currentQuestionIndex]['answer'])
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                explanation,
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _nextQuestion,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade400,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              currentQuestionIndex == questions.length - 1
                                  ? 'Finish Quiz'
                                  : 'Next Question',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: _timeLeft / 10,
                            valueColor: AlwaysStoppedAnimation(
                              _timeLeft > 6
                                  ? Colors.green
                                  : _timeLeft > 3
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                            backgroundColor: Colors.grey.shade200,
                            strokeWidth: 10,
                          ),
                          Center(
                            child: Text(
                              '$_timeLeft',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TajweedPronunciationScreen()),
                        );
                      },
                      child: Text("🎤 Practice Tajweed Pronunciation"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[800],
                        foregroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Time Left',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}