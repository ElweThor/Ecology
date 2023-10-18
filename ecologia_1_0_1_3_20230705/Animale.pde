class Animale {
  int riga;
  int colonna;
  int[] dna;
  boolean vivo;

  AmbienteCellulare ambiente;

  String tipo;
  char carattere;

  Animale(int riga, int colonna, AmbienteCellulare ambiente) {
    this.riga = riga;
    this.colonna = colonna;
    this.ambiente = ambiente;
    dna = new int[numeroSlotDNA];
    vivo = true;

    if (riga < numRighe / 3) {
      tipo = "veg";
      carattere = 'v';
    } else if (riga < 2 * numRighe / 3) {
      tipo = "herb";
      carattere = 'h';
    } else {
      tipo = "carn";
      carattere = 'c';
    }

    for (int i = 0; i < numeroSlotDNA; i++) {
      dna[i] = int(random(3));
    }
  }

  void aggiorna() {
    if (!vivo) {
      return;
    }

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
    Cella cellaCorrente = ambiente.griglia[riga][colonna];
    for (Animale animale : cellaCorrente.animali) {
      if (animale != this) {
        animale.morire();
        return;
      }
    }
  }

  void riproduci() {
    Cella cellaCorrente = ambiente.griglia[riga][colonna];
    boolean esistonoCellaVicinaVuota = false;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int rigaVicina = riga + i;
        int colonnaVicina = colonna + j;
        if (rigaVicina >= 0 && rigaVicina < ambiente.numRighe && colonnaVicina >= 0 && colonnaVicina < ambiente.numColonne) {
          Cella cellaVicina = ambiente.griglia[rigaVicina][colonnaVicina];
          if (cellaVicina.animali.isEmpty()) {
            esistonoCellaVicinaVuota = true;
            break;
          }
        }
      }
    }

    if (esistonoCellaVicinaVuota) {
      int nuovaRiga = riga + int(random(-1, 2));
      int nuovaColonna = colonna + int(random(-1, 2));

      if (nuovaRiga >= 0 && nuovaRiga < ambiente.numRighe && nuovaColonna >= 0 && nuovaColonna < ambiente.numColonne) {
        Cella nuovaCella = ambiente.griglia[nuovaRiga][nuovaColonna];
        if (nuovaCella.animali.isEmpty()) {
          Animale figlio = new Animale(nuovaRiga, nuovaColonna, ambiente);
          cellaCorrente.aggiungiAnimale(figlio);
        }
      }
    }
  }

  void morire() {
    vivo = false;
  }

  boolean èVivo() {
    return vivo;
  }

  void mostra() {
    fill(colorePerTipo(tipo));
    text(carattere, colonna * dimensioneCella, riga * dimensioneCella);
  }

  int colorePerTipo(String tipo) {
    if (tipo.equals("veg")) {
      return color(0, 255, 128); // Colore per i vegetali (verde)
    } else if (tipo.equals("herb")) {
      return color(255, 128, 0); // Colore per gli animali erbivori (arancione)
    } else if (tipo.equals("carn")) {
      return color(255, 0, 0); // Colore per gli animali carnivori (rosso)
    } else {
      return color(0); // Colore predefinito (nero)
    }
  }
}
