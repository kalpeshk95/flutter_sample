import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/locator.dart';
import '../../../core/theme/font_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _progressController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _progressAnimation;

  String _loadingMessage = 'Initializing app...';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
    _loadResources();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() async {
    await _logoController.forward();
    _textController.forward();
    _progressController.forward();
  }

  Future<void> _loadResources() async {
    try {
      _updateLoadingMessage('Checking connectivity...');
      final connectivityResult = await Connectivity().checkConnectivity();

      if (connectivityResult == ConnectivityResult.none) {
        _updateLoadingMessage('Offline mode detected...');
      }

      _updateLoadingMessage('Loading fonts...');
      await FontLoaderUtil.loadFonts().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          _updateErrorMessage('Font loading timed out');
        },
      );

      _updateLoadingMessage('Setting up services...');
      await setupLocator().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          _updateErrorMessage('Service setup timed out');
        },
      );

      _updateLoadingMessage('Almost ready...');

      // Wait for minimum splash screen duration or until animations complete
      const minDuration = Duration(milliseconds: 2500);
      const animationDuration = Duration(milliseconds: 2900);

      await Future.delayed(
        minDuration.compareTo(animationDuration) > 0 ? minDuration : animationDuration,
      );

      if (mounted && _errorMessage == null) {
        context.go('/');
      }
    } catch (e) {
      _updateErrorMessage('Initialization failed: ${e.toString()}');

      // Still navigate after a delay to prevent being stuck on splash
      await Future.delayed(const Duration(seconds: 3));
      if (mounted) {
        context.go('/');
      }
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _updateLoadingMessage(String message) {
    if (mounted) {
      setState(() {
        _loadingMessage = message;
      });
    }
  }

  void _updateErrorMessage(String message) {
    if (mounted) {
      setState(() {
        _errorMessage = message;
      });
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withAlpha(13),
              colorScheme.surface,
              colorScheme.primaryContainer.withAlpha(13),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Logo and Text Section with combined AnimatedBuilder
                AnimatedBuilder(
                  animation: Listenable.merge([_logoController, _textController]),
                  builder: (context, child) {
                    return Column(
                      children: [
                        FadeTransition(
                          opacity: _logoFadeAnimation,
                          child: ScaleTransition(
                            scale: _logoScaleAnimation,
                            child: SvgPicture.asset(
                              'assets/images/finwise_app_icon.svg',
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        FadeTransition(
                          opacity: _textFadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                'FinWise',
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.primary,
                                      letterSpacing: 0.5,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Smart Financial Decisions',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onSurface.withOpacity(0.7),
                                      letterSpacing: 0.3,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                const Spacer(flex: 3),

                // Progress Indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _progressAnimation.value,
                            backgroundColor: colorScheme.outline.withAlpha(51),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            minHeight: 4,
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          return Text(
                            _errorMessage ?? _loadingMessage,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: _errorMessage != null
                                      ? colorScheme.error
                                      : colorScheme.onSurface.withAlpha(153),
                                ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
