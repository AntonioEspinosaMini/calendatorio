import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 🔹 el modal se adapta al contenido
        children: [
          // Nuevo título
          const Text(
            "¿Qué es Calendatorio?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C6A7D),
            ),
          ),
          const SizedBox(height: 12),

          // Explicación breve arriba
          const Text(
            "Calendatorio es una app para ayudarte a crear hábitos y visualizar cuándo los estás cumpliendo de forma sencilla.",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Color(0xFF4C6A7D),
            ),
          ),
          const SizedBox(height: 20),

          // Título pasos
          const Text(
            "¿Cómo funciona?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C6A7D),
            ),
          ),
          const SizedBox(height: 12),

          // Pasos
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _StepItem(number: "1", text: "Crea tu recordatorio"),
              SizedBox(height: 8),
              _StepItem(number: "2", text: "Márcalo en el calendario"),
              SizedBox(height: 8),
              _StepItem(number: "3", text: "Ó márcalo usando el widget"),
            ],
          ),
          const SizedBox(height: 24),

          // Footer con autor
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Made with ❤️ by ",
                    style: TextStyle(fontSize: 12, color: Color(0xFF999999)),
                  ),
                  TextButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                        'https://www.linkedin.com/in/antonio-espinosa-velasco',
                      );

                      // Comprueba si se puede abrir
                      if (!await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      )) {
                        // Si falla, muestra un error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No se pudo abrir el enlace'),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "Antonio Espinosa",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF1D4ED8),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                        'https://buymeacoffee.com/antonio.espinosa',
                      );

                      if (!await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      )) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No se pudo abrir el enlace'),
                          ),
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      "☕ Invítame a un café",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFF59E0B),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String number;
  final String text;

  const _StepItem({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF36C1A2), // turquesa corporativo
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Color(0xFF4C6A7D),
            ),
          ),
        ),
      ],
    );
  }
}
