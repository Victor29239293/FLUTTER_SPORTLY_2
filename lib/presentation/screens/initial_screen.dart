import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sportly_2/presentation/providers/competition_provider_state.dart';
import 'package:go_router/go_router.dart';

class InitialScreen extends ConsumerStatefulWidget {
  static const routeName = '/initial';

  const InitialScreen({super.key});

  @override
  ConsumerState<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends ConsumerState<InitialScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(competitionProvider.notifier).loadCompetitions();
  }

  @override
  Widget build(BuildContext context) {
    final competitions = ref.watch(competitionProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'SPORTLY',
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Competencias Disponibles',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Selecciona una competencia para comenzar',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.85,
                ),
                itemCount: competitions.length,
                itemBuilder: (context, index) {
                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, double value, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: CompetitionCard(
                            name: competitions[index].name,
                            emblemUrl: competitions[index].emblem,
                            code: competitions[index].code,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompetitionCard extends StatefulWidget {
  final String name;
  final String emblemUrl;
  final String code;
  const CompetitionCard({
    super.key,
    required this.name,
    required this.emblemUrl,
    required this.code,
  });

  @override
  State<CompetitionCard> createState() => _CompetitionCardState();
}

class _CompetitionCardState extends State<CompetitionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: () {
              context.go(
                '/initial/home/${widget.code}/0',
              ); // Navigate to HomeView with code
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _isPressed
                      ? [Colors.white, const Color(0xFFF5F5F5)]
                      : [Colors.white, Colors.white],
                ),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: _isPressed
                        ? Colors.blue.withOpacity(0.2)
                        : Colors.black.withOpacity(0.08),
                    blurRadius: _isPressed ? 20 : 15,
                    offset: _isPressed
                        ? const Offset(0, 8)
                        : const Offset(0, 6),
                    spreadRadius: _isPressed ? 2 : 0,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.9),
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
                border: Border.all(
                  color: _isPressed
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.1),
                  width: 1.5,
                ),
              ),
              child: CustomCompetition(
                name: widget.name,
                emblemUrl: widget.emblemUrl,
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomCompetition extends StatelessWidget {
  final String name;
  final String emblemUrl;
  const CustomCompetition({
    super.key,
    required this.name,
    required this.emblemUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.2;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                width: iconSize,
                height: iconSize,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFF8F9FA), Colors.white],
                  ),
                ),
                child: Image.network(
                  emblemUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey[300]!, Colors.grey[400]!],
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Icon(
                        Icons.sports_soccer,
                        color: Colors.white,
                        size: 32,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
