/*  Simulazione di una semplice ecologia

   Ogni animale (cella) è rappresentato da una classe ed è fornito di un DNA che ne stabilisce il comportamento (muovi, mangia, riproduci, ecc.).
   Il mondo ha regole di base, per cercare di mantenere la congruenza:
   1. due animali non possono muoversi per occupare la stessa cella
   2. due animali non possono mangiare lo stesso cibo (un animale-preda o un vegetale)
   3. per potersi riprodurre è necessaria la presenza di almeno due animali della stessa specie in celle adiacenti
     è necessario che non ci siano più di tre animali della stessa specie in celle adiacenti
     è necessario che l'animale che si riproduce si possa muovere in una cella libera

  Da una chat con GPT3.5: https://chat.openai.com/share/7fdefca0-810d-4640-ae21-6a5d92663474
*/
// Numero di righe e colonne dell'ambiente
int numRighe = 20;
int numColonne = 20;

// Dimensioni di una cella dell'ambiente
int dimensioneCella = 20;

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

/*
void setup() {
  size(numColonne * dimensioneCella, numRighe * dimensioneCella);
  ambiente = new AmbienteCellulare(numRighe, numColonne);
  ambiente.inizializza();
}*/

void settings() {
  size(numColonne * dimensioneCella, numRighe * dimensioneCella);
}

void setup() {
  ambiente = new AmbienteCellulare(numRighe, numColonne);
  ambiente.inizializza();
}

void draw() {
  background(255);
  ambiente.aggiorna();
  ambiente.mostra();
}

// Classe che rappresenta una singola cella dell'ambiente
class Cella {
  ArrayList<Animale> animali;

  Cella() {
    animali = new ArrayList<Animale>();
  }
  
  void aggiungiAnimale(Animale animale) {
    animali.add(animale);
  }

  void rimuoviAnimale(Animale animale) {
    animali.remove(animale);
  }

  void aggiorna() {
    for (int i = animali.size() - 1; i >= 0; i--) {
      Animale animale = animali.get(i);
      animale.aggiorna();
      if (!animale.èVivo()) {
        animali.remove(i);
      }
    }
  }

  void mostra() {
    for (Animale animale : animali) {
      animale.mostra();
    }
  }
}

// Classe che rappresenta l'ambiente cellulare
class AmbienteCellulare {
  int numRighe;
  int numColonne;
  Cella[][] griglia;

  AmbienteCellulare(int numRighe, int numColonne) {
    this.numRighe = numRighe;
    this.numColonne = numColonne;
    griglia = new Cella[numRighe][numColonne];
  }

  void inizializza() {
    for (int riga = 0; riga < numRighe; riga++) {
      for (int colonna = 0; colonna < numColonne; colonna++) {
        griglia[riga][colonna] = new Cella();
        /* NEW */
        // Crea gli animali nell'ambiente
        if (random(1) < probabilitaPresenzaAnimale) {
        Animale animale = new Animale(riga, colonna, this);
        griglia[riga][colonna].aggiungiAnimale(animale);
      }
    }

    // Inizializza gli animali nell'ambiente
    // Qui puoi personalizzare la disposizione iniziale degli animali
    /* OLD
    for (int riga = 0; riga < numRighe; riga++) {
      for (int colonna = 0; colonna < numColonne; colonna++) {
        Animale animale = new Animale(riga, colonna);
        griglia[riga][colonna].aggiungiAnimale(animale);
      }*/
    }
  }

  void aggiorna() {
    for (int riga = 0; riga < numRighe; riga++) {
      for (int colonna = 0; colonna < numColonne; colonna++) {
        griglia[riga][colonna].aggiorna();
      }
    }
  }

  void mostra() {
    for (int riga = 0; riga < numRighe; riga++) {
      for (int colonna = 0; colonna < numColonne; colonna++) {
        griglia[riga][colonna].mostra();
      }
    }
  }
}

// Classe che rappresenta un animale
class Animale {
  int riga;
  int colonna;
  int[] dna;
  boolean vivo;

  AmbienteCellulare ambiente;

  Animale(int riga, int colonna, AmbienteCellulare ambiente) {
    this.riga = riga;
    this.colonna = colonna;
    this.ambiente = ambiente;
    dna = new int[numeroSlotDNA];
    vivo = true;
    
    // Inizializza il DNA con istruzioni casuali
    for (int i = 0; i < numeroSlotDNA; i++) {
      dna[i] = int(random(3));
    }
  }

  void aggiorna() {
    if (!vivo) {
      return;
    }
    
    // Esegui l'istruzione corrispondente al DNA corrente
    int istruzione = dna[frameCount % numeroSlotDNA];
    
    switch (istruzione) {
      case MUOVITI:
        muoviti();
        break;
      case MANGIA:
        mangia();
        break;
      case RIPRODUZIONE:
        riproduci();
        break;
    }
    
    // Variabilità casuale del DNA
    if (frameCount % (100 * numeroSlotDNA) == 0) {
      for (int i = 0; i < numeroSlotDNA; i++) {
        if (random(1) < probabilitaVariazioneDNA) {
          dna[i] = int(random(3));
        }
      }
    }
  }

  void muoviti() {
    int nuovaRiga = riga + int(random(-1, 2));
    int nuovaColonna = colonna + int(random(-1, 2));

    if (nuovaRiga >= 0 && nuovaRiga < ambiente.numRighe && nuovaColonna >= 0 && nuovaColonna < ambiente.numColonne) {
      Cella nuovaCella = ambiente.griglia[nuovaRiga][nuovaColonna];
      if (nuovaCella.animali.size() < 2) {
        riga = nuovaRiga;
        colonna = nuovaColonna;
      }
    }
  }

  void mangia() {
    //Cella cellaCorrente = griglia[riga][colonna];
    Cella cellaCorrente = ambiente.griglia[riga][colonna];
    for (Animale animale : cellaCorrente.animali) {
      if (animale != this) {
        animale.morire();
        return;
      }
    }
  }

  void riproduci() {
    //Cella cellaCorrente = griglia[riga][colonna];
    Cella cellaCorrente = ambiente.griglia[riga][colonna];
    boolean esistonoCellaVicinaVuota = false;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int rigaVicina = riga + i;
        int colonnaVicina = colonna + j;
        //if (rigaVicina >= 0 && rigaVicina < numRighe && colonnaVicina >= 0 && colonnaVicina < numColonne) {
        if (rigaVicina >= 0 && rigaVicina < ambiente.numRighe && colonnaVicina >= 0 && colonnaVicina < ambiente.numColonne) {
          Cella cellaVicina = ambiente.griglia[rigaVicina][colonnaVicina];
          if (cellaVicina.animali.size() == 0) {
            esistonoCellaVicinaVuota = true;
            break;
          }
        }
      }
    }

    if (!esistonoCellaVicinaVuota) {
      return;
    }

    if (random(1) < 0.5) {
      int nuovaRiga = riga + int(random(-1, 2));
      int nuovaColonna = colonna + int(random(-1, 2));
      
      //if (nuovaRiga >= 0 && nuovaRiga < numRighe && nuovaColonna >= 0 && nuovaColonna < numColonne) {
      if (nuovaRiga >= 0 && nuovaRiga < ambiente.numRighe && nuovaColonna >= 0 && nuovaColonna < ambiente.numColonne) {
        Cella nuovaCella = ambiente.griglia[nuovaRiga][nuovaColonna];
        if (nuovaCella.animali.size() == 0) {
          Animale figlio = new Animale(nuovaRiga, nuovaColonna, ambiente);
          cellaCorrente.aggiungiAnimale(figlio);
          nuovaCella.aggiungiAnimale(figlio);
        }
      }
    }
  }

  void morire() {
    vivo = false;
    Cella cellaCorrente = ambiente.griglia[riga][colonna];
    cellaCorrente.rimuoviAnimale(this);
  }

  boolean èVivo() {
    return vivo;
  }

  void mostra() {
    if (vivo) {
      fill(0);
    } else {
      fill(200);
    }
    rect(colonna * dimensioneCella, riga * dimensioneCella, dimensioneCella, dimensioneCella);
  }
}
