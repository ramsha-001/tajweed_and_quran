import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class SurahScreen extends StatefulWidget {
  static const routeName = '/surah-screen';

  const SurahScreen({super.key});

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int? _currentlyPlayingIndex;
  Duration? _currentPosition;

  bool _shouldShowProgress(int index) {
    return _currentlyPlayingIndex == index &&
        _audioPlayer.duration != null &&
        _audioPlayer.position < _audioPlayer.duration!;
  }

  final List<Map<String, dynamic>> _surahList = [
    {
      'surah': 'سورة الفيل',
      'text': 'أَلَمْ تَرَ كَيْفَ فَعَلَ رَبُّكَ بِأَصْحَابِ الْفِيلِ ﴿١﴾ أَلَمْ يَجْعَلْ كَيْدَهُمْ فِي تَضْلِيلٍ ﴿٢﴾ وَأَرْسَلَ عَلَيْهِمْ طَيْرًا أَبَابِيلَ ﴿٣﴾ تَرْمِيهِمْ بِحِجَارَةٍ مِّن سِجِّيلٍ ﴿٤﴾ فَجَعَلَهُمْ كَعَصْفٍ مَّأْكُولٍ ﴿٥﴾',
      'audioPath': 'assets/audios/surah_al_fil.mp3',
      'number': '105',
      'translation': 'The Elephant',
      'tajweedRules': <Map<String, dynamic>>[
        {'position': 69, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 68, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {
          'position': 159,
          'rule': 'ikhfa meem saakin',
          'color': Colors.lightGreen
        },
        {
          'position': 158,
          'rule': 'ikhfa meem saakin',
          'color': Colors.lightGreen
        },
        {'position': 171, 'rule': 'idgham', 'color': Colors.red},
        {'position': 174, 'rule': 'idgham', 'color': Colors.red},
        {'position': 173, 'rule': 'idgham', 'color': Colors.red},
        {'position': 176, 'rule': 'ikhfa', 'color': Colors.green[800]},
        {'position': 215, 'rule': 'idgham', 'color': Colors.red},
        {'position': 213, 'rule': 'idgham', 'color': Colors.red},
        {'position': 214, 'rule': 'idgham', 'color': Colors.red},
        {'position': 211, 'rule': 'idgham', 'color': Colors.red},
      ],
    },
    {
      'surah': 'سورة قريش',
      'text': 'لِإِيلَافِ قُرَيْشٍ ﴿١﴾ إِيلَافِهِمْ رِحْلَةَ الشِّتَاءِ وَالصَّيْفِ ﴿٢﴾ فَلْيَعْبُدُوا رَبَّ هَٰذَا الْبَيْتِ ﴿٣﴾ الَّذِي أَطْعَمَهُم مِّن جُوعٍ وَآمَنَهُم مِّنْ خَوْفٍ ﴿٤﴾',
      'audioPath': 'assets/audios/surah_quraish.mp3',
      'number': '106',
      'translation': 'The Quraysh',
      'tajweedRules': [
        {'position': 125, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 126, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {
          'position': 133,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
        {
          'position': 135,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
        {
          'position': 136,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
        {
          'position': 137,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
        {'position': 138, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 144, 'rule': 'idgham', 'color': Colors.red},
        {'position': 146, 'rule': 'idgham', 'color': Colors.red},
        {'position': 147, 'rule': 'idgham', 'color': Colors.red},
        {
          'position': 155,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
        {
          'position': 157,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
        {
          'position': 158,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
        {
          'position': 159,
          'rule': 'idgham meem saakin',
          'color': Colors.pink[400]
        },
      ],
    },
    {
      'surah': 'سورة الماعون',
      'text': 'أَرَأَيْتَ الَّذِي يُكَذِّبُ بِالدِّينِ ﴿١﴾ فَذَٰلِكَ الَّذِي يَدُعُّ الْيَتِيمَ ﴿٢﴾ وَلَا يَحُضُّ عَلَىٰ طَعَامِ الْمِسْكِينِ ﴿٣﴾ فَوَيْلٌ لِّلْمُصَلِّينَ ﴿٤﴾ الَّذِينَ هُمْ عَن صَلَاتِهِمْ سَاهُونَ ﴿٥﴾ الَّذِينَ هُمْ يُرَاءُونَ ﴿٦﴾ وَيَمْنَعُونَ الْمَاعُونَ ﴿٧﴾',
      'audioPath': 'assets/audios/surah_al_maun.mp3',
      'number': '107',
      'translation': 'The Small Kindnesses',
      'tajweedRules': [
        {'position': 177, 'rule': 'ikhfa', 'color': Colors.green[700]},
      ],
    },
    {
      'surah': 'سورة الكوثر',
      'text': 'إِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ ﴿١﴾ فَصَلِّ لِرَبِّكَ وَانْحَرْ ﴿٢﴾ إِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ ﴿٣﴾',
      'audioPath': 'assets/audios/surah_al_kauther.mp3',
      'number': '108',
      'translation': 'The Abundance',
      'tajweedRules': [
        {'position': 2, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 3, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 4, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 71, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 72, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 73, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 95, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 96, 'rule': 'qalqalah', 'color': Colors.orange[500]},

      ],
    },
    {
      'surah': 'سورة الكافرون',
      'text': 'قُلْ يَا أَيُّهَا الْكَافِرُونَ ﴿١﴾ لَا أَعْبُدُ مَا تَعْبُدُونَ ﴿٢﴾ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ﴿٣﴾ وَلَا أَنَا عَابِدٌ مَّا عَبَدتُّمْ ﴿٤﴾ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ﴿٥﴾ لَكُمْ دِينُكُمْ وَلِيَ دِينِ ﴿٦﴾',
      'audioPath': 'assets/audios/surah_al_kafirun.mp3',
      'number': '109',
      'translation': 'The Disbelievers',
      'tajweedRules': [
        {'position': 77, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 104, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 105, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 129, 'rule': 'idgham', 'color': Colors.red},
        {'position': 131, 'rule': 'idgham', 'color': Colors.red},
        {'position': 132, 'rule': 'idgham', 'color': Colors.red},
        {'position': 133, 'rule': 'idgham', 'color': Colors.red},
        {'position': 159, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 186, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 187, 'rule': 'qalqalah', 'color': Colors.orange[500]},
      ],
    },
    {
      'surah': 'سورة النصر',
      'text': 'إِذَا جَاءَ نَصْرُ اللَّهِ وَالْفَتْحُ ﴿١﴾ وَرَأَيْتَ النَّاسَ يَدْخُلُونَ فِي دِينِ اللَّهِ أَفْوَاجًا ﴿٢﴾ فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚ إِنَّهُ كَانَ تَوَّابًا ﴿٣﴾',
      'audioPath': 'assets/audios/surah_an_nasar.mp3',
      'number': '110',
      'translation': 'The Divine Support',
      'tajweedRules': [
        {'position': 56, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 57, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 58, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 65, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 66, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 155, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 156, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 157, 'rule': 'ghunnah', 'color': Colors.blue},
      ],
    },
    {
      'surah': 'سورة المسد',
      'text': 'تَبَّتْ يَدَا أَبِي لَهَبٍ وَتَبَّ ﴿١﴾ مَا أَغْنَىٰ عَنْهُ مَالُهُ وَمَا كَسَبَ ﴿٢﴾ سَيَصْلَىٰ نَارًا ذَاتَ لَهَبٍ ﴿٣﴾ وَامْرَأَتُهُ حَمَّالَةَ الْحَطَبِ ﴿٤﴾ فِي جِيدِهَا حَبْلٌ مِّن مَّسَدٍ ﴿٥﴾',
      'audioPath': 'assets/audios/surah_tabat.mp3',
      'number': '111',
      'translation': 'The Palm Fiber',
      'tajweedRules': [
        {'position': 25, 'rule': 'idgham', 'color': Colors.red},
        {'position': 27, 'rule': 'idgham', 'color': Colors.red},
        {'position': 28, 'rule': 'idgham', 'color': Colors.red},
        {'position': 31, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 32, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 33, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 77, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 78, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 112, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 113, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 135, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 136, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 137, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 151, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 152, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 173, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 174, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 176, 'rule': 'idgham', 'color': Colors.red},
        {'position': 178, 'rule': 'idgham', 'color': Colors.red},
        {'position': 179, 'rule': 'idgham', 'color': Colors.red},
        {'position': 180, 'rule': 'idgham', 'color': Colors.red},
        {'position': 181, 'rule': 'idgham', 'color': Colors.red},
        {'position': 182, 'rule': 'idgham', 'color': Colors.red},
        {'position': 183, 'rule': 'idgham', 'color': Colors.red},
        {'position': 184, 'rule': 'idgham', 'color': Colors.red},
        {'position': 185, 'rule': 'idgham', 'color': Colors.red},
        {'position': 188, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 189, 'rule': 'qalqalah', 'color': Colors.orange[500]},
      ],
    },
    {
      'surah': 'سورة الإخلاص',
      'text': 'قُلْ هُوَ اللَّهُ أَحَدٌ ﴿١﴾ اللَّهُ الصَّمَدُ ﴿٢﴾ لَمْ يَلِدْ وَلَمْ يُولَدْ ﴿٣﴾ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ ﴿٤﴾',
      'audioPath': 'assets/audios/surah_al_ikhlas.mp3',
      'number': '112',
      'translation': 'The Sincerity',
      'tajweedRules': [
        {'position': 22, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 23, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 44, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 45, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 60, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 61, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 75, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 76, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 113, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 114, 'rule': 'qalqalah', 'color': Colors.orange[500]},

      ],
    },
    {
      'surah': 'سورة الفلق',
      'text': 'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ﴿١﴾ مِن شَرِّ مَا خَلَقَ ﴿٢﴾ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ﴿٣﴾ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ﴿٤﴾ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ ﴿٥﴾',
      'audioPath': 'assets/audios/surah_al_falaq.mp3',
      'number': '113',
      'translation': 'The Daybreak',
      'tajweedRules': [
        {'position': 28, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 29, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 37, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 53, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 54, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 64, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 90, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 91, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 101, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 111, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 112, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 113, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 135, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 136, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 146, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 172, 'rule': 'qalqalah', 'color': Colors.orange[500]},
        {'position': 173, 'rule': 'qalqalah', 'color': Colors.orange[500]},

      ],
    },
    {
      'surah': 'سورة الناس',
      'text': 'قُلْ أَعُوذُ بِرَبِّ النَّاسِ ﴿١﴾ مَلِكِ النَّاسِ ﴿٢﴾ إِلَٰهِ النَّاسِ ﴿٣﴾ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ﴿٤﴾ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ﴿٥﴾ مِنَ الْجِنَّةِ وَالنَّاسِ ﴿٦﴾',
      'audioPath': 'assets/audios/surah_an_naas.mp3',
      'number': '114',
      'translation': 'The Mankind',
      'tajweedRules': [
        {'position': 23, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 24, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 25, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 43, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 44, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 45, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 64, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 65, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 66, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 77, 'rule': 'ikhfa', 'color': Colors.green[700]},
        {'position': 103, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 104, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 105, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 147, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 148, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 149, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 168, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 169, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 170, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 178, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 179, 'rule': 'ghunnah', 'color': Colors.blue},
        {'position': 180, 'rule': 'ghunnah', 'color': Colors.blue},

      ],
    },
  ];
  @override
  void initState() {
    super.initState();
    _initAudio();
    _setupAudioPlayerListeners();
  }

  Future<void> _initAudio() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  void _setupAudioPlayerListeners() {
    // Add this position listener
    _audioPlayer.positionStream.listen((position) {
      if (mounted) setState(() {});
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) setState(() {});
    });
  }

  Future<void> _playAudio(String audioPath, int index) async {
    try {
      // If clicking the currently playing surah
      if (_currentlyPlayingIndex == index) {
        // Toggle play/pause
        if (_audioPlayer.playing) {
          await _audioPlayer.pause();
        } else {
          if (_audioPlayer.processingState == ProcessingState.completed) {
            await _audioPlayer.seek(Duration.zero);
          }
          await _audioPlayer.play();
        }
      }
      // If selecting a different surah
      else {
        await _audioPlayer.stop();
        setState(() => _currentlyPlayingIndex = index);
        await _audioPlayer.setAsset(audioPath);
        await _audioPlayer.play();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }


  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/Images/gumbad.jpeg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.srcOver,
                  ),
                ),
              ),
              child: FlexibleSpaceBar(
                title: Text(
                  'Surahs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [const Shadow(color: Colors.black, blurRadius: 25)],
                  ),
                ),
                centerTitle: true,
                background: Container(color: Colors.transparent),
              ),
            ),
          ),

          // Surah List
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final surah = _surahList[index];
                return _buildSurahCard(context, surah, index);
              },
              childCount: _surahList.length,
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildSurahCard(BuildContext context, Map<String, dynamic> surah, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _showSurahDetail(context, surah, index),
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.teal[800]!.withOpacity(0.8),
                Colors.green[900]!.withOpacity(0.9),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                bottom: 17,
                child: Opacity(
                  opacity: 0.2,
                  child: const Icon(Icons.mosque, size: 70, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          surah['number'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            surah['surah'],
                            style: GoogleFonts.scheherazadeNew(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            surah['translation'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_currentlyPlayingIndex == index &&
                            _audioPlayer.duration != null &&
                            _audioPlayer.position < _audioPlayer.duration!)
                          CircularProgressIndicator(
                            value: _audioPlayer.position.inMilliseconds /
                                _audioPlayer.duration!.inMilliseconds,
                            strokeWidth: 2,
                            color: Colors.orange[100],
                            backgroundColor: Colors.white.withOpacity(0.3),
                          ),
                        IconButton(
                          icon: Icon(
                            _currentlyPlayingIndex == index && _audioPlayer.playing
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            size: 36,
                            color: Colors.white,
                          ),
                          onPressed: () => _playAudio(surah['audioPath'], index),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSurahDetail(BuildContext context, Map<String, dynamic> surah, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            // Initialize with current player state
            bool isPlaying = _currentlyPlayingIndex == index && _audioPlayer.playing;
            Duration currentPosition = _audioPlayer.position;

            // Set up listeners
            final playerSubscription = _audioPlayer.playerStateStream.listen((state) {
              if (_currentlyPlayingIndex == index && mounted) {
                setModalState(() {
                  isPlaying = state.playing;
                });
              }
            });

            final positionSubscription = _audioPlayer.positionStream.listen((position) {
              if (_currentlyPlayingIndex == index && mounted) {
                setModalState(() {
                  currentPosition = position;
                });
              }
            });

            // Cancel subscriptions when modal is disposed
            ModalRoute.of(context)?.addScopedWillPopCallback(() async {
              playerSubscription.cancel();
              positionSubscription.cancel();
              return true;
            });

            return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            surah['surah'],
                            style: GoogleFonts.scheherazadeNew(
                              fontSize: 36,
                              color: Colors.teal[700],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.teal[50],
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.teal[200]!,
                                width: 1,
                              ),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: _highlightCustomTajweed(
                                    surah['text'],
                                    surah['tajweedRules'] ?? [],
                                  ),
                                  style: GoogleFonts.amiri(
                                    fontSize: 28,
                                    height: 3.5,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Column(
                            children: [
                              if (_currentlyPlayingIndex == index && _audioPlayer.duration != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        _formatDuration(currentPosition),
                                        style: TextStyle(color: Colors.teal[700]),
                                      ),
                                      Expanded(
                                        child: Slider(
                                          value: currentPosition.inMilliseconds.toDouble().clamp(
                                              0,
                                              _audioPlayer.duration!.inMilliseconds.toDouble()
                                          ),
                                          min: 0,
                                          max: _audioPlayer.duration!.inMilliseconds.toDouble(),
                                          onChanged: (value) async {
                                            await _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                                          },
                                          activeColor: Colors.teal,
                                          inactiveColor: Colors.teal[100],
                                        ),
                                      ),
                                      Text(
                                        _formatDuration(_audioPlayer.duration!),
                                        style: TextStyle(color: Colors.teal[700]),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                icon: Icon(
                                  isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill_outlined,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  isPlaying
                                      ? "Pause Recitation"
                                      : "Play Recitation",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal[600],
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 3,
                                ),
                                onPressed: () async {
                                  await _playAudio(surah['audioPath'], index);
                                  setModalState(() {
                                    isPlaying = _currentlyPlayingIndex == index && _audioPlayer.playing;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  List<TextSpan> _highlightCustomTajweed(String text, List<dynamic> rules) {
    final lines = text.split('\n');
    List<TextSpan> spans = [];

    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      for (int i = 0; i < line.length; i++) {
        String char = line[i];
        TextStyle style = TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.w800,
          fontSize: 24,
        );

        for (var rule in rules) {
          if (rule['position'] == i) {
            style = style.copyWith(
              color: rule['color'] ?? Colors.grey[800],
            );
            break;
          }
        }

        spans.add(TextSpan(text: char, style: style));
      }

      spans.add(TextSpan(text: '\n'));
    }

    return spans;
  }
}