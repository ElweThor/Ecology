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
        if (random(1) < probabilitaPresenzaAnimale) {
          Animale animale = new Animale(riga, colonna, this);
          griglia[riga][colonna].aggiungiAnimale(animale);
        }
      }
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
