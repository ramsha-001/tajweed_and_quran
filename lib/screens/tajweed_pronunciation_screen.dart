
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:just_audio/just_audio.dart';
import 'package:string_similarity/string_similarity.dart';

class TajweedExample {
  final String rule;
  final String arabic;
  final String roman;
  final String audioPath;
  final Color color;
  final String description;
  final String commonMistakes;
  final String correctionTips;

  TajweedExample({
    required this.rule,
    required this.arabic,
    required this.roman,
    required this.audioPath,
    required this.color,
    required this.description,
    required this.commonMistakes,
    required this.correctionTips,
  });
}

class TajweedPronunciationScreen extends StatefulWidget {
  const TajweedPronunciationScreen({super.key});

  @override
  State<TajweedPronunciationScreen> createState() => _TajweedPronunciationScreenState();
}

class _TajweedPronunciationScreenState extends State<TajweedPronunciationScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final AudioPlayer _audioPlayer = AudioPlayer();

  String _spoken = '';
  String _feedback = '';
  String _detailedFeedback = '';
  bool _isListening = false;
  double _similarityScore = 0.0;
  List<String> _problemAreas = [];

  TajweedExample? selectedExample;
  List<TajweedExample> _currentRuleExamples = [];
  int _currentExampleIndex = 0;

  // Organized by rule with multiple examples per rule
  final Map<String, List<TajweedExample>> ruleExamples = {
    'Ikhfaa': [
      TajweedExample(
        rule: 'Ikhfaa',
        arabic: 'مِنْ جُوعٍ',
        roman: 'min jooain',
        audioPath: 'assets/audios/minjooin.mp3',
        color: Colors.green.shade900,
        description: 'Ikhfaa means to slightly hide the sound of Noon Sakinah or Tanween when followed by specific letters.',
        commonMistakes: 'Pronouncing the noon clearly instead of hiding it',
        correctionTips: 'Make a nasal sound (ghunna) for about 2 counts while hiding the noon sound',
      ),
      TajweedExample(
        rule: 'Ikhfaa',
        arabic: 'أَنْتُمْ',
        roman: 'antum',
        audioPath: 'assets/audios/ikhfa_annn_tum.mp3',
        color: Colors.green.shade900,
        description: 'Ikhfaa applies when Noon Sakinah is followed by ت',
        commonMistakes: 'Pronouncing the noon clearly instead of hiding it',
        correctionTips: 'Hide the noon sound but maintain the nasalization',
      ),
    ],
    'Ghunna': [
      TajweedExample(
        rule: 'Ghunna',
        arabic: 'إِنَّهُ',
        roman: 'innahu',
        audioPath: 'assets/audios/ina mad.mp3',
        color: Colors.blue,
        description: 'Ghunna is the nasal sound produced when pronouncing Noon or Meem with shaddah.',
        commonMistakes: 'Not holding the nasal sound long enough',
        correctionTips: 'Hold the nasal sound for 2 counts (about 1 second)',
      ),
      TajweedExample(
        rule: 'Ghunna',
        arabic: 'النَّاسَ',
        roman: 'annas',
        audioPath: 'assets/audios/annas.mp3',
        color: Colors.blue,
        description: 'Ghunna applies to Noon with shaddah',
        commonMistakes: 'Skipping the nasal sound',
        correctionTips: 'Focus on the nose vibration when pronouncing the double noon',
      ),
    ],
    'Ikhfaa Meem Saakin': [
      TajweedExample(
        rule: 'Ikhfaa Meem Saakin',
        arabic: 'تَرْمِيهِمْ بِحِجَارَةٍٍ',
        roman: 'tarmeehim bihijaratin',
        audioPath: 'assets/audios/ikhfa_meemSaakin_tarmeehimm_behijaratin.mp3',
        color: Colors.lightGreen,
        description: 'Ikhfaa Meem Saakin occurs when Meem Sakinah is followed by ب',
        commonMistakes: 'Pronouncing the meem clearly instead of hiding it',
        correctionTips: 'Hide the meem sound but maintain the nasalization (ghunna)',
      ),
    ],
    'Qalqalah': [
      TajweedExample(
        rule: 'Qalqalah',
        arabic: 'يَجْعَلْ',
        roman: 'yaj\'al',
        audioPath: 'assets/audios/yajal.mp3',
        color: Colors.orange,
        description: 'Qalqalah is the bouncing sound when pronouncing ق ط ب ج د letters with sukoon',
        commonMistakes: 'Not producing the bouncing echo sound',
        correctionTips: 'Make a slight bouncing/echo effect when pronouncing these letters',
      ),
      TajweedExample(
        rule: 'Qalqalah',
        arabic: 'أَحَدٌ',
        roman: 'ahad',
        audioPath: 'assets/audios/qalqalah_aahadd.mp3',
        color: Colors.orange,
        description: 'Qalqalah applies to د with sukoon',
        commonMistakes: 'Pronouncing the د normally without the bounce',
        correctionTips: 'Make the د sound bounce slightly at the end',
      ),
      TajweedExample(
        rule: 'Qalqalah',
        arabic: 'وَتَبَّ',
        roman: 'watabba',
        audioPath: 'assets/audios/qalqalah_watabb.mp3',
        color: Colors.orange,
        description: 'Qalqalah applies to ب with shaddah',
        commonMistakes: 'Not emphasizing the bouncing sound enough',
        correctionTips: 'Make the ب sound bounce more prominently',
      ),
    ],
    'Idgham': [
      TajweedExample(
        rule: 'Idgham',
        arabic: 'بِحِجَارَةٍ مِنْ',
        roman: 'bihijaratin min',
        audioPath: 'assets/audios/bikhijaratimmin.mp3',
        color: Colors.red,
        description: 'Idgham means merging one letter into another when Noon Sakinah or Tanween is followed by specific letters',
        commonMistakes: 'Not fully merging the sounds',
        correctionTips: 'Merge the noon sound completely into the following letter',
      ),
      TajweedExample(
        rule: 'Idgham',
        arabic: 'لَهَبٍ وَ',
        roman: 'lahabin wa',
        audioPath: 'assets/audios/lahabin_wa.mp3',
        color: Colors.red,
        description: 'Idgham with ghunna when followed by و or ي',
        commonMistakes: 'Not maintaining the nasal sound during merging',
        correctionTips: 'Merge with a nasal sound (ghunna) for about 2 counts',
      ),
    ],
    'Idgham Meem Saakin': [
      TajweedExample(
        rule: 'Idgham Meem Saakin',
        arabic: 'أَطْعَمَهُمْ مِنْ',
        roman: 'atamahum min',
        audioPath: 'assets/audios/itamahummin.mp3',
        color: Colors.pinkAccent,
        description: 'Idgham Meem Saakin occurs when Meem Sakinah is followed by another Meem',
        commonMistakes: 'Not fully merging the two meem sounds',
        correctionTips: 'Merge the two meems completely with ghunna for 2 counts',
      ),
      TajweedExample(
        rule: 'Idgham Meem Saakin',
        arabic: 'مِنْ مَسَدٍ',
        roman: 'min masad',
        audioPath: 'assets/audios/min_masad.mp3',
        color: Colors.pinkAccent,
        description: 'Meem Sakinah followed by another Meem',
        commonMistakes: 'Pronouncing two separate meem sounds',
        correctionTips: 'Merge into one prolonged meem sound with nasalization',
      ),
    ],
  };

  void _selectRule(String rule) {
    setState(() {
      _currentRuleExamples = ruleExamples[rule] ?? [];
      _currentExampleIndex = 0;
      if (_currentRuleExamples.isNotEmpty) {
        selectedExample = _currentRuleExamples.first;
      }
      _spoken = '';
      _feedback = '';
      _detailedFeedback = '';
      _similarityScore = 0.0;
      _problemAreas = [];
    });
  }

  void _nextExample() {
    if (_currentRuleExamples.isEmpty) return;

    setState(() {
      _currentExampleIndex = (_currentExampleIndex + 1) % _currentRuleExamples.length;
      selectedExample = _currentRuleExamples[_currentExampleIndex];
      _spoken = '';
      _feedback = '';
      _detailedFeedback = '';
      _similarityScore = 0.0;
      _problemAreas = [];
    });
  }

  Future<void> _startListening() async {
    bool available = await _speech.initialize();
    if (!available) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone not available")),
      );
      return;
    }

    setState(() {
      _isListening = true;
      _spoken = '';
      _feedback = '';
      _detailedFeedback = '';
      _similarityScore = 0.0;
      _problemAreas = [];
    });

    _speech.listen(
      onResult: (val) {
        setState(() {
          _spoken = val.recognizedWords.toLowerCase();
          _checkPronunciation();
        });
      },
      listenFor: const Duration(seconds: 5),
      cancelOnError: true,
      partialResults: true,
    );
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _checkPronunciation() {
    if (selectedExample == null) return;

    // Calculate similarity score
    _similarityScore = StringSimilarity.compareTwoStrings(
        _spoken,
        selectedExample!.roman.toLowerCase()
    );

    // Rule-specific analysis
    _analyzePronunciation();

    // Generate feedback based on score and analysis
    if (_similarityScore >= 0.9) {
      _feedback = '✅ Excellent ${selectedExample!.rule} pronunciation!';
      _detailedFeedback = 'You correctly applied the Tajweed rule.';
    } else if (_similarityScore >= 0.7) {
      _feedback = '🟡 Good, but needs slight improvement';
      _detailedFeedback = _generateDetailedFeedback();
    } else if (_similarityScore >= 0.5) {
      _feedback = '🟠 Needs work on ${selectedExample!.rule}';
      _detailedFeedback = _generateDetailedFeedback();
    } else {
      _feedback = '❌ Incorrect application of ${selectedExample!.rule}';
      _detailedFeedback = _generateDetailedFeedback();
    }
  }

  String _generateDetailedFeedback() {
    if (selectedExample == null) return '';

    String feedback = '';

    // Rule-specific feedback
    switch (selectedExample!.rule) {
      case 'Ikhfaa':
      case 'Ikhfaa Meem Saakin':
        if (!_spoken.contains('n') && !_spoken.contains('m')) {
          feedback += 'You missed the nasal sound (ghunna). ';
        }
        if (_spoken.contains(selectedExample!.rule == 'Ikhfaa' ? 'n' : 'm')) {
          feedback += 'The ${selectedExample!.rule == 'Ikhfaa' ? 'noon' : 'meem'} should be hidden but still nasalized. ';
        }
        break;

      case 'Ghunna':
        if (!_spoken.contains('n') && !_spoken.contains('m')) {
          feedback += 'Missing the nasal sound. ';
        } else {
          feedback += 'Try holding the nasal sound longer (about 1 second). ';
        }
        break;

      case 'Qalqalah':
        if (!_spoken.contains(RegExp(r'[qtdjb]'))) {
          feedback += 'The bouncing effect is missing on the Qalqalah letter. ';
        } else {
          feedback += 'Try making the bouncing sound more pronounced. ';
        }
        break;

      case 'Idgham':
      case 'Idgham Meem Saakin':
        if (_spoken.contains('n') || _spoken.contains('m')) {
          feedback += 'The letters should merge completely without a separate ${selectedExample!.rule == 'Idgham' ? 'noon' : 'meem'} sound. ';
        }
        if (selectedExample!.rule == 'Idgham' && !_spoken.contains(RegExp(r'[ywmn]'))) {
          feedback += 'Remember to add nasalization when merging with و or ي. ';
        }
        break;
    }

    // Add common mistakes and correction tips
    feedback += '\n\nCommon mistakes: ${selectedExample!.commonMistakes}\n\n';
    feedback += 'Tips: ${selectedExample!.correctionTips}';

    return feedback;
  }

  void _analyzePronunciation() {
    _problemAreas = [];
    if (selectedExample == null) return;

    final targetWords = selectedExample!.roman.toLowerCase().split(' ');
    final spokenWords = _spoken.split(' ');

    // Compare word by word
    for (int i = 0; i < targetWords.length; i++) {
      if (i >= spokenWords.length) {
        _problemAreas.add('Missing: "${targetWords[i]}"');
        continue;
      }

      final similarity = StringSimilarity.compareTwoStrings(
          spokenWords[i],
          targetWords[i]
      );

      if (similarity < 0.7) {
        _problemAreas.add('"${spokenWords[i]}" should be "${targetWords[i]}"');
      }
    }

    // Check for extra words
    if (spokenWords.length > targetWords.length) {
      for (int i = targetWords.length; i < spokenWords.length; i++) {
        _problemAreas.add('Extra word: "${spokenWords[i]}"');
      }
    }
  }

  Future<void> _playAudio(String path) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.setAsset(path);
      await _audioPlayer.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Audio error: $e")),
      );
    }
  }

  @override
  void dispose() {
    _speech.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tajweed Pronunciation Checker'),
        actions: [
          if (_currentRuleExamples.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: _nextExample,
              tooltip: 'Next example',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Rule selection dropdown
            DropdownButton<String>(
              value: selectedExample?.rule,
              hint: const Text('Select a Tajweed Rule'),
              isExpanded: true,
              items: ruleExamples.keys.map((rule) {
                return DropdownMenuItem(
                  value: rule,
                  child: Text(rule),
                );
              }).toList(),
              onChanged: (rule) {
                if (rule != null) {
                  _selectRule(rule);
                }
              },
            ),

            if (selectedExample != null) ...[
              const SizedBox(height: 20),

              // Rule description
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedExample!.rule,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(selectedExample!.description),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Current example
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selectedExample!.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedExample!.color,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      selectedExample!.arabic,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      selectedExample!.roman,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Audio button
                    ElevatedButton.icon(
                      icon: const Icon(Icons.volume_up),
                      label: const Text("Listen Example"),
                      onPressed: () => _playAudio(selectedExample!.audioPath),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedExample!.color,
                        foregroundColor: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Progress indicator when listening
                    if (_isListening)
                      const CircularProgressIndicator(),

                    // Record button
                    ElevatedButton.icon(
                      icon: Icon(_isListening ? Icons.stop : Icons.mic),
                      label: Text(_isListening ? 'Stop Listening' : 'Start Speaking'),
                      onPressed: _isListening ? _stopListening : _startListening,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isListening ? Colors.red : Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Similarity score indicator
                    if (_similarityScore > 0)
                      Column(
                        children: [
                          LinearProgressIndicator(
                            value: _similarityScore,
                            backgroundColor: Colors.grey[200],
                            color: _similarityScore > 0.8
                                ? Colors.green
                                : _similarityScore > 0.6
                                ? Colors.orange
                                : Colors.red,
                          ),
                          Text(
                            'Accuracy: ${(_similarityScore * 100).toStringAsFixed(1)}%',
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),

                    // Spoken text
                    if (_spoken.isNotEmpty)
                      Column(
                        children: [
                          const Text(
                            "You said:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _spoken,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),

                    // Feedback
                    if (_feedback.isNotEmpty)
                      Column(
                        children: [
                          Text(
                            _feedback,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _similarityScore > 0.8
                                  ? Colors.green
                                  : _similarityScore > 0.6
                                  ? Colors.orange
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),

                    // Problem areas
                    if (_problemAreas.isNotEmpty)
                      Column(
                        children: [
                          const Text(
                            "Areas to improve:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ..._problemAreas.map((area) => Text(
                            '• $area',
                            textAlign: TextAlign.start,
                          )),
                          const SizedBox(height: 8),
                        ],
                      ),

                    // Detailed feedback
                    if (_detailedFeedback.isNotEmpty)
                      Card(
                        color: Colors.teal.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            _detailedFeedback,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Example counter
              if (_currentRuleExamples.length > 1)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Example ${_currentExampleIndex + 1} of ${_currentRuleExamples.length}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}