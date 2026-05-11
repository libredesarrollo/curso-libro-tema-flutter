import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themes/drawer/drawer.dart';
import 'package:themes/theme/theme.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => ThemeSwitch(true),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Provider.of<ThemeSwitch>(context).currentTheme;

    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      title: 'Theme App',
      home: const ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeSwitch>(context).currentTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Theme App', style: appTheme.textTheme.displayLarge),
        backgroundColor: appTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Texto que usa el tema global automáticamente
            const Text('Text example content'),
            const SizedBox(height: 12),

            // Card nativo de Flutter: responde automáticamente al tema
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Content', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Este Card adapta su color de fondo al tema automáticamente.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Card personalizado: necesita consumir el tema manualmente
            _Card(
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Custom Content',
                      style: appTheme.textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Este Card usa un color fijo; debes actualizar su color manualmente al cambiar el tema.',
                      style: appTheme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Ejemplo de ElevatedButton y TextButton con estilos del tema
            ElevatedButton(
              onPressed: () {},
              child: const Text('ElevatedButton con tema'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('TextButton con tema'),
            ),
            const SizedBox(height: 12),

            // Chip que toma el color del esquema de color
            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: const Text('Chip 1'),
                  backgroundColor: appTheme.colorScheme.primaryContainer,
                ),
                Chip(
                  label: const Text('Chip 2'),
                  backgroundColor: appTheme.colorScheme.secondaryContainer,
                ),
                Chip(
                  label: const Text('Chip 3'),
                  backgroundColor: appTheme.colorScheme.tertiaryContainer,
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}

/// Card personalizado que requiere consumir el tema de forma manual.
/// Nota: el color de fondo es fijo (blanco), lo que demuestra por qué
/// los widgets personalizados deben usar los colores del tema activo.
class _Card extends StatelessWidget {
  final Widget content;

  const _Card({required this.content});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeSwitch>(context).currentTheme;

    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          // Para que el card personalizado responda al tema correctamente,
          // usa appTheme.colorScheme.surface en lugar del color fijo Colors.white:
          color: appTheme.colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: appTheme.primaryColor.withValues(alpha: 0.5),
                blurRadius: 7,
                offset: const Offset(0, 0))
          ]),
      child: content,
    );
  }
}
