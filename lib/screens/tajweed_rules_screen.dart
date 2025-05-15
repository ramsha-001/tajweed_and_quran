import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TajweedRulesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> mainTajweedRules = [
    {
      'title': '✴  Makhaarij al-Huroof (مخارج الحروف)',
      'description': 'Explanation of the Makhaarij al-Huroof rule and its significance.',
    },
    {
      'title': '✴  Sifaat al-Huroof (صفات الحروف)',
      'description': 'Explanation of the Sifaat al-Huroof rule and its significance.',
    },
    {
      'title': '✴  Rules of Noon and Meem Mushaddada (احکام نون اور میم مشددہ)',
      'description': 'Explanation of the Noon and Meem Mushaddada rules and their significance.',
    },
    {
      'title': '✴  Waqf and Ibtida (وقف اور ابتدا )',
      'description': 'Explanation of the rules for Waqf and Ibtida\' and their significance.',
    },
  ];

  final List<Map<String, dynamic>> basicTajweedRules = [
    {
      'title': '✴  Ikhfa (اخفاء)',
      'description': 'Explanation of the rules for Ikhfa\' and their significance.',
      'examples': [
        {
          'text': 'مِن سِجِيلٍٍْ',
          'audio': 'assets/audios/ikhfa_min_sijjeel.mp3',
          'tajweedRules': [
            {'position': 2, 'rule': 'ikhfa', 'color': Colors.green[700]},
            {'position': 3, 'rule': 'ikhfa', 'color': Colors.green[700]},
          ]
        },
        {
          'text': 'أَنْتُمْ',
          'audio': 'assets/audios/ikhfa_annn_tum.mp3',
          'tajweedRules': [
            {'position': 2, 'rule': 'ikhfa', 'color': Colors.green[700]},
            {'position': 3, 'rule': 'ikhfa', 'color': Colors.green[700]},
          ]
        },
      ],
    },
    {
      'title': '✴  Ghunna (غُنَّه)',
      'description': 'Explanation of the rules for Ghunna\' and their significance.',
      'examples': [
        {
          'text': 'إِنَّهُ',
          'audio': 'assets/audios/ghunna_innnahoo.mp3',
          'tajweedRules': [
            {'position': 2, 'rule': 'ghunna', 'color': Colors.blue},
            {'position': 3, 'rule': 'ghunna', 'color': Colors.blue},
          ]
        },
        {
          'text': 'حَمَّالَةَ ٱلْحَطَب',
          'audio': 'assets/audios/ghunna_hammma_latal_hatab.mp3',
          'tajweedRules': [
            {'position': 2, 'rule': 'ghunna', 'color': Colors.blue},
            {'position': 3, 'rule': 'ghunna', 'color': Colors.blue},
            {'position': 4, 'rule': 'ghunna', 'color': Colors.blue},
          ]
        },
      ],
    },

    {
      'title': '✴  Ikhfa Meem Saakin (ب)',
      'description': 'Explanation of the rules for Ikhfa Meem Saakin\' and their significance.',
      'examples': [
        {
          'text': 'تَرْمِيهِم بِحِجَارَةٍِۢ',
          'audio': 'assets/audios/ikhfa_meemSaakin_tarmeehimm_behijaratin.mp3',
          'tajweedRules': [
            {'position': 9, 'rule': 'ikhfa Meem Saakin', 'color': Colors.lightGreen},
          ]
        },
      ],
    },

    {
      'title': '✴  Idghaam (ادغام)',
      'description': 'Explanation of the rules for Idgham\' and their significance.',
      'examples': [
        {
          'text': 'لَهَبٍ وَتَبَّ',
          'audio': 'assets/audios/idgham_lahabi,nWatab.mp3',
          'tajweedRules': [
            {'position': 5, 'rule': 'idghaam', 'color': Colors.red},
            {'position': 6, 'rule': 'idghaam', 'color': Colors.red},
            {'position': 7, 'rule': 'idghaam', 'color': Colors.red},
            {'position': 8, 'rule': 'idghaam', 'color': Colors.red},
          ]
        },
      ],
    },
    {
      'title': '✴  Qalqlah (قلقله)',
      'description': 'Explanation of the rules for Qalqlah\' and their significance.',
      'examples': [
        {
          'text': 'وَتَبَّ',
          'audio': 'assets/audios/qalqalah_watabb.mp3',
          'tajweedRules': [
            {'position': 4, 'rule': 'qalqalah', 'color': Colors.orange[500]},
            {'position': 5, 'rule': 'qalqalah', 'color': Colors.orange[500]},
            {'position': 6, 'rule': 'qalqalah', 'color': Colors.orange[500]},

          ]
        },
        {
          'text': 'ٱلْفَلَقِ',
          'audio': 'assets/audios/qalqalah_falaqqq.mp3',
          'tajweedRules': [
            {'position': 7, 'rule': 'qalqalah', 'color': Colors.orange[500]},
            {'position': 8, 'rule': 'qalqalah', 'color': Colors.orange[500]},

          ]
        },
        {
          'text': 'أَحَدٌ',
          'audio': 'assets/audios/qalqalah_aahadd.mp3',
          'tajweedRules': [
            {'position': 4, 'rule': 'qalqalah', 'color': Colors.orange[500]},
            {'position': 5, 'rule': 'qalqalah', 'color': Colors.orange[500]},

          ]
        },
      ],
    },
    {
      'title': '✴  Idghaam Meem Saakin (م)',
      'description': 'Explanation of the rules for Idghaam Meem Saakin\' and their significance.',
      'examples': [
        {
          'text': 'أَطْعَمَهُم مِن جُوعٍۢ',
          'audio': 'assets/audios/idgham_meemSakin_at_aamaahum_min_joo_inn.mp3',
          'tajweedRules': [
            {'position': 10, 'rule': 'idghaam Meem Saakin', 'color': Colors.pinkAccent},
            {'position': 12, 'rule': 'idghaam Meem Saakin', 'color': Colors.pinkAccent},
            {'position': 13, 'rule': 'idghaam Meem Saakin', 'color': Colors.pinkAccent},

          ]
        },
        {
          'text': 'وَءَامَنَهُم مِنْ خَوْفٍۢ  ',
          'audio': 'assets/audios/idgham_meemSakin_waa_aa_manahum_min_khof.mp3',
          'tajweedRules': [
            {'position': 11, 'rule': 'idghaam Meem Saakin', 'color': Colors.pinkAccent},
            {'position': 12, 'rule': 'idghaam Meem Saakin', 'color': Colors.pinkAccent},
            {'position': 13, 'rule': 'idghaam Meem Saakin', 'color': Colors.pinkAccent},

          ]
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tajweed Rules'),
        backgroundColor: Colors.brown[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/backgrounddd.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            //  _buildSectionTitle('Main Tajweed Rules'),
            _buildRulesList(context, mainTajweedRules),
            SizedBox(height: 20),
            _buildBasicRulesButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRulesList(BuildContext context, List<Map<String, dynamic>> rules) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: rules.length,
      itemBuilder: (context, index) {
        final rule = rules[index];
        return _buildRuleCard(context, rule);
      },
    );
  }

  Widget _buildRuleCard(BuildContext context, Map<String, dynamic> rule) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TajweedRuleDetailScreen(
              ruleTitle: rule['title'],
              ruleData: rule, // Pass the entire rule data
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.green[200]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              rule['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.arrow_right, color: Colors.white),
          ),
        ),
      ),
    );
  }


  Widget _buildBasicRulesButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown[300],
        padding: EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        'View Basic Tajweed Rules',
        style: TextStyle(fontSize: 18),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BasicTajweedRulesScreen(basicRules: basicTajweedRules),
        ),
      ),
    );
  }
}

class BasicTajweedRulesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> basicRules;

  BasicTajweedRulesScreen({required this.basicRules});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Tajweed Rules'),
        backgroundColor: Colors.brown[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/backgrounddd.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: basicRules.length,
          itemBuilder: (context, index) {
            return _buildRuleCard(context, basicRules[index]);
          },
        ),
      ),
    );
  }

  Widget _buildRuleCard(BuildContext context, Map<String, dynamic> rule) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TajweedRuleDetailScreen(
              ruleTitle: rule['title'],
              ruleData: rule, // Pass the entire rule data
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orangeAccent, Colors.green[200]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              rule['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            trailing: Icon(Icons.arrow_right, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class TajweedRuleDetailScreen extends StatefulWidget {
  final String ruleTitle;
  final Map<String, dynamic>? ruleData;

  const TajweedRuleDetailScreen({
    Key? key,
    required this.ruleTitle,
    this.ruleData,
  }) : super(key: key);

  @override
  _TajweedRuleDetailScreenState createState() => _TajweedRuleDetailScreenState();
}

class _TajweedRuleDetailScreenState extends State<TajweedRuleDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;
  bool _isPlaying = false;
  bool _isLoadingAudio = false;
  double _playbackPosition = 0.0;
  double _playbackDuration = 1.0; // Default to 1 to avoid division by zero
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(int index, String audioPath) async {
    try {
      if (_currentlyPlayingIndex == index && _isPlaying) {
        await _audioPlayer.pause();
        setState(() => _isPlaying = false);
        _positionSubscription?.cancel();
        _durationSubscription?.cancel();
      } else {
        setState(() {
          _isLoadingAudio = true;
          _currentlyPlayingIndex = index;
        });

        // Cancel previous subscriptions
        _positionSubscription?.cancel();
        _durationSubscription?.cancel();

        await _audioPlayer.setAsset(audioPath);

        // Set up duration subscription
        _durationSubscription = _audioPlayer.durationStream.listen((duration) {
          if (duration != null) {
            setState(() => _playbackDuration = duration.inMilliseconds.toDouble());
          }
        });

        // Set up position subscription
        _positionSubscription = _audioPlayer.positionStream.listen((position) {
          setState(() => _playbackPosition = position.inMilliseconds.toDouble());
        });

        await _audioPlayer.play();

        setState(() {
          _isPlaying = true;
          _isLoadingAudio = false;
        });
      }
    } catch (e) {
      setState(() => _isLoadingAudio = false);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error playing audio: ${e.toString()}"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ruleTitle),
        backgroundColor: Colors.brown[300],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/backgrounddd.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: _buildRuleDetails(),
        ),
      ),
    );
  }

  List<Widget> _buildRuleDetails() {
    List<Map<String, dynamic>> sections = _getRuleSections(widget.ruleTitle);
    List<Widget> detailWidgets = [];



    // Add sections
    for (var section in sections) {
      detailWidgets.add(
        _buildSectionCard(
          title: section['title'],
          content: section['content'],
          color: section['color'] ?? Colors.white,
          image: section.containsKey('image') ? section['image'] : null,
        ),
      );
    }

    // Add examples if they exist
    if (widget.ruleData != null && widget.ruleData!['examples'] != null) {
      detailWidgets.add(
        _buildExamplesSection(widget.ruleData!['examples']),
      );
    }

    /*
    // Add description if exists
    if (widget.ruleData != null && widget.ruleData!['description'] != null) {
      detailWidgets.add(
        _buildSectionCard(
          title: 'Description',
          content: widget.ruleData!['description'],
          color: Colors.blueGrey,
        ),
      );
    }


     */
    return detailWidgets;
  }

  Widget _buildPlayButton(int index, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _currentlyPlayingIndex == index && _isPlaying
              ? Colors.brown[600]!
              : Colors.brown[300]!,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _isLoadingAudio && _currentlyPlayingIndex == index
                ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.brown[800],
              ),
            )
                : Icon(
              _currentlyPlayingIndex == index && _isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.brown[800],
              size: 20,
            ),
          ),
          SizedBox(width: 8),
          Text(
            'Play Example',
            style: TextStyle(
              fontSize: 16,
              color: Colors.brown[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesSection(List<Map<String, dynamic>> examples) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.withOpacity(0.1),
              Colors.deepPurple.withOpacity(0.2),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.deepPurple.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.deepPurple[300]),
                      SizedBox(width: 8),
                      Text(
                        'Practical Examples',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepPurple[800],
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  ...examples.asMap().entries.map((entry) {
                    final index = entry.key;
                    final example = entry.value;
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Arabic Text Container
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: _highlightCustomTajweed(
                                        example['text'],
                                        example['tajweedRules'] ?? [],
                                      ),
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontFamily: 'Kitab',
                                        height: 2.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Play Button Container
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _playAudio(index, example['audio']),
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(12)),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(12)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: _currentlyPlayingIndex == index
                                                ? Colors.deepPurple[100]
                                                : Colors.deepPurple[50],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: AnimatedSwitcher(
                                              duration:
                                              Duration(milliseconds: 300),
                                              child: _isLoadingAudio &&
                                                  _currentlyPlayingIndex ==
                                                      index
                                                  ? SizedBox(
                                                width: 18,
                                                height: 18,
                                                child:
                                                CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  color:
                                                  Colors.deepPurple[800],
                                                ),
                                              )
                                                  : Icon(
                                                _currentlyPlayingIndex ==
                                                    index &&
                                                    _isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.deepPurple[800],
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          _currentlyPlayingIndex == index &&
                                              _isPlaying
                                              ? 'Playing...'
                                              : 'Listen Example',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.deepPurple[800],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Progress indicator when playing
                        if (_currentlyPlayingIndex == index)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                LinearProgressIndicator(
                                  value: _playbackDuration > 0
                                      ? (_playbackPosition / _playbackDuration)
                                      .clamp(0.0, 1.0)
                                      : 0,
                                  backgroundColor: Colors.deepPurple[100],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.deepPurple),
                                  minHeight: 3,
                                ),
                                SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(
                                          Duration(milliseconds: _playbackPosition.toInt())),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.deepPurple[600],
                                      ),
                                    ),
                                    Text(
                                      _formatDuration(
                                          Duration(milliseconds: _playbackDuration.toInt())),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.deepPurple[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (index != examples.length - 1)
                          Divider(
                            color: Colors.deepPurple.withOpacity(0.1),
                            height: 24,
                            thickness: 1,
                          ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  List<TextSpan> _highlightCustomTajweed(String text, List<dynamic> rules) {
    List<TextSpan> spans = [];

    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      TextStyle style = TextStyle(
        color: Colors.brown[900],
        fontWeight: FontWeight.bold,
      );

      // Check if this position has a tajweed rule
      for (var rule in rules) {
        if (rule['position'] == i) {
          style = style.copyWith(
            color: rule['color'] ?? Colors.brown[900],
            // Add any additional styling for tajweed rules
            fontWeight: FontWeight.bold,
          );
          break;
        }
      }

      spans.add(TextSpan(text: char, style: style));
    }

    return spans;
  }

  Widget _buildSectionCard({
    required String title,
    required String content,
    required Color color,
    String? image,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: color.withOpacity(0.8),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: color.withOpacity(0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[900],
              ),
            ),
            SizedBox(height: 8),
            if (content.isNotEmpty)
              Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown[800],
                  height: 1.4,
                ),
              ),
            if (image != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }

// ... (keep existing _getRuleSections and other helper methods)
  List<Map<String, dynamic>> _getRuleSections(String ruleTitle) {
    if (ruleTitle == '✴  Makhaarij al-Huroof (مخارج الحروف)') {
      return [
        {
          'title': 'Definition of Makhaarij',
          'content': '• Makhaarij-ul-huroof (Articulation points), is the place of emitting the letter when pronouncing a specific letter. \n'
              '• The pronunciation will differ from one letter to another letter depending on the articulation points..\n\n'
              'The five main Makharij are:\n\n'
              '1. Al-Jawf\n'
              '2. Al-Halq\n'
              '3. Al-Lisaan\n'
              '4. Ash-Shafataan\n'
              '5. Al-Khayshoom\n',
          'image': 'assets/Images/5-points-in-makharij-removebg-preview.png',
          'color': Colors.green[500],
        },
        {
          'title': '1. Makhraj Al-Jawf  ( The oral cavity ) ',
          'content': 'It is the articulation point in the empty space of throat and mouth.\n\n'
              'Letters included:\n\n1- Alif (ا) with a Fathah before it.\n'
              '2- Yaa’ (ي) with a Kasrah before it.\n'
              '3- Waaw (و) with a Dammah before it.\n\nCollective word for these letters: نُوحِيهَا',
          'image': 'assets/Images/Al-JAWFF-removebg-preview.png',
          'color': Colors.purple[800],
        },
        {
          'title': '2. Makhraj Al-Halq  ( The throat ) ',
          'content': 'Al-Huruf Al-Halqiyah (الحروف الحلقية) or Throat letters are the six Arabic letters (ع, هـ, خ, ح, غ, أ) that are pronounced from deep within the throat.\n\n'
              'Letters included:\nWithin the throat, there are three points of articulation \n\n'
              '1- The deepest part of the throat produces two letters:\n   Haa’ ( هـ ), pronounced “hh”\n   Hamzah ( ء ), pronounced as a glottal stop \n\n'
              '2- The mid-throat is the point of articulation for the following two:\n   Haa’ ( ح ), pronounced “hh”\n   ‘Ayn ( ع ), pronounced “ ‘a ”\n\n'
              '3- From the upper throat emerge two letters. These are:\n   Khaa’ ( خ ), pronounced “kh”\n   Gyan ( غ ), pronounced “gh”',
          'image': 'assets/Images/HALG-removebg-preview.png',
          'color': Colors.amber[700],
        },
        {
          'title': '3. Makhraj Al-Lisaan  ( The tongue )',
          'content': 'This  refers to the specific areas of the tongue used to produce Arabic letters correctly. '
              '\nThe tongue articulates 18 letters from 4 main regions:\n\n'
              '1. Deepest Area Of Tongue:'
              '\n    ق – Back presses up (throat) '
              '\n    ك – Back presses up but slightly in middle  '
              '\n          lighter touch\n\n '
              '2. Middle Area Of Tongue:'
              '\n    ج – Mid-tongue flattens '
              '\n    ش – Mid-tongue rises slightly '
              '\n    ي – Mid-tongue curves up '
              '\n\n3. Tongue Edges (Sides Molar): '
              '\n     ض – Back edge connects to upper molar teeth'
              '\n\n4. Head Of The Tongue:'
              '\n     ل – Tip taps upper gums '
              '\n     ن –Tip touches behind front teeth'
              '\n     ر – Tip flickers lightly  (quick touches the '
              '\n          gum ridge, and bounces back) \n\n'
              '5. Tip of the Tongue:'
              '\n     ت – Tip touches upper teeth'
              '\n     د – Like ت  but voiced'
              '\n     ط – Tip presses upper teeth harder (heavy ت)'
              '\n     ث – Tip between teeth'
              '\n     ذ – Like ث  but voiced'
              '\n     ظ – Like ذ  but deeper'
              '\n     س – Tip near teeth, air flows'
              '\n     ص – Stronger س  (more pressure)'
              '\n     ز – Like س  but buzzing',
          'image': 'assets/Images/al-lisan-2.png',
          'color': Colors.lightGreen,
        },
        {
          'title': '4. Makhraj Sayafatain   ( The lips )',
          'content': 'This refers to the articulation that involves the two lips.\n'
              'یہ وہ مخارج ہے جو دونوں ہونٹوں سے ادا ہوتے ہیں\n\n'
              'Letters Included: \n\n'
              '1. Faa’ (ف): Produced by placing the edges of the upper front teeth against the inside of the lower lip.\n'
              '2. Waaw (و): Formed by rounding or circling both lips.\n'
              '3. Meem (م): Made by bringing both lips together.\n'
              '4. Baa’ (ب): Similar to Meem but with a firmer closure of the lips.',
          'image': 'assets/Images/Sayafataan-removebg-preview.png',
          'color': Colors.redAccent,
        },
        {
          'title': '5. Makhraj Al-Khayshoum  '
              '\n    ( The nasal cavity )',
          'content': 'This articulation point involves the nasal passage.\n'
              'یہ وہ مخرج ہے جو ناک کی نالی سے تعلق رکھتا ہے\n\n'
              'Letters Included:\n\n'
              'This point is where Ghunnah occurs, meaning the sound is emitted through the nose rather than the mouth.\n\n'
              'Ghunnah Explanation:\n'
              'Ghunnah is the nasal sound characteristic of the letters Noon (ن) and Meem (م). When pronouncing these letters with Ghunnah, you’ll feel a light vibration or hum that resonates in the nose. Ghunnah is especially applied when Noon and Meem are doubled (with shaddah) or in specific Tajweed rules, making the recitation smoother and more melodious.\n\n'
              'How Ghunnah works:\n'
              'To understand how ghunnah works (and its significance), block your nose completely by pinching it with two fingers, then try to say a word with the letter noon or meem, or simply sound the letter ( أنْ ) or ( أمْ ). You’ll notice that you are unable to sound these letters properly without the nasal passage being open (and producing ghunnah)!',
          'image': 'assets/Images/Ghunnnaaaa-removebg-preview.png',
          'color': Colors.lightBlue,
        },
      ];
    }
    else if (ruleTitle == '✴  Sifaat al-Huroof (صفات الحروف)') {
      return [
        {
          'title': 'Definition',
          'content': 'Sifaat al-Huroof (صفات الحروف) refers to the unique characteristics of Arabic letters that affect their pronunciation.\n'
              '\n\n NOTE: While Makhaarij tells us where a letter’s sound originates, Sifaat explains how the sound is produced. These characteristics help distinguish letters with the same articulation point, ensuring accurate recitation.\n\n'
              'There are two main types of Sifaat:\n\n'
              '(I). Permanent Sifaat with Opposites (الصفات اللازمة المتضادة): These letters have contrasting characteristics.\n\n'
              '(II). Permanent Sifaat without Opposites (الصفات اللازمة الغير متضادة): These letters have unique characteristics without opposites.',
          'color': Colors.green[500], // Unique color for this section
        },
        {
          'title': 'Part I: Permanent Sifaat with Opposites (الصفات اللازمة المتضادة)',
          'content': '1). Al-Hams (الْهَمْسُ) vs Al-Jahr (الجَهْرُ)\n'
              '2). Ash-shidda (الشِّدَّةُ), Al-baynya (البَينية), Ar-'
              '\n      Rakhawa (الرَّخَاوَةُ)\n'
              '3). Al-istiala (الاِسْتِعَلاءُ) vs Al-istifal (الاسْتِفَالُ)\n'
              '4). Al-itbaq (الإِطْبَاق) vs. Al infitah (الإِنْفِتَاح)\n'
              '5). Al-idhlaq (الإِذْلاقُ) vs. Al ismat (الإِصْمَات)',
          'color': Colors.deepOrange,
        },
        {
          'title': '1).  Al Hams (الْهَمْسُ) - The Whisper',
          'content': '• The term Al-Hams in Arabic means “the whisper.” \n'
              '• This concept refers to the airflow that accompanies the articulation of 10 specific letters:\n'
              '\n     ف – ح – ث – ه – ش – خ – ص – س – ك – ت\n\n'
              '• To help remember these letters, you can use the mnemonic phrase:\n'
              '\n                             فَحَثَّهُ شَخْصٌ سَكَتَ\n\n'
              '• When pronouncing these letters, especially when they carry a sukoon ( ْ ), the airflow continues after the sound of the letter is produced.\n\n'
              'EXAMPLES:\n'
              '\n                               الرَّحْمن – بِاسْمِ\n\n'
              'NOTE:\n\n'
              'The whispering is also present when the letter has a harakaat (other than sukoon), but it is not as strong (it is more of a natural hems whereas when it carries a sukoon you have to emphasize the hems more).',

          'image': 'assets/Images/Al-hams.png',
          'color': Colors.indigoAccent, // Unique color for this section
        },
        {
          'title': 'Al Jahr (الجَهْرُ) - The Loud Voice',
          'content': '• In Arabic, Al-Jahr means "the loud voice" \n'
              '• It refers to a complete stop of airflow during the pronunciation of these 19 letters:\n'
              '\n      ا – ب –  ج – د – ذ –  – ز- ض – ط – ظ – ع – غ '
              '\n                    ق – ل – م – ن – و – ء – ي \n\n'
              '• To memorize these letters, use the phrase:\n'
              '\n                  عَظُمَ وَزْنُ قَارِئٍ غَضٍّ ذِي طَلَبَ جِد\n\n'
              '• Airflow stops immediately after articulating these letters, creating a distinct sound.\n\n'
              'EXAMPLES:\n'
              '\n                          الحَمْدُ – يُؤْمِنُونَ – نَعْبُدُ',
          'image': 'assets/Images/Al-jahr.png',
          'color': Colors.indigoAccent, // Unique color for this section
        },
        {
          'title': '2. Ash-shidda (الشِّدَّةُ) - The Intensity',
          'content': '• In Arabic, “al-shidda” signifies intensity.\n'
              '• Ash-Shidda refers to the complete stop of sound flow when pronouncing these 8 letters:\n'
              '\n                ت – ك – ب – ط – ق – د – ج – أ \n\n'
              '• To memorize them, use the phrase:\n'
              '\n                                 أَجِدْ قَطٍ بَكَتْ \n\n'
              '• The sound halts as it relies firmly on its makhraj (articulation point).\n\n'
              'EXAMPLES:\n'
              '\n                  انشَقَّتِ – تُبْلَى – رَكَّبَكَ – يَجْتَبِي  ',
          'image': 'assets/Images/Ash-shidda.png',
          'color': Colors.red[800], // Unique color for this section
        },
        {
          'title': 'Al baynya (البَينية) or At-tawasut (التَّوَسُط)',
          'content': '• This characteristic represents a middle ground between Ash-Shidda (complete stop) and Ar-Rakhawa (continuous flow). \n'
              '• The sound is balanced, neither abrupt nor prolonged, in these 5 letters:\n\n'
              '\n  ر – م – ع – ن – ل \n\n'
              '• To remember them, use the phrase:\n'
              '\n   لِنْ عُمَر\n\n'
              'EXAMPLES: \n'
              '\n  الأرْضِ – الدِّيْنِ – نَعْبُدُ – الحَمْدُ \n',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[800], // Unique color for this section
        },
        {
          'title': 'Ar-Rakhawa (الرَّخَاوَةُ) – Flexibility',
          'content': '• Ar-Rakhawa refers to the continuous flow of sound when pronouncing these 15 letters:\n'
              '\n   و – ه – ف – غ – ظ – ض – ص – ش – س – ز – ذ – خ – ح – ث – ا\n'
              '• The sound elongates during articulation.\n\n'
              'EXAMPLES:\n'
              '\n أَظْلَمَ – نَسْتَعِيْنُ – يُغْنِيكُمُ – الرَّحْمَنِ\n\n'
              'NOTE: Sound duration varies:\n'
              '⦿ Ar-Rakhawa: Longest sound\n'
              '⦿ Al-Bayniyah: Balanced sound\n'
              '⦿ Ash-Shidda: Shortest sound (interrupted)',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[800], // Unique color for this section
        },
        {
          'title': '3. Al-istiala (الاِسْتِعَلاءُ) - Elevation',
          'content': '• Al-Isti’la means "elevation" in Arabic.\n '
              '• It describes the upward pressure exerted on the palate when pronouncing these 7 emphatic letters:\n'
              '\n   ظ – خ – ص – ض – غ – ط – ق   \n\n'
              '• To remember them, use the phrase:\n'
              '\n   خُصَّ ضَغْطٍ قِط\n\n'
              'DEGREES OF TAFKHEEM (Emphasis):\n'
              'i) Strongest: Letter with fatha followed by an alif.\n'
              'ii) Letter with fatha but no alif.\n'
              'iii) Letter with damma.\n'
              'iv) Letter with sukoon.\n'
              'v) Weakest: Letter with kasra.',
          //'image': 'assets/Images/--.png',
          'color': Colors.yellow[800], // Unique color for this section
        },
        {
          'title': 'Al-istifal (الاسْتِفَالُ) - Lowering',
          'content': '• In Arabic, Al-Istifal means "lowering".\n'
              '• It refers to the downward pressure on the palate during pronunciation, making the letters light (Al-Tarqeeq – التَّرْقِيق).\n\n'
              'LETTERS:\n'
              'The remaining 22 letters exhibit this quality:\n'
              '\nا – ب – ت – ث – ج – ح – د – ذ – ر – ز – س – ش – ع – ف – ك – ل – م – ن – ه – و – ء – ي\n\n'
              'SPECIAL CASE: \n'
              '\n        ر – ل – ا      \n\n'
              'These 3 letters can be pronounced as either emphatic (Tafkheem) or light (Tarqeeq) depending on context.',
          //'image': 'assets/Images/--.png',
          'color': Colors.yellow[800], // Unique color for this section
        },
        {
          'title': '4. Al-Itbaq (الإِطْبَاق) – Adhesion',
          'content': 'In Arabic, Al-Itbaq means "to stick"\n'
              ' It describes how part of the tongue adheres to the palate during pronunciation.\n\n'
              'LETTERS: \n'
              '\n             ظ – ط – ض – ص         \n',
          //'image': 'assets/Images/--.png',
          'color': Colors.blueGrey, // Unique color for this section
        },
        {
          'title': 'Al-Infitah (الإِنْفِتَاح) – Separation',
          'content': 'Al-Infitah means "separation" in Arabic. It refers to the opening between the tongue and the palate during pronunciation.\n\n'
              'Letters:\n'
              '\nا – ب – ت – ث – ج – ح – خ – د – ذ – ر – ز – س – ش – ع – غ – ف – ق – ك – ل – م – ن – ه – و – ء – ي',
          //'image': 'assets/Images/--.png',
          'color': Colors.blueGrey, // Unique color for this section
        },
        {
          'title': '5. Al-Idhlaq (الإِذْلاقُ) – Fluidity',
          'content': 'Al-Idhlaq refers to the smooth and effortless pronunciation of certain letters. \n'
              'Though not always categorized as a primary sifat, it is recognized for its unique ease.\n\n'
              'LETTERS (6 in total): \n\n'
              '\n ب – ل – م – ن – ر – ف \n\n'
              'MEMONIC SENTENCE: \n'
              '\n فَرَّ مِنْ لُبٍّ \n\n'
              'KEY POINT: \n'
              'The pronunciation involves the tip of the tongue or the lips.',
          //'image': 'assets/Images/--.png',
          'color': Colors.pinkAccent, // Unique color for this section
        },
        {
          'title': 'Al-Ismat (الإِصْمَات) – Heaviness',
          'content': 'Al-Ismat refers to letters with a heavier articulation, lacking the ease of fluidity seen in Idhlaq.\n\n'
              'LETTERS:\n'
              '\n ا – ت – ث – ج – ح – خ – د – ذ – ز – س – ش – ص – ض – ط – ظ – ع – غ – ق – ك – ه – و – ء – ي\n\n'
              'Key Point:\n'
              'These letters are pronounced without significant use of the tongue’s tip or the lips.',
          //'image': 'assets/Images/--.png',
          'color': Colors.pinkAccent, // Unique color for this section
        },
        {
          'title': 'Part II: Permanent Sifaat without Opposites (الصِفَات غَيْر المُتَضادَة)',
          'content': '1. As-Safeer (الصَفِير)\n'
              '2. Al-Qalqala (القَلْقَلَة)\n'
              '3. Al-leen (اللِّيْن)\n'
              '4. Al inhiraf (الإِنْحِراف)\n'
              '5. At-takreer (التَّكْرِير)\n'
              '6. At tafashee (التَّفَشِي)\n'
              '7. Al istitala (الإِسْتِطَالَة)',
          'color': Colors.deepOrange, // Unique color for this section
        },
        {
          'title': '1. As-Safeer (الصَفِير) – Whistling',
          'content': 'In Arabic, As-Safeer means "whistling"\n'
              'It refers to a distinct whistle-like sound during pronunciation.\n\n'
              'LETTERS: '
              '\n  ⦿  ص:  Sounds like a goose.'
              '\n  ⦿    ز:  Buzzes like a bee.'
              '\n  ⦿  س:  Resembles the chirping of a cacida.\n\n'
              'KEY POINT:\n'
              'The whistle-like sound is generated as air passes between the lips, making these letters known as “the whistling letters.”',
          //'image': 'assets/Images/--.png',
          'color': Colors.lightGreen[600], // Unique color for this section
        },
        {
          'title': '2. Al-Qalqala (القَلْقَلَة) – Echo or Bounce',
          'content': 'Al-Qalqala refers to a distinct bouncing sound created when specific letters are pronounced in a state of sukoon (absence of vowel).\n\n'
              'LETTERS: '
              '\n                         ق – ط – ب – ج – د      \n\n'
              'MEMONIC:'
              '\n                                  قُطُبٌ جَدٍ          \n\n'
              'KEY CHARACTERISTICS: \n'
              '\n  ⦿ The sound bounces due to the quick '
              '\n       separation of articulation points '
              '\n       without opening the mouth or moving the '
              '\n       lips or jaw. '
              '\n  ⦿ The bounce’s strength depends on the letter: '
              '\n  ⦿ Strongest: ط '
              '\n  ⦿ Intermediate: ج '
              '\n  ⦿ Least Pronounced: د – ب – ق\n\n'
              'EXAMPLE:'
              '\n                              تَبَّتْ يَدَا أَبِي لَهَبٍ   ',
          //'image': 'assets/Images/--.png',
          'color': Colors.blue, // Unique color for this section
        },
        {
          'title': '3. Al-Leen (اللِّيْن) – Gentleness',
          'content': 'In Arabic, Al-Leen means "gentleness"\n'
              'It describes a soft and effortless sound during pronunciation.\n\n'
              'LETTERS: '
              '\n  و and ي (when they bear sukoon and are preceded by a fatha). \n\n'
              'KEY CHARACTERISTICS: '
              '\n  ⦿ Produces a gentle, flowing sound.'
              '\n  ⦿ Requires minimal effort to articulate.\n\n'
              'EXAMPLE: '
              '\n              الَّذِي أَطْعَمَهُم مِّن جُوعٍ وَآمَنَهُم مِّنْ خَوْفٍ',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[800], // Unique color for this section
        },
        {
          'title': '4. Al-Inhiraf (الإِنْحِراف) – Deviation',
          'content': 'In Arabic, Al-Inhiraf means "deviation"\n'
              'It describes a shift in sound away from its original articulation point.\n\n'
              'LETTERS: '
              '\n                      ل (Lam) and ر (Raa)   \n\n'
              'KEY CHARACTERISTICS: \n'
              '\n  ⦿ ل (Lam): Sound moves to the sides of the '
              '\n                      tongue.'
              '\n  ⦿ ر (Raa): Sound shifts from the tip of the '
              '\n                      tongue slightly backward.'
              '\n\nThese letters “deviate” in pronunciation, creating a unique flow in their sound.',
          //'image': 'assets/Images/--.png',
          'color': Colors.purpleAccent, // Unique color for this section
        },
        {
          'title': '5. At-Takreer (التَّكْرِير) – Repetition',
          'content': 'At-Takreer means "repetition".\n'
              'It refers to the vibration of the tongue when pronouncing the letter:\n'
              '\n                                ر (Raa)\n\n'
              'KEY POINTS: '
              '\n  ⦿ The tongue vibrates or rolls slightly during '
              '\n      articulation.'
              '\n  ⦿ Avoid excessive vibration to prevent '
              '\n      mispronunciation.\n\n'
              '⁍ TIP: \n'
              ' For ر (Raa), the tongue should tap the palate once. If the letter is stressed (رّ), control the vibration to keep it smooth.',
          //'image': 'assets/Images/--.png',
          'color': Colors.teal[400], // Unique color for this section
        },
        {
          'title': '6. At-Tafashee (التَّفَشِّي) – Propagation',
          'content': 'At-Tafashee means "spreading" and describes the flow of air throughout the mouth when pronouncing: \n'
              '\n                                ش (Sheen)\n\n'
              'KEY POINTS: '
              '\n  ⦿ The breath spreads or diffuses inside the '
              '\n      mouth.'
              '\n  ⦿ This is unique to the letter ش (Sheen).',
          //'image': 'assets/Images/--.png',
          'color': Colors.yellow[700], // Unique color for this section
        },
        {
          'title': '7. Al-Istitala (الإِسْتِطَالَة) – Elongation',
          'content': 'Al-Istitala means "stretching". \n'
              'It refers to the extended sound when pronouncing:\n'
              '\n                              ض (Dad)\n\n'
              'KEY POINTS: '
              '\n  ⦿ The sound stretches along the tongue '
              '\n      towards the articulation point of ل (Lam).'
              '\n  ⦿ This is specific to the letter ض (Dad).',
          //'image': 'assets/Images/--.png',
          'color': Colors.blueGrey, // Unique color for this section
        },
      ];
    }
    else if (ruleTitle ==
        '✴  Rules of Noon and Meem Mushaddada (احکام نون اور میم مشددہ)') {
      return [
        {
          'title': 'What is Mushaddad or Shaddah?',
          'content': '• It consists of two letters, the first with sukoon '
              '\n   and the second with a Harakah.\n'
              '• The Saakin letter merges with the Mutaharik '
              '\n   letter pronouncing them like one letter making '
              '\n   a Shaddah\n'
              '\n                                رَ بْ بَ = ربّْ   \n'
              '\n      إِنْ + نَ = إِنَّ          ثُمْ + مَ = ثُمَّ        لَمْ + مَا = لَمَّا ',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[800], // Unique color for this section
        },
        {
          'title': 'What is Ghunna?',
          'content': 'The ghunnah is defined as:\n "a nasal sound that is emitted from the nose."\n\n'
              '• Noon and Meem are called letters of ghunnah',
          //'image': 'assets/Images/--.png',
          'color': Colors.blue,
        },
        {
          'title': 'Noon Mushaddadah (النون المشددة)',
          'content': '• It refers to a  ن  letter that has a Shaddah diacritic sign ( ــّ ) on it.\n\n'
              '• It means that the letter  ن  has to be pronounced twice or doubled.',
          'image': 'assets/Images/noooooon.png',
          'color': Colors.amber[700], // Unique color for this section
        },
        {
          'title': 'Meem Mushaddadah (الميم المشددة)',
          'content': '• It refers to a  م  letter that has a Shaddah diacritic sign ( ــّ ) on it.\n\n'
              '• It means that the letter  م  is pronounced twice or doubled.',
          'image': 'assets/Images/image-removebg-preview (14).png',
          'color': Colors.lightGreen[600], // Unique color for this section
        },
      ];
    }
    else if (ruleTitle == '✴  Waqf and Ibtida (وقف اور ابتدا )') {
      return [
        {
          'title': '                   SIGNS OF STOPPING',
          'content': '',
          'image': 'assets/Images/image-removebg-preview (22).png',
          'color': Colors.red[900], // Unique color for this section
        },
        {
          'title': '○  The Conclusion of Verse',
          'content': '⇒ It indicates the end of a verse. \n'
              '⇒ Also known as "Perfect Stop". \n'
              '⇒ Recitor has to Stop and take a breath before '
              '\n     continuing. \n'
              '⇒ It shows that the message in the verse is '
              '\n     complete.',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[900],
        },
        {
          'title': 'مـ   The Compulsory Stop',
          'content': '⇒ "Laazim" means "essential." \n'
              '⇒ It means You must stop here. \n'
              '⇒ Skipping this pause can change the meaning '
              '\n     of the verse drastically.',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[900],
        },
        {
          'title': '∴   The Embracing Stop',
          'content': '⇒ “Mu’aanaqah” is a sign in the Quran that'
              '\n      indicates to stop at any of the three items in '
              '\n      the triplet, without discontinuing '
              '\n      simultaneously ',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[900],
        },
        {
          'title': 'وقف غفران   The Sign of Supplication',
          'content': '⇒ “Waqf e Ghufraan” is a symbol indicating a '
              '\n      place where the recite and listener should '
              '\n      stop to make a prayer in front of Allah SWT. ',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[900],
        },
        {
          'title': 'قف   The Anticipation Mark',
          'content': '⇒ “Qif” is inserted on the stop sign to clarifies '
              '\n      that a pause is not strictly necessary here. ',
          //'image': 'assets/Images/--.png',
          'color': Colors.red[900],
        },
        {
          'title': '                   SIGNS OF PAUSING',
          'content': '',
          'image': 'assets/Images/isf-removebg-preview (1).png',
          'color': Colors.orange[800], // Unique color for this section
        },
        {
          'title': 'ص   The Licensed Pause',
          'content': 'Pause only if necessary, like when tired. Otherwise, it’s better to continue. ',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': 'ط  The Absolute Pause',
          'content': '“Waqf e Mutlaq” is stop sign to indicate the reader to take a gap in reciting the long passage by taking breath. It helps with understanding the passage.',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': 'صل  The Permissible Pause',
          'content': '"Qad Yusal" means you can continue reading, but it’s better to stop here.',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': 'ج   The Permissible Stop',
          'content': '"Waqf e Jaaiz" indicates that you need to stop here as the topic discussed is complete, but it is not mandatory. Stopping allows time to absorb the message.',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': 'س   The Silence Symbol',
          'content': '“Saktah” is a sign to indicate a very brief pause without breaking your breath. You can continue recitation afterward.',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': 'وقفتہ  The Longer Pause',
          'content': '“Waqfah” indicates the longer pause than Saktah with the same gist of not breaking one`s breath while taking the break.',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': 'وقف النبی  The Pause of Prophet PBUH',
          'content': '“Waqf-un-Nabi” shows the parts of Quran where the Messenger ﷺ of God Himself stopped and took pause.  ',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': 'وقف منزل  The Pause Sign of Jibrael A.S',
          'content': '“Waqf e Manzil” is the sign indicating the Angel, Jibrael`s stopping and taking pause at the time of revealing the Quranic Instructions over the Holy Prophet ﷺ.  ',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange[800],
        },
        {
          'title': '                SIGNS OF CONTINUING',
          'content': '',
          'image': 'assets/Images/image-removebg-preview (32).png',
          'color': Colors.green[800], // Unique color for this section
        },
        {
          'title': 'صلے  Preference for Continuation',
          'content': '"Al-wasl Awlaa" suggests continuing recitation without stopping.',
          //'image': 'assets/Images/--.png',
          'color': Colors.green[800],
        },
        {
          'title': 'ز   Continue Reading',
          'content': '"Waqf e Mujawwaz" indicates that you should keep reading, though it’s not forbidden to pause here.',
          //'image': 'assets/Images/--.png',
          'color': Colors.green[800],
        },
        {
          'title': 'لا   No Need of Stopping',
          'content': '⇒ Do not stop reading when you see the "Laa" '
              '\n     sign, because it can change the meaning of '
              '\n     the Quran.\n'
              '⇒ But you can stop if the "Laa" sign is at the '
              '\n     end of a verse with a circle mark.',
          //'image': 'assets/Images/--.png',
          'color': Colors.green[800],
        },
        {
          'title': 'ك   Similar Meaning as Previous Sign',
          'content': 'It suggests to follow the instruction of the previous sign.',
          //'image': 'assets/Images/--.png',
          'color': Colors.green[800],
        },
      ];
    }
    else if (ruleTitle == '✴  Ikhfa (اخفاء)') {
      return [
        {
          'title' : 'Ikhfa'
              '\n (ت ث خ د ذ ز س ش ص ض ط ظ ف ق ك)',
          'content' : '\n If any of these letters appear after noon sakin or tanveen, then the sound of noon is hidden in the nose and ghunna is performed. \n\n'
              'نون ساکن یا تنوین کے بعد اگر ان میں سے کوئی حرف آجائے تو نون کو ناک میں چھپا کر اخفاء مع الغنہ کریں گے۔',
          //'image' : 'assets/Images/--.png',
          'color' : Colors.green[700],
        }
      ];
    }
    else if (ruleTitle == '✴  Ghunna (غُنَّه)') {
      return [
        {
          'title': 'Ghunna '
              '\n (ن م)',
          'content': '\nIf tashdeed comes on any of these letters, ghunna is performed. To do Ghunna: Retaining the sound of noon and meem mushadad for a little while in the nose causing a ringing sound, called ghunna.\n\n'
              'ان حروف پر اگر تشدید آجائے تو غنہ کریں گے۔'
              '\n غنہ کرنا: نون یا میم مشدد کی آواز کو تھوڑی دیر ناک میں ٹھہرا کر گنگنی آواز میں پڑھنے کو غنہ کہتے ہیں',
          //'image': 'assets/Images/--.png',
          'color': Colors.blue, // Unique color for this section
        },
      ];
    }

    else if (ruleTitle == '✴  Ikhfa Meem Saakin (ب)') {
      return [
        {
          'title': 'Ikhfa Meem Saakin '
              '\n اخفاء میم ساکن (ب)',
          'content': 'If after meem sakin letter baa appears, the sound of meem is hidden in the nose and ghunna is performed.\n\n'
              'اخفاء میم ساکن:  میم ساکن کے بعد اگر حرف "ب" آجائے تو میم کی آواز ناک میں چھپا کر اخفاء شفوی کریں گے۔',
          //'image': 'assets/Images/--.png',
          'color': Colors.lightGreen, // Unique color for this section
        },
      ];
    }

    else if (ruleTitle == '✴  Idghaam (ادغام)') {
      return [
        {
          'title': 'Idghaam '
              '\n (ي و م ن)',
          'content': '\nIf any of these letters appear after noon sakin or tanveen; Idghaam with ghunna is performed.\n\n'
              'نون ساکن یا تنوین کے بعد ان حروف میں سے کوئی حرف آجائے تو غنہ کے ساتھ ادغام کریں گے۔',
          //'image': 'assets/Images/--.png',
          'color': Colors.red, // Unique color for this section
        },
      ];
    }
    else if (ruleTitle == '✴  Qalqlah (قلقله)') {
      return [
        {
          'title': 'Qalqlah '
              '\n (ق ط ب ج د )',
          'content': '\nQalqla is done on these words if they appear in their sakin form or you are stopping on them. Qalqla voice bounces back.\n\n'
              'ان حروف پر قلقله کیا جائے گا، جب یہ ساکن ہوں یا ان پر وقف کیاجائے۔ قلقلہ کی آواز منہ میں ٹکرا کر واپس آ جاتی ہے۔',
          //'image': 'assets/Images/--.png',
          'color': Colors.orange, // Unique color for this section
        },
      ];
    }
    else if (ruleTitle == '✴  Idghaam Meem Saakin (م)') {
      return [
        {
          'title': 'Idghaam Meem Saakin'
              '\n ادغام میم ساکن (م)',
          'content': '\nIf after meem sakin letter meem appears, the sound of meem is pronounced obviously with ghunna.\n\n'
              'میم ساکن کے بعد اگر حرف میم آجائے تو میم کی آواز کو واضح کرتے ہوئے ادغام مع الغنہ کریں گے۔',
          //'image': 'assets/Images/--.png',
          'color': Colors.pink, // Unique color for this section
        },
      ];
    }
    return [];
  }

}