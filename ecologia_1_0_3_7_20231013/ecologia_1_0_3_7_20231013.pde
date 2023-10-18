/*  Simulazione di una semplice ecologia

   Ogni animale (cella) è rappresentato da una classe ed è fornito di un DNA che ne stabilisce il comportamento (muovi, mangia, riproduci, ecc.).
   Il mondo ha regole di base, per cercare di mantenere la congruenza:
   1. due animali non possono muoversi per occupare la stessa cella
   2. due animali non possono mangiare lo stesso cibo (un animale-preda o un vegetale)
   3. per potersi riprodurre è necessaria la presenza di almeno due animali della stessa specie in celle adiacenti
     è necessario che non ci siano più di tre animali della stessa specie in celle adiacenti
     è necessario che l'animale che si riproduce si possa muovere in una cella libera

  (C)redits: da una chat con GPT3.5: https://chat.openai.com/share/7fdefca0-810d-4640-ae21-6a5d92663474
*/

//--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8

// Numero di righe e colonne dell'envmt
//int nRows = 20;
//int nCols = 20;

// Dimensione della viewport predefinita
int portW = 2000; //<>//
int portH = 1000;

int nRows = 100;
int nCols = 100;

// Proporzioni desiderate della cella: W/H
//float cellAspectRatio = portW / portH;

// Calcolo della dimensione della cella
int cellW = portW / nCols;
//int cellH = cellW / cellAspectRatio;
int cellH = portH / nRows;

// Dimensioni di una cella dell'envmt
//int cellSize = 20;

// Probabilità di variazione casuale del DNA
float mutRatio = 0.01;

// Probabilità che in una cella, inizialmente, sia presente un animale
float animRatio = 0.1;

// Numero di slot nella lista di istruzioni del DNA
int DNAslots = 32;

/* Costanti per le istruzioni del DNA
    MOVe
    EAT
    BReeD
*/
final int MOV = 0;
final int EAT = 1;
final int BRD = 2;

// Matrice che rappresenta l'envmt
CellEnv envmt;

void settings() { //<>//
  envmt = new CellEnv(nRows, nCols);
  if (envmt != null) {                                                      // if, for any reason, envmt is not defined/initialized, don't throw an exception
      size(envmt.nCols * cellW, envmt.nRows * cellH);
      //size(envmt.nCols * cellSize, envmt.nRows * cellSize);
  }
}

void setup() { //<>//
  //envmt = new CellEnv(nRows, nCols);                    // 20230705-1.0.1.3: moved to settings()
  envmt.init();
  // Imposta la modalità di colore su HSL
  colorMode(HSB, 360, 100, 100);
}

void draw() { //<>//
  background(255);
  envmt.update();
  envmt.show();
}
