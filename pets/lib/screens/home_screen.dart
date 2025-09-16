import 'package:flutter/material.dart';
import '../app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _goToForm(BuildContext context) => AppNavigator.pushToPetForm(context);
  void _goToList(BuildContext context) => AppNavigator.pushToPetList(context);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Pet-Hotel Deluxe', style: textTheme.displayLarge),
      ),
      body: SafeArea(
        child: Stack(
          children: [

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

            // conteúdo principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Bem Vindo ao\nseu Hotel para pets!',
                    style: textTheme.displayLarge?.copyWith(
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
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}