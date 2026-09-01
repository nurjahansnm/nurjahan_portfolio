import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const NurjahanPortfolio());
}

class NurjahanPortfolio extends StatelessWidget {
  const NurjahanPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nurjahan Akther | Flutter Developer',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Arial',
      ),
      home: const PortfolioHome(),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  static const Color navy = Color(0xFF0F172A);
  static const Color flutterBlue = Color(0xFF02569B);
  static const Color lightBlue = Color(0xFF42A5F5);
  static const Color textGrey = Color(0xFF64748B);
  static const Color borderGrey = Color(0xFFE2E8F0);

  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  static const String resumeUrl =
      'https://drive.google.com/file/d/1ZHWtbBYuMtORmthBrzd38aBC-9OctMau/view?usp=drive_link';

  static const String githubUrl =
      'https://github.com/nurjahansnm';

  static const String linkedInUrl =
      'https://www.linkedin.com/in/nurjahan-akther/';

  static const String emailUrl =
      'https://mail.google.com/mail/?view=cm&fs=1&to=nurjahanakther04@gmail.com';

  Future<void> _launchURL(String url) async {
    if (url == 'PASTE_YOUR_RESUME_LINK_HERE') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add your resume link first.'),
        ),
      );
      return;
    }

    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void _scrollTo(GlobalKey key) {
    final currentContext = key.currentContext;

    if (currentContext != null) {
      Scrollable.ensureVisible(
        currentContext,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _navbar(),
            _heroSection(),
            _aboutSection(),
            _skillsSection(),
            _experienceSection(),
            _projectsSection(),
            _contactSection(),
          ],
        ),
      ),
    );
  }

  // ================= NAVBAR =================

  Widget _navbar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 65,
        vertical: 22,
      ),
      color: Colors.white,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool mobile = constraints.maxWidth < 850;

          if (mobile) {
            return Row(
              children: [
                const Text(
                  'NURJAHAN AKTHER',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: navy,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: navy,
                  ),
                  onSelected: (value) {
                    if (value == 'about') {
                      _scrollTo(aboutKey);
                    } else if (value == 'projects') {
                      _scrollTo(projectsKey);
                    } else if (value == 'resume') {
                      _launchURL(resumeUrl);
                    } else if (value == 'contact') {
                      _scrollTo(contactKey);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'about',
                      child: Text('About'),
                    ),
                    PopupMenuItem(
                      value: 'projects',
                      child: Text('Projects'),
                    ),
                    PopupMenuItem(
                      value: 'resume',
                      child: Text('Resume'),
                    ),
                    PopupMenuItem(
                      value: 'contact',
                      child: Text('Contact Me'),
                    ),
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              const Text(
                'NURJAHAN AKTHER',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: navy,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              _navItem(
                'About',
                    () => _scrollTo(aboutKey),
              ),
              _navItem(
                'Projects',
                    () => _scrollTo(projectsKey),
              ),
              _navItem(
                'Resume',
                    () => _launchURL(resumeUrl),
              ),
              const SizedBox(width: 25),
              InkWell(
                onTap: () => _scrollTo(contactKey),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: navy,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Contact Me',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _navItem(
      String text,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF475569),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ================= HERO =================

  Widget _heroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 95,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1220,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool mobile = constraints.maxWidth < 900;

              if (mobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heroContent(),
                    const SizedBox(height: 60),
                    _developerCard(),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: _heroContent(),
                  ),
                  const SizedBox(width: 70),
                  Expanded(
                    flex: 4,
                    child: _developerCard(),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _heroContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hi, I\'m Nurjahan Akther.',
          style: TextStyle(
            color: navy,
            fontSize: 54,
            fontWeight: FontWeight.w800,
            height: 1.08,
            letterSpacing: -1.2,
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'Flutter Developer',
          style: TextStyle(
            color: flutterBlue,
            fontSize: 48,
            fontWeight: FontWeight.w800,
            height: 1.08,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 26),

        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 610,
          ),
          child: Text(
            'I build clean, responsive and user-friendly mobile applications '
                'with Flutter and Dart, with hands-on experience in state management, '
                'REST API integration and reusable UI development.',
            style: TextStyle(
              color: textGrey,
              fontSize: 17,
              height: 1.7,
            ),
          ),
        ),

        const SizedBox(height: 34),

        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _primaryButton(
              'View Projects',
                  () => _scrollTo(projectsKey),
            ),
            _outlineButton(
              'GitHub',
                  () => _launchURL(githubUrl),
            ),
            _outlineButton(
              'Resume',
                  () => _launchURL(resumeUrl),
            ),
          ],
        ),

        const SizedBox(height: 34),

        const Wrap(
          spacing: 24,
          runSpacing: 12,
          children: [
            _MiniSkill(text: 'Flutter'),
            _MiniSkill(text: 'Dart'),
            _MiniSkill(text: 'Provider'),
            _MiniSkill(text: 'REST API'),
          ],
        ),
      ],
    );
  }

  Widget _developerCard() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 445,
      ),
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: borderGrey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 35,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FLUTTER DEVELOPMENT',
            style: TextStyle(
              color: flutterBlue,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'From interface to working app.',
            style: TextStyle(
              color: navy,
              fontSize: 21,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            width: double.infinity,
            height: 330,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Container(
                height: 305,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'assets/images/task_manager.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Task Manager Preview',
                style: TextStyle(
                  color: navy,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ProjectTag(text: 'Flutter'),
              _ProjectTag(text: 'Provider'),
              _ProjectTag(text: 'REST API'),
            ],
          ),
        ],
      ),
    );
  }

  // ================= ABOUT =================

  Widget _aboutSection() {
    return Container(
      key: aboutKey,
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 95,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1180,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool mobile = constraints.maxWidth < 850;

              final aboutText = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('ABOUT ME'),

                  const SizedBox(height: 18),

                  const Text(
                    'Focused on building practical mobile applications.',
                    style: TextStyle(
                      color: navy,
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'I am a Computer Science & Engineering graduate with '
                        'hands-on experience in Flutter and Dart. I have worked '
                        'with Provider state management, REST API integration, '
                        'SharedPreferences, reusable UI components and Git/GitHub.',
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 17,
                      height: 1.75,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'I also completed a three-month Flutter Developer internship '
                        'at VISIE Limited, where I gained practical exposure to UI '
                        'implementation, API integration and collaborative development.',
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 17,
                      height: 1.75,
                    ),
                  ),
                ],
              );

              final infoCard = Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: borderGrey,
                  ),
                ),
                child: const Column(
                  children: [
                    _AboutInfo(
                      icon: Icons.school_outlined,
                      title: 'Education',
                      value: 'B.Sc. in CSE',
                    ),
                    SizedBox(height: 24),
                    _AboutInfo(
                      icon: Icons.work_outline,
                      title: 'Experience',
                      value: 'Flutter Internship',
                    ),
                    SizedBox(height: 24),
                    _AboutInfo(
                      icon: Icons.code_rounded,
                      title: 'Focus',
                      value: 'Flutter Development',
                    ),
                  ],
                ),
              );

              if (mobile) {
                return Column(
                  children: [
                    aboutText,
                    const SizedBox(height: 45),
                    infoCard,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: aboutText,
                  ),
                  const SizedBox(width: 80),
                  Expanded(
                    flex: 4,
                    child: infoCard,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ================= SKILLS =================

  Widget _skillsSection() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 90,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1180,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('TECHNICAL SKILLS'),
              const SizedBox(height: 18),
              const Text(
                'Tools I work with',
                style: TextStyle(
                  color: navy,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool mobile = constraints.maxWidth < 800;

                  final cards = [
                    _skillCard(
                      icon: Icons.phone_android_rounded,
                      title: 'Mobile Development',
                      skills: const [
                        'Flutter',
                        'Dart',
                        'Reusable UI Components',
                        'Responsive UI',
                      ],
                    ),
                    _skillCard(
                      icon: Icons.account_tree_outlined,
                      title: 'State & Data',
                      skills: const [
                        'Provider',
                        'REST API Integration',
                        'SharedPreferences',
                        'JSON Handling',
                      ],
                    ),
                    _skillCard(
                      icon: Icons.terminal_rounded,
                      title: 'Tools & Web',
                      skills: const [
                        'Git',
                        'GitHub',
                        'HTML',
                        'CSS',
                      ],
                    ),
                  ];

                  if (mobile) {
                    return Column(
                      children: [
                        cards[0],
                        const SizedBox(height: 20),
                        cards[1],
                        const SizedBox(height: 20),
                        cards[2],
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: cards[0]),
                      const SizedBox(width: 22),
                      Expanded(child: cards[1]),
                      const SizedBox(width: 22),
                      Expanded(child: cards[2]),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _skillCard({
    required IconData icon,
    required String title,
    required List<String> skills,
  }) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderGrey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: flutterBlue,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          ...skills.map(
                (skill) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_rounded,
                    color: lightBlue,
                    size: 17,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      skill,
                      style: const TextStyle(
                        color: textGrey,
                        fontSize: 14,
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

  // ================= EXPERIENCE =================

  Widget _experienceSection() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 95,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1180,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool mobile = constraints.maxWidth < 850;

              final experience = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('EXPERIENCE'),
                  const SizedBox(height: 18),
                  const Text(
                    'Flutter Developer Intern',
                    style: TextStyle(
                      color: navy,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'VISIE Limited  •  Feb 2026 – Apr 2026',
                    style: TextStyle(
                      color: flutterBlue,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _experienceBullet(
                    'Developed and refined reusable Flutter UI components.',
                  ),
                  _experienceBullet(
                    'Assisted with REST API integration and application data handling.',
                  ),
                  _experienceBullet(
                    'Collaborated with team members on UI implementation and development tasks.',
                  ),
                ],
              );

              final education = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionLabel('EDUCATION & TRAINING'),
                  const SizedBox(height: 18),
                  _educationItem(
                    'B.Sc. in Computer Science & Engineering',
                    'Green University of Bangladesh',
                    '2020 – 2026',
                  ),
                  const SizedBox(height: 22),
                  _educationItem(
                    'App Development with Flutter',
                    'Ostad',
                    'Completed Aug 2026',
                  ),
                ],
              );

              if (mobile) {
                return Column(
                  children: [
                    experience,
                    const SizedBox(height: 60),
                    education,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: experience,
                  ),
                  const SizedBox(width: 80),
                  Expanded(
                    flex: 4,
                    child: education,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _experienceBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7),
            child: Icon(
              Icons.circle,
              size: 6,
              color: lightBlue,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: textGrey,
                fontSize: 16,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _educationItem(
      String title,
      String place,
      String date,
      ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: borderGrey,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            place,
            style: const TextStyle(
              color: textGrey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            date,
            style: const TextStyle(
              color: flutterBlue,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ================= PROJECTS =================

  Widget _projectsSection() {
    return Container(
      key: projectsKey,
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1180,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('FEATURED PROJECTS'),
              const SizedBox(height: 18),
              const Text(
                'Projects I\'ve Built',
                style: TextStyle(
                  color: navy,
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'A selection of Flutter projects where I practiced mobile UI '
                    'development, state management, API integration and local data persistence.',
                style: TextStyle(
                  color: textGrey,
                  fontSize: 17,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 50),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 900) {
                    return Column(
                      children: [
                        _projectCard(
                          number: '01',
                          title: 'Task Manager with Provider',
                          description:
                          'A Flutter task management application with authentication, '
                              'profile management, task CRUD operations, task status workflows, '
                              'password recovery and API integration.',
                          technologies: const [
                            'Flutter',
                            'Dart',
                            'Provider',
                            'REST API',
                            'SharedPreferences',
                          ],
                          github:
                          'https://github.com/nurjahansnm/task_manager_provider',
                          featured: true,
                        ),
                        const SizedBox(height: 25),
                        _projectCard(
                          number: '02',
                          title: 'Quick Notes Keeper',
                          description:
                          'A notes application with create, edit, delete, search, validation, '
                              'priority/date fields and persistent local storage.',
                          technologies: const [
                            'Flutter',
                            'Dart',
                            'SharedPreferences',
                          ],
                          github:
                          'https://github.com/nurjahansnm/quick_notes_keeper',
                        ),
                        const SizedBox(height: 25),
                        _projectCard(
                          number: '03',
                          title: 'YouTube Lite',
                          description:
                          'A lightweight Flutter application using WebView with loading states, '
                              'navigation controls and refresh.',
                          technologies: const [
                            'Flutter',
                            'Dart',
                            'WebView',
                          ],
                          github:
                          'https://github.com/nurjahansnm/youtube_lite',
                        ),
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _projectCard(
                          number: '01',
                          title: 'Task Manager with Provider',
                          description:
                          'A Flutter task management application with authentication, '
                              'profile management, task CRUD operations, task status workflows, '
                              'password recovery and API integration.',
                          technologies: const [
                            'Flutter',
                            'Dart',
                            'Provider',
                            'REST API',
                            'SharedPreferences',
                          ],
                          github:
                          'https://github.com/nurjahansnm/task_manager_provider',
                          featured: true,
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: _projectCard(
                          number: '02',
                          title: 'Quick Notes Keeper',
                          description:
                          'A notes application with create, edit, delete, search, validation, '
                              'priority/date fields and persistent local storage.',
                          technologies: const [
                            'Flutter',
                            'Dart',
                            'SharedPreferences',
                          ],
                          github:
                          'https://github.com/nurjahansnm/quick_notes_keeper',
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: _projectCard(
                          number: '03',
                          title: 'YouTube Lite',
                          description:
                          'A lightweight Flutter application using WebView with loading states, '
                              'navigation controls and refresh.',
                          technologies: const [
                            'Flutter',
                            'Dart',
                            'WebView',
                          ],
                          github:
                          'https://github.com/nurjahansnm/youtube_lite',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectCard({
    required String number,
    required String title,
    required String description,
    required List<String> technologies,
    required String github,
    bool featured = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: featured
              ? lightBlue
              : borderGrey,
          width: featured ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                number,
                style: const TextStyle(
                  color: lightBlue,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              if (featured)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'FEATURED',
                    style: TextStyle(
                      color: flutterBlue,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 25),
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.phone_android_rounded,
              color: flutterBlue,
              size: 28,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            style: const TextStyle(
              color: textGrey,
              fontSize: 14.5,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 25),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: technologies
                .map(
                  (tech) => _ProjectTag(
                text: tech,
              ),
            )
                .toList(),
          ),
          const SizedBox(height: 28),
          InkWell(
            onTap: () => _launchURL(github),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.code_rounded,
                  color: navy,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'View on GitHub',
                  style: TextStyle(
                    color: navy,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_outward_rounded,
                  color: navy,
                  size: 17,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= CONTACT =================

  Widget _contactSection() {
    return Container(
      key: contactKey,
      width: double.infinity,
      color: navy,
      padding: const EdgeInsets.symmetric(
        horizontal: 70,
        vertical: 95,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 900,
          ),
          child: Column(
            children: [
              const Text(
                'LET\'S CONNECT',
                style: TextStyle(
                  color: lightBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Let\'s build something meaningful.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'I am open to Flutter development opportunities, internships '
                    'and collaborative projects where I can contribute, learn and grow.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFCBD5E1),
                  fontSize: 17,
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 14,
                runSpacing: 14,
                alignment: WrapAlignment.center,
                children: [
                  _contactButton(
                    'GitHub',
                    Icons.code_rounded,
                        () => _launchURL(githubUrl),
                  ),
                  _contactButton(
                    'LinkedIn',
                    Icons.business_center_outlined,
                        () => _launchURL(linkedInUrl),
                  ),
                  _contactButton(
                    'Email',
                    Icons.email_outlined,
                        () => _launchURL(emailUrl),
                  ),
                  _contactButton(
                    'Resume',
                    Icons.description_outlined,
                        () => _launchURL(resumeUrl),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              const Divider(
                color: Colors.white12,
              ),
              const SizedBox(height: 25),
              const Text(
                '© 2026 Nurjahan Akther • Flutter Developer',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactButton(
      String text,
      IconData icon,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: navy,
              size: 19,
            ),
            const SizedBox(width: 9),
            Text(
              text,
              style: const TextStyle(
                color: navy,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= COMMON =================

  Widget _sectionLabel(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 3,
          decoration: BoxDecoration(
            color: lightBlue,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: flutterBlue,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _primaryButton(
      String text,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: navy,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _outlineButton(
      String text,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 26,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: const Color(0xFFCBD5E1),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: navy,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ================= SMALL WIDGETS =================

class _MiniSkill extends StatelessWidget {
  final String text;

  const _MiniSkill({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.check_circle,
          color: Color(0xFF42A5F5),
          size: 18,
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF475569),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _AboutInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _AboutInfo({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2FE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF02569B),
            size: 23,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProjectTag extends StatelessWidget {
  final String text;

  const _ProjectTag({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF02569B),
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}