# JF HealthCalc
Aplicativo para cálculo de IMC, quantidades de calorias a serem consumidas por dia e monitoramento de calorias

![cal](https://github.com/user-attachments/assets/3e9707be-097e-426f-b962-55bfbb2ac09a)

![alimento](https://github.com/user-attachments/assets/9b1b42b6-3dc1-4a71-910c-85366b17c639)

# Integrantes!
- João Vitor Pires
- Luiz Fernando Mattos


# Como rodar a aplicação

## ✅ Pré-requisitos

Antes de tudo, você precisa ter instalado:

- Flutter SDK: https://docs.flutter.dev/get-started/install
- Dart SDK (já incluso no Flutter)
- Android SDK (via Android Studio ou SDK standalone)
- Um emulador Android configurado ou um dispositivo físico com depuração USB ativada
- Variável de ambiente `flutter` corretamente configurada no PATH

Verifique a instalação com:

```cmd
flutter doctor
```
---

## 🚀 Rodando o Projeto via Terminal

### 1. Clone o repositório em seu diretório de preferencia

```cmd
cd /seu/diretorio
git clone https://github.com/JVPCoder/flutter_imc_app
```

### 2. Instale as dependências

```cmd
flutter pub get
```

### 3. Conecte um dispositivo ou inicie um emulador

- Para listar os dispositivos disponíveis:
  
```cmd
flutter devices
```

- Para iniciar um emulador (se tiver emuladores configurados):

```cmd
flutter emulators
flutter emulators --launch nome_do_emulador
```

### 4. Rode o projeto

Com dispositivo/emulador pronto:

```cmd
flutter run
```
Se houver mais de um dispositivo, será pedido que escolha um.

---

## 🔄 Hot Reload e Hot Restart

Durante a execução no terminal, você pode usar comandos:

- r → Hot reload (atualização rápida de código)
- R → Hot restart (reinicialização com novo estado)
- q → Sair da execução
  
## 🛠️ Outros Comandos Úteis

- flutter clean → Limpa builds e cache
- flutter pub upgrade → Atualiza dependências
- flutter analyze → Analisa o código e mostra erros
- flutter build apk → Gera o APK para Android


## 📚 Referências

- Documentação Flutter CLI: https://docs.flutter.dev/reference/flutter-cli
---

Pronto! Agora você sabe como rodar projetos Flutter direto do terminal! 💻🚀
