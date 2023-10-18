class Body { //<>//
  int row;
  int col;
  int[] dna;
  boolean alive;

  CellEnv envmt; //<>//

  String race;
  char symb;

  Body(int row, int col, CellEnv envmt) { //<>//
    this.row = row;
    this.col = col;
    this.envmt = envmt;
    dna = new int[DNAslots];
    alive = true;

    if (row < nRows / 3) {
      race = "veg";
      symb = 'v';
    } else if (row < 2 * nRows / 3) {
      race = "herb";
      symb = 'h';
    } else {
      race = "carn";
      symb = 'c';
    }

    for (int i = 0; i < DNAslots; i++) {
      dna[i] = int(random(3));
    }
  }

  void update() { //<>//
    if (!alive) {
      return;
    }

    int gene = dna[frameCount % DNAslots];

    switch (gene) {
      case MOV:
        go();
        break;
      case EAT:
        eat();
        break;
      case BRD:
        breed();
        break;
    }

    if (frameCount % (100 * DNAslots) == 0) {
      for (int i = 0; i < DNAslots; i++) {
        if (random(1) < mutRatio) {
          dna[i] = int(random(3));
        }
      }
    }
  }

  void go() { //<>//
    int newRow = row + int(random(-1, 2));
    int newCol = col + int(random(-1, 2));

    if (newRow >= 0 && newRow < envmt.nRows && newCol >= 0 && newCol < envmt.nCols) {
      Cell newCell = envmt.grid[newRow][newCol];
      if (newCell.bodies.size() < 2) {
        row = newRow;
        col = newCol;
      }
    }
  }

  void eat() { //<>//
    Cell currCell = envmt.grid[row][col];
    for (Body body : currCell.bodies) {
      if (body != this) {
        body.die();
        return;
      }
    }
  }

  void breed() { //<>//
    Cell currCell = envmt.grid[row][col];
    boolean isNearEmptyCell = false;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int nearRow = row + i;
        int nearCol = col + j;
        if (nearRow >= 0 && nearRow < envmt.nRows && nearCol >= 0 && nearCol < envmt.nCols) {
          Cell nearCell = envmt.grid[nearRow][nearCol];
          if (nearCell.bodies.isEmpty()) {
            isNearEmptyCell = true;
            break;
          }
        }
      }
    }

    if (isNearEmptyCell) {
      int newRow = row + int(random(-1, 2));
      int newCol = col + int(random(-1, 2));

      if (newRow >= 0 && newRow < envmt.nRows && newCol >= 0 && newCol < envmt.nCols) {
        Cell newCell = envmt.grid[newRow][newCol];
        if (newCell.bodies.isEmpty()) {
          Body child = new Body(newRow, newCol, envmt);
          currCell.addBody(child);
        }
      }
    }
  }

  void die() { //<>//
    alive = false;
  }

  boolean isAlive() {
    return alive;
  }

  void show() { //<>//
    fill(raceColor(race));
    //text(symb, col * cellSize, row * cellSize);
    text(symb, col * cellW, row * cellH);
  }

  int raceColor(String race) { //<>//
    if (race.equals("veg")) {
      return color(0, 255, 128); // Colore per i vegetali (verde)
    } else if (race.equals("herb")) {
      return color(255, 128, 0); // Colore per gli animali erbivori (arancione)
    } else if (race.equals("carn")) {
      return color(255, 0, 0); // Colore per gli animali carnivori (rosso)
    } else {
      return color(0); // Colore predefinito: sfondo (nero)
    }
  }
}
