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
