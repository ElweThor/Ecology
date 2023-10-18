class CellEnv { //<>//
  int nRows;
  int nCols;
  Cell[][] grid;

  CellEnv(int nRows, int nCols) { //<>//
    this.nRows = nRows;
    this.nCols = nCols;
    grid = new Cell[nRows][nCols];
  }

  void init() { //<>//
    for (int row = 0; row < nRows; row++) {
      for (int col = 0; col < nCols; col++) {
        grid[row][col] = new Cell();
        if (random(1) < animRatio) {
          Body body = new Body(row, col, this);
          grid[row][col].addBody(body);
        }
      }
    }
  }

  void update() { //<>//
    for (int row = 0; row < nRows; row++) {
      for (int col = 0; col < nCols; col++) {
        grid[row][col].update();
      }
    }
  }

  void show() { //<>//
    for (int row = 0; row < nRows; row++) {
      for (int col = 0; col < nCols; col++) {
        grid[row][col].show();
      }
    }
  }
}
