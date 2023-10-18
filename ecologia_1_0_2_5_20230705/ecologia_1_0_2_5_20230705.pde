/*  Simulazione di una semplice ecologia

   Ogni animale (cella) è rappresentato da una classe ed è fornito di un DNA che ne stabilisce il comportamento (muovi, mangia, riproduci, ecc.).
   Il mondo ha regole di base, per cercare di mantenere la congruenza:
   1. due animali non possono muoversi per occupare la stessa cella
   2. due animali non possono mangiare lo stesso cibo (un animale-preda o un vegetale)
   3. per potersi riprodurre è necessaria la presenza di almeno due animali della stessa specie in celle adiacenti
     è necessario che non ci siano più di tre animali della stessa specie in celle adiacenti
     è necessario che l'animale che si riproduce si possa muovere in una cella libera

  *** TO-DO *** (in corso d'implementazione)
  
  x 1. viewport modificabile: valori dimensionali delle celle/organismi ricalcolati dinamicamente
  \ 2. implementazione della "salute" negli organismi: ogni "tipo" ha un massimo, che non può superare, e se la salute cala a zero muore
  \ 3. colori di background e degli organismi modificati: nero per lo sfondo, e gli organismi hanno luminosità dipendente dalla "salute"
  - 4. "calorie" che un organismo fornisce quando viene mangiato, in dipendenza dal "tipo"
  - 5. "calorie" spese nelle varie azioni dagli organismi (diverse per tipo di azione: mangiare, muoversi, riprodursi)
  - 6. Ambiente toroidale: i margini della mappa diventano contigui, questo ha effetti su tutti i calcoli: prossimità, riproduzione, movimento
  - 7. statistiche di funzionamento: celle occupate, tipi di organismo, FPS, ecc.

  (C)redits: da una chat con GPT3.5: https://chat.openai.com/share/7fdefca0-810d-4640-ae21-6a5d92663474
*/

//--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8

/* *** CHANGELOG ***
20230705  1.0.2.5
.5 * background change, and RGB to HSL switch
.4 * viewport size change, with dynamic cell size redim 

20230705  1.0.1.3
.3 ! "ambiente" init moved from setup() to settings() so to have it not null
.2 + cells now received a type ("tipo") which is also shown with an ASCII char ("carattere")
.1 * each class gone into its own tab: better code readability and maintenance

20230705  1.0.0.0
.0 + base proc with some fixes to make it run: monolithic source with classes
*/

// Numero di righe e colonne dell'ambiente
//int numRighe = 20;
//int numColonne = 20;

// Dimensione della viewport predefinita
int viewportWidth = 2000;
int viewportHeight = 1000;

int numRighe = 100;
int numColonne = 100;

// Proporzioni desiderate della cella: W/H
//float cellAspectRatio = viewportWidth / viewportHeight;

// Calcolo della dimensione della cella
int cellWidth = viewportWidth / numColonne;
//int cellHeight = cellWidth / cellAspectRatio;
int cellHeight = viewportHeight / numRighe;

// Dimensioni di una cella dell'ambiente
//int dimensioneCella = 20;

// Probabilità di variazione casuale del DNA
float probabilitaVariazioneDNA = 0.01;

// Probabilità che in una cella, inizialmente, sia presente un animale
float probabilitaPresenzaAnimale = 0.1;

// Numero di slot nella lista di istruzioni del DNA
int numeroSlotDNA = 32;

// Costanti per le istruzioni del DNA
final int MUOVITI = 0;
final int MANGIA = 1;
final int RIPRODUZIONE = 2;

// Matrice che rappresenta l'ambiente
AmbienteCellulare ambiente;

void settings() {
  ambiente = new AmbienteCellulare(numRighe, numColonne);
  if (ambiente != null) {                                                      // if, for any reason, ambiente is not defined/initialized, don't throw an exception
      size(ambiente.numColonne * cellWidth, ambiente.numRighe * cellHeight);
      //size(ambiente.numColonne * dimensioneCella, ambiente.numRighe * dimensioneCella);
  }
}

void setup() {
  //ambiente = new AmbienteCellulare(numRighe, numColonne);                    // 20230705-1.0.1.3: moved to settings()
  ambiente.inizializza();
  // Imposta la modalità di colore su HSL
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  background(255);
  ambiente.aggiorna();
  ambiente.mostra();
}
