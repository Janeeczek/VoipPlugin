# VoipPlugin iOS

# INSTALACJA
1. instalacja plugman z npm: npm install -g plugman
2. pobranie repozytorium.
3. rozpakowanie go.
Jeśli chcesz dodać ten plugin po dodaniu platformy ios (po wpisaniu cordova platform add ios) przejdź do punktu 5.1
5. utworzenie projektu: cordova create .....
4. po utworzeniu projektu(cordova create ...), ale przed dodaniem platformy IOS (cordova platform add) ważne jest aby dodać ten plugin: cordova plugin add cordova-plugin-add-swift-support --save
5. dodanie platformy ios: cordova platform add ios
5.1 jeśli dodałeś platformę ios, ale wcześniej nie dodałeś pluginu cordova-plugin-add-swift-support to dodaj go teraz: cordova plugin add cordova-plugin-add-swift-support --save
6. dodanie pluginu plugman install --platform android --project <scieżka do folderu \platforms\ios w projekcie do którego ma być wgrany plugin> --plugin <ścieżka do folderu z pluginem>
7. należy uruchomić Xcode będąc wewnatrz projektu open ./platforms/ios/NAZWAPROJEKTU.xcworkspace/
8. w Xcode przejść do nazwaProjectu.xcodeproj. Wybrać okno targets, następnie Build Settings i w zakładce Swift Compiler - Language zmienić Swift Language Version na Swift 5

# API

## Metody

- [VoipPlugin.receiveCall](#receiveCall)



## receiveCall

Metoda tworzy sztuczne połączenie głosowe i zwraca komunikat w zależności pod podjętej akcji przez użytkownika.

    VoipPlugin.receiveCall(callerName, callback, failure_callback);

### Opis

Funckja `receiveCall` tworzy okienko przychodzącego połączenia. Użykownik musi zareagować na to połączenie ponieważ trwa ono do momentu wciśnięcia przycisku "odbierz" lub "odrzuć". Cordova po rozpoczęciu połączenia wysyła komunikat o oczekującym połączeniu. Nastepnie po podjętej akcji przez użytkownika zwraca informację o tym czy to połączenie odebrał czy odrzucił.

Funkcja callback zwraca ZAWSZe dwa stany. Pierwszym z nich jest stan rozpoczęcia połączenia przychodzącego. Drugi to stan zakończenia tego połączenia.
Lista stanów:
  zawsze przy wywołaniu funkcji
- callStarted : zwracana gdy użytkownik zobaczy przychodzące połączenie
  jedno z dwóch po reakcji użytkownika
- callAccepted : zwracana gdy użytkownik zaakceptuje przychodzące połączenie
- callRejected : zwracana gdy użytkownik odrzuci przychodzące połączenie


Aktualnie plugin działa tylko na rozkazy pochodzące wewnątrz aplikacji.
Jest możliwość symulowania połączeń z powiadomień np. FCM.

### Parametry

- __callerName__: Tekst wyświetlany na ekranie przychodzącego połączenia.
- __callback__: Funkcja zwracająca wartość wyniku połączenia.
- __failure_callback__: Funkcja callback w przypadku błędu.

### Prosty przykład

    function listener(callback) {
      switch(callback) {
            case "callStarted":
                console.log("call started");
                break;
            case "callAccepted":
                console.log("call accepted");
                break;
            case "callRejected":
                console.log("call rejected");
                break;
      }
    }
    
    function receiveCall() {
      window.VoipPlugin.receiveCall('ABEC',(s)=>listener(s),(e)=>{console.log(e);});
    }
