import com.almondarts.chess.pieces {King, Queen, Pawn, Knight, Bishop, Rook, BlackPawn, WhitePawn}
import ceylon.collection {LinkedList, MutableList}
import java.util { ResourceBundle {getBundle}}

shared class Game() {

	shared String prefixes = "prefixes";

	shared MutableList<Move> history = LinkedList<Move>();
	shared variable Board board = ConcreteBoard();
	shared variable Color turn = white;


	shared String prefix(String name) {
		return getBundle(prefixes).getString(name);
	}

	shared King king(Color color) {
		return King(this, color);
	}

	shared Queen queen(Color color) {
		return Queen(this, color);
	}

	shared Rook rook(Color color) {
		return Rook(this, color);
	}
	
	shared Bishop bishop(Color color) {
		return Bishop(this, color);
	}
	
	shared Knight knight(Color color) {
		return Knight(this, color);
	}
	
	shared Pawn pawn(Color color) {
		switch (color)
		case (white) {
			return WhitePawn(this, color);
		}
		case (black) {
			return BlackPawn(this, color);
		}
	}

	shared Board apply(Move move) {
		board = board.apply(move);
		history.add(move);
		turn = turn.opponent;
		return board;
	}
	
	shared Move? lastMove() {
		if (exists last = history.lastIndex) {
			return history.get(last);
		} else {
			return null;
		}
	}

}