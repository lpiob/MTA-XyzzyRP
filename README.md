MTA-XyzzyRP
===========

Gamemod RP do gry Multi Theft Auto, napisany głównie w języku LUA, w oparciu o bazę danych MySQL. Stworzony oryginalnie blisko 2 lata temu na potrzeby serwera http://lss-rp.pl/

Autorzy
========================================================================

- Łukasz "W/Wielebny" Biegaj <wielebny@bestplay.pl>
- WUBE <wube@lss-rp.pl>
- Karer <karer.programmer@gmail.com>
- Przemysław "RacheT" Kędziorek <rachet@pylife.pl>
- Eryk "RootKiller" Dwornicki <rootkiller.programmer@gmail.com>

Licencja
========================================================================

Kod dystrybuowany jest na dwóch licencjach: GPLv2 oraz MIT. 

Polskie tłumaczenie licencji GPLv2: http://gnu.org.pl/text/licencja-gnu.html
Polskie tlumaczenie licencji MIT: http://blaszyk-jarosinski.pl/wp-content/uploads/2008/05/licencja-mit-tlumaczenie.pdf

Wszystkie pliki .map dystrybuowane są na licencji CC-BY-ND. Streszczenie: http://creativecommons.org/licenses/by-nd/3.0/pl/

W repozytorium znajdują się również fragmenty kodu z community, dystrybuowane na innej licencji, informacja o tym zawsze znajduje się przy danym zasobie.

Istnieje możliwość otrzymania tego kodu na innej licencji. Jeśli jesteś tym zainteresowany, skontaktuj się z nami.

Warunkiem wykorzystania tego kodu jest NIE TWORZENIE serwera o nazwie LSS-RP. Wykorzystaj go swobodnie, ale swoje dzieło nazwij oryginalnie.

Dlaczego ten kod został wydany
========================================================================

Wydaliśmy ten kod aby:

1. Wypełnić założenia GPL http://pl.wikipedia.org/wiki/GNU_General_Public_License#Za.C5.82o.C5.BCenia

2. Oddać otwartej społeczności MTA - z której tak wiele otrzymaliśmy - coś od siebie.

3. Aby pobudzić scenę serwerów w MTA, ukrócić wykorzystywanie nielegalnego, kradzionego kodu krążącego po sieci.

4. Aby ściągnąć więcej graczy do MTA.

Dlaczego kod udostępniono dodatkowo na licencji MIT
========================================================================

Aby jeszce bardziej zastymulować rozwój społeczności i zwiększyć adopcję tego kodu. Z checią zobaczymy ten kod w działaniu na jak największej ilości serwerów.

Zawartość repozytorium
========================================================================

W repozytorium znajduje się:
- Kod LUA serwera
- Struktura bazy danych
- Dodatkowe wymagane moduły

W repozytorium nie ma:
- Kodu integrującego IPBoard lub inne oprogramowanie forum z autoryzacją używaną na serwerze
- Podmianek skinów i pojazdów
- Paneli do tworzenia postaci i rejestracji kont - zostanie to dodane wkrótce


Gdzie uruchomić serwer
========================================================================

Oprogramowanie to nie wymaga żadnego specjalnego serwera dedykowanego. Aby go uruchomić, wystarczy zwykły hosting współdzielony. W rzeczy samej polecamy skorzystanie z takiego hostingu w firmach:

- ServerProject - http://serverproject.pl/ - utrzymywali i utrzymują LSS-RP
- OG-Servers - http://og-servers.net/
- ServHost - http://servhost.pl/

Podczas wyboru hostingu należy upewnić się, czy:
- hosting umożliwia dostęp do bazy danych MySQL
- dostęp do bazy danych możliwy jest także z dowolnego hosta w internecie

(wymienione wyżej hostingi spełniają te wymogi)

Przygotowaliśmy krótką instrukcję instalacji krok-po-kroku całego gamemodu na hosting ServerProject. Można ją przeczytać tu: https://github.com/lpiob/MTA-XyzzyRP/wiki/Instalacja-XyzzyRP-na-ServerProject.pl

Oprócz hostingu na serwer MTA wymagany jest też hosting na utrzymanie strony internetowej, a przynajmniej kodu pozwalającego na rejestrację graczy, gdyż ta nie jest wbudowana w serwer. Do tego wystarczy dowolony nowoczesny hosting z zainstalowanym PHP oraż możliwością wykonywania połączeń do bazy danych umieszczonej na ww. hostingu.

Jak uruchomić serwer
========================================================================

Aby uruchomić serwer należy:

1. Zainstalować serwer MTA
 
2. Ściągnać lub samodzielnie skompilować plugin mta_mysql.so/mta_mysql.dll i wrzucić do katalogu mods/deatchmatch/modules/
 
3. Skopiować katalog resources/[XyzzyRP]/ do katalogu mods/deathmatch/resources/[XyzzyRP]/
 
4. Zainicjalizować bazę danych plikami zawartymi w sql/schema.sql

5. Zainicjalizować samodzielnie czyste konto w ACL, lub skorzystać z dołączonego pliku opt/internal.db (zastąpić istniejący).

6. Stworzyć własny plik mtaserver.conf lub połączyć istniejący z tym znajdującym się w opt/mtaserver.conf. W pliku tym muszą znaleźć się adresy ip i porty (narzucone przez hosting), zasoby do uruchomienia oraz odwołanie do modułu mta_mysql.

7. Zainstalować serwer, uruchomić, zalogować się, zmienić hasło do ACL

8. Zainstalować i uruchomić rejestrację kont na stronie.

Domyślne konto testowe w grze: login tester, hasło tester, postać Brian_Looner

Przygotowaliśmy krótką instrukcję instalacji krok-po-kroku całego gamemodu na hosting ServerProject. Można ją przeczytać tu: https://github.com/lpiob/MTA-XyzzyRP/wiki/Instalacja-XyzzyRP-na-ServerProject.pl


Informacje techniczne
========================================================================

### Wstępnie

Nie ma pełnej dokumentacji do wszystkich elementów kodu. Jest on dość spory i obejmuje wiele aspektów. Poniżej wypisane zostały pewne kluczowe aspekty na które należy zwrócić uwagę, pozostałych rzeczy trzeba dowiedzieć się samemu czytając kod źródłowy.

### Obsługa bazy danych.

Kod powstał zanim MTA zostało doposażone o funkcje do natywnej obsługi baz danych (funkcje db...). W związku z tym, w kodzie wykorzystywane są zarówno te funkcje jak i funkcje udostępniane przez moduł mta_mysql.

mta_mysql, mimo że jest w pełni sprawny, nie oferuje takiej elastyczności jak wbudowane funkcje do obsługi baz danych. Jednym z niuansów tego modułu jest to, że każda zwracana zmienna jest typu string i w związku z tym po pobraniu danych z bazy wymagana jest ich dalsza konwersja. Wbudowane funkcje zwracają od razu zmienne we właściwych typach.

Komunikacja przez mta_mysql jest realizowana w zasobie DB i wykorzystywana przez starsze fragment kodu.

Komunikacja przez funkcje db... jest realizowana w zasobie DB2 i wykorzystywana przez nowsze fragmenty kodu.

Pisząc dowolny fragment kodu korzystający z baz danych, powinieneś odwoływać się tylko do zasobu DB2.

### Ekwipunek

Każdy przedmiot który może trafić do ekwipunku składa się z następującego zestawu informacji:

    (uint) id przedmiotu, (uint/nil) podtyp przedmiotu, (uint) ilość

Każda z tych zmiennych to nieujemna liczba całkowita, lub nil/NULL w przypadku braku podtypu.

Przykładowe itemy to:
- Aparat: id przedmiotu: 1, podtyp nil
- Mapa: id przedmiotu 4, podtyp nil
- Klucze do pojazdu 1337: id przedmiotu 6, podtyp 1337

Spis przedmiotów można znaleźć w plikach lss-gui/ekwipunek.lua. Wtórny spis przedmiotów tworzony jest w bazie danych w tabeli lss_items.

Przedmioty mogą być przechowywane przy postaci oraz w pojemnikach. Do pojemników zaliczamy: sejfy, skrytki bankowe, magazyny, bagażniki pojazdów.

Przedmioty przechowywane przy postaci zapisywane są w postaci zserializowanej w tabeli lss_characters, kolumna eq. Nie jest może to najbardziej elegancka forma przechowywania tych danych, ale zdecydowanie najszybsza jeśli chodzi o ich przetwarzanie. Zmiany w tej kolumnie mogą być dokonywane tylko, jeśli edytowana postać jest offline.

Przedmioty przechowywane w pozostałych miejscach zapisywane są w tablicach lss_container_contents. Zmiany w tych tablicach są natychmiastowe, pod warunkiem że nikt w danej chwili nie dokonuje interakcji z edytowanym pojemnikiem.

### Logowanie

Wszystkie logi przechowywane są w katalogu lss-admin/logs. Przy restarcie tego zasobu tworzony jest nowy plik z logami.
Wszystkie screeny graczy wykonane komendą /sshot przechowywane są w katalogu lss-admin/ss/

### Hasła graczy

Hasła graczy zapisywane są w tabeli lss_users w postaci skrótu MD5 z wykorzystaniem zmiennej i stałej soli. Solą zmienną jest login gracza zapisany małym literami. Hashe generowane są według następującej funkcji:

    SELECT MD5(CONCAT(LOWER("Login gracza"),"MRFX_01", "haslo"));
    580947a2986bd1f14039b95d89a7e1fe

Przed wdrożeniem własnej instalacji NALEŻY zmienić sól z MRFX_01 na swoją własną, w przeciwnym przypadku można narazić się na szybkie odkodowanie haseł w przypadku wycieku bazy danych.

Szybką zmianę hasła można dokonać za pomocą następującego zapytania:

    mysql> SELECT id,login,hash,email FROM lss_users WHERE id=1;
    +----+--------+----------------------------------+------------------+
    | id | login  | hash                             | email            |
    +----+--------+----------------------------------+------------------+
    |  1 | tester | 0c154f10cb3672e82976d5e8e7d6c91a | tester@tester.pl |
    +----+--------+----------------------------------+------------------+
    1 row in set (0.00 sec)


    mysql> UPDATE lss_users SET hash=MD5(CONCAT(LOWER(login),'MRFX_01','tu_wpisz_nowe_haslo')) WHERE id=1;
    Query OK, 1 row affected (0.00 sec)
    Rows matched: 1  Changed: 1  Warnings: 0


Często zadawane pytania
========================================================================

### Chciałbym się dowiedzieć czy mogę wraz ze znajomym użyć całego kodu do stworzenia nowego serwera, oraz jeżeli tak czy możemy wprowadzić w nim parę nowych zmian/ulepszeń.

Tak, możecie na podstawie tego utworzyć własny serwer, pamiętajcie jednak, że musicie przestrzegać założeń licencji.

Jeśli wybierzesz licencję GPLv2, to musisz upublicznić wykonane przez siebie zmiany w kodzie.
Jeśli wybierzesz licencję MIT, to musisz jedynie zachować informację o prawach autorskich oraz oryginalnych autorach użytego kodu. Wzmianka 'Zawiera kod XyzzyRP z http://github.com/lpiob/MTA-XyzzyRP/' gdzieś w oknie informacji o serwerze będzie wystarczająca.

### Czy można wykorzystywać fragmenty tego kodu?

Tak, możesz skorzystać z dowolnego fragmentu kodu.
