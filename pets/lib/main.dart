
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/pet_provider.dart';
import 'services/pet_service.dart';
import 'services/http_pet_service.dart'; 
import 'screens/home_screen.dart';
import 'screens/pet_list_screen.dart';
import 'screens/pet_form_screen.dart';
import 'app_routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  final petService = HttpPetService(baseUrl: 'http://192.168.0.19:3000');

  runApp(MyApp(petService: petService));
}

class MyApp extends StatelessWidget {
  final PetService petService;
  const MyApp({Key? key, required this.petService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = PetProvider(service: petService);
        provider.loadPets(); 
        return provider;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet-Hotel Deluxe',
        theme: appTheme,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => const HomeScreen(),
          AppRoutes.petList: (context) => const PetListScreen(),
          AppRoutes.petForm: (context) => const PetFormScreen(),
        },
      ),
    );
  }
}