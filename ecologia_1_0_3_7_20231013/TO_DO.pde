/*
  ___TO-DO___
  
  x viewport modificabile: valori dimensionali delle celle/organismi ricalcolati dinamicamente
  
  \ implementazione della "salute" negli organismi: ogni "race" ha un massimo (per race, con un piccolo delta per individuo), che non può superare: 
    - se la salute cala a zero muore
    - sotto un certo livello (percentuale) l'efficienza dell'individuo cala (es. il movimento viene rallentato, ci mette di più a mangiare, non partorisce)
  \ colori di background e degli organismi modificati: nero per lo sfondo, e gli organismi hanno luminosità dipendente dalla "salute"
  - "calorie" che un organismo fornisce quando viene mangiato, in dipendenza dal "race" e del max-salute individuale
  - "calorie" spese nelle varie azioni dagli organismi (diverse per race di azione: mangiare, muoversi, riprodursi)
  - "profili" delle razze, con parametri min/max per i vari geni (movimento, mangiare, riprodursi)
    # es. un vegetale avrà mov_max = 0, eat_max = 0, breed_max = 0.75
    # un erbivoro: mov_max = 1, eat_max = 0.5, breed_max = 0.5
    # un carnivoro: mov_max = 1, eat_max = 0.8, breed_max = 0.2
  
  - Ambiente toroidale: i margini della mappa diventano contigui, questo ha effetti su tutti i calcoli: prossimità, riproduzione, movimento
  - finestra "monitor separato" per statistiche/parametri di funzionamento: celle occupate, tipi di organismo, FPS, flag modificabili, ecc.
    - possibilità di passare allo step-by-step e di visualizzare/evidenziare
      - una razza, con display delle statistiche: energia globale, età individuo più vecchio, numero individui, percentuale rispetto al globale, ...
      - un individuo della razza, con display dei suoi parametri: energia, DNA, ...
  - verifica "fine del mondo": si calcola un "CRC" dell'intera matrice e si verifica se si sta ripetendo in un range di 2-5, per evitare che comportamenti ciclici traggano in inganno
*/
