import com.almondarts.chess {Game, Color, Piece, Location, location, a, h, Move}
import ceylon.collection { LinkedList, MutableList }


shared abstract class AbstractPiece(game, color) satisfies Piece {
	
	Game game;
	shared actual Color color;
	shared formal  Character[] symbols;
	shared actual Character symbol => fetchSymbol();
	shared actual String prefix => game.prefix(name);

	Character fetchSymbol() {
		assert (exists symbol = symbols[color.ordinal]);
		return symbol;
	}

	shared actual Boolean opponent(Piece other) {
		return color != other.color;
	}

	shared List<Location> computeIncrementingSumDiagonalLocations(Location loc) {
		Integer sum = loc.row + loc.col;
		MutableList<Location> locations = LinkedList<Location>();
		for (icol in (loc.col + 1)..h) {
			value irow = sum - icol; 
			if (irow < 1 || irow > 8) {
				break;
			}
			locations.add(location(icol, irow));
		}
		return locations;
	}

	shared List<Location> computeDecrementingSumDiagonalLocations(Location loc) {
		Integer sum = loc.row + loc.col;
		MutableList<Location> locations = LinkedList<Location>();
		for (icol in (loc.col - 1)..a) {
			value irow = sum - icol; 
			if (irow < 1 || irow > 8) {
				break;
			}
			locations.add(location(icol, irow));
		}
		return locations;
	}

	shared List<Location> computeIncrementingDiffDiagonalLocations(Location loc) {
		Integer diff = loc.row - loc.col;
		MutableList<Location> locations = LinkedList<Location>();
		for (icol in (loc.col + 1)..h) {
			value irow = diff + icol;
			if (irow < 1 || irow > 8) {
				break;
			}
			locations.add(location(icol, irow));
		}
		return locations;
	}

	shared List<Location> computeDecrementingDiffDiagonalLocations(Location loc) {
		Integer diff = loc.row - loc.col;
		MutableList<Location> locations = LinkedList<Location>();
		for (icol in (loc.col - 1)..a) {
			value irow = diff + icol;
			if (irow < 1 || irow > 8) {
				break;
			}
			locations.add(location(icol, irow));
		}
		return locations;
	}

	shared List<Location> computeIncrementingRowLocations(Location loc) {
		MutableList<Location> locations = LinkedList<Location>();
		for (irow in (loc.row + 1)..8) {
			locations.add(location(loc.col, irow));
		}
		return locations;
	}

	shared List<Location> computeDecrementingRowLocations(Location loc) {
		MutableList<Location> locations = LinkedList<Location>();
		for (irow in (loc.row - 1)..1) {
			locations.add(location(loc.col, irow));
		}
		return locations;
	}

	shared List<Location> computeIncrementingColLocations(Location loc) {
		MutableList<Location> locations = LinkedList<Location>();
		for (icol in (loc.col + 1)..h) {
			locations.add(location(icol, loc.row));
		}
		return locations;
	}

	shared List<Location> computeDecrementingColLocations(Location loc) {
		MutableList<Location> locations = LinkedList<Location>();
		for (icol in (loc.col - 1)..a) {
			locations.add(location(icol, loc.row));
		}
		return locations;
	}

	shared Move? lastMove() {
		return game.lastMove();
	}

}
