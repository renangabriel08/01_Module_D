import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modulod/main.dart';

void main() {
  testWidgets('AppTest', (WidgetTester tester) async {
    print('Step N°: 1,Inicialização do aplicativo');
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 2,Role até o final da lista de hotéis');
    await tester.ensureVisible(find.text("L'Appart à Méribel"));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print(
      'Step N°: 3,Realize uma pesquisa depois de inserir o termo de pesquisa na barra de pesquisa',
    );
    await tester.enterText(find.byType(TextFormField), "Méribel");
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 4,Clique no item "Appartement Méribel"');
    await tester.tap(find.text("Appartement Méribel"));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 5,Clique no botão da guia Avaliações de hóspedes');
    await tester.tap(find.text("Guest reviews"));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print(
      'Step N°: 6,Role a lista de Avaliações para baixo até a 4ª Revisão (publicada por "Miles")',
    );
    await tester.ensureVisible(find.text("Miles"));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 7,Clique no label do botão de seleção de Room');
    await tester.tap(find.text("Room selection"));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print(
      'Step N°: 8,Role a lista de quartos para baixo até o item "Great Family Room"',
    );
    await tester.ensureVisible(find.text("Great family Room"));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 9,Clique no item "Great Family Room"');
    await tester.tap(find.text("Great family Room"));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 10,Digite o nome');
    await tester.ensureVisible(find.byKey(const Key('nome')));
    await tester.enterText(find.byKey(const Key('nome')), "Taylor");
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 11,Digite o sobrenome');
    await tester.ensureVisible(find.byKey(const Key('sobrenome')));
    await tester.enterText(find.byKey(const Key('sobrenome')), "Hutchinson");
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 12,Insira a data de check-in');
    await tester.tap(find.byKey(const Key('checkin')));
    await tester.pumpAndSettle();
    for (int i = 0; i < 9; i++) {
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 13,Insira a data de check-out');
    await tester.tap(find.byKey(const Key('checkout')));
    await tester.pumpAndSettle();
    for (int i = 0; i < 17; i++) {
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('10'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 14,Digite o número de adultos');
    await tester.ensureVisible(find.byKey(const Key('adultos')));
    await tester.enterText(find.byKey(const Key('adultos')), "4");
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 15,Insira o número de filhos');
    await tester.ensureVisible(find.byKey(const Key('criancas')));
    await tester.enterText(find.byKey(const Key('criancas')), "3");
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 16,Clique no botão de opção E-Pay');
    await tester.ensureVisible(find.byKey(const Key('E-Pay')));
    await tester.tap(find.byKey(const Key('E-Pay')));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 17,Clique no botão "Book now"');
    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 18,Alterar data de check-out');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('checkout')));
    await tester.pumpAndSettle();
    for (int i = 0; i < 9; i++) {
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('19'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print('Step N°: 19,Clique no botão " Book now"');
    await tester.ensureVisible(find.byType(ElevatedButton));
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    print(
      'Step N°: 20,Clique em "Yes" na janela pop-up para confirmar sua reserva.',
    );
    await tester.ensureVisible(find.text('Yes'));
    await tester.tap(find.text('Yes'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));
  });
}
