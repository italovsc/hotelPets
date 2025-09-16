// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _goToForm(BuildContext context) {
    AppNavigator.pushToPetForm(context);
  }

  void _goToList(BuildContext context) {
    AppNavigator.pushToPetList(context);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // AppBar transparente (tema já define), mas deixamos simples
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Pet-Hotel Deluxe', style: textTheme.displayLarge),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Conteúdo principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),

                  // Espaço para o título (já no AppBar) - deixamos um subtítulo amigável
                  Text(
                    'Bem Vindo ao\nseu Hotel para pets!',
                    style: textTheme.displayLarge?.copyWith(
                      // afinamentos para combinar com o protótipo
                      fontSize: 42,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  const SizedBox(height: 70),

                  Text(
                    'Faça o cadastro para\nhospedar seu pet:',
                    style: textTheme.titleMedium?.copyWith(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),

                  const SizedBox(height: 50),

                  // Botão grande centralizado
                  Center(
                    child: SizedBox(
                      width: size.width * 0.6,
                      child: ElevatedButton(
                        onPressed: () => _goToForm(context),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.0),
                          child: Text('Cadastrar', textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Link para ver lista de pets (opcional)
                  Center(
                    child: TextButton(
                      onPressed: () => _goToList(context),
                      child: Text(
                        'Ver lista de pets',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.95),
                        ),
                      ),
                    ),
                  ),

                  // Espaço flexível para empurrar o padrão de patinhas para baixo
                  const Spacer(),
                ],
              ),
            ),


            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 400,
                child: Image.asset(
                  'assets/images/catAndDog1.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pintor customizado para desenhar um padrão simples de patinhas no rodapé.
/// É leve e evita depender de imagens. Ajuste cores/tamanho no painter se desejar.
class _PawPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // cor das patinhas (leve, contrastando com o fundo vinho)
    final paint = Paint()..color = Colors.white24;

    // Desenha círculos (patas) em padrão repetido simples
    // Você pode ajustar posições para ficar exatamente como no protótipo.
    final pawRadius = size.height * 0.12;
    final spacing = size.width / 6;

    for (int col = 0; col < 6; col++) {
      final baseX = spacing * col + spacing * 0.2;
      final baseY = size.height * 0.6;

      // "almofada" principal
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(baseX, baseY),
          width: pawRadius * 1.6,
          height: pawRadius * 1.0,
        ),
        paint,
      );

      // 4 dedos
      final fingerOffset = pawRadius * 0.9;
      final fingerRadius = pawRadius * 0.6;
      canvas.drawOval(Rect.fromCenter(center: Offset(baseX - fingerOffset * 0.6, baseY - fingerOffset), width: fingerRadius, height: fingerRadius), paint);
      canvas.drawOval(Rect.fromCenter(center: Offset(baseX + fingerOffset * 0.6, baseY - fingerOffset), width: fingerRadius, height: fingerRadius), paint);
      canvas.drawOval(Rect.fromCenter(center: Offset(baseX - fingerOffset * 0.2, baseY - fingerOffset * 1.25), width: fingerRadius, height: fingerRadius), paint);
      canvas.drawOval(Rect.fromCenter(center: Offset(baseX + fingerOffset * 0.2, baseY - fingerOffset * 1.25), width: fingerRadius, height: fingerRadius), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
