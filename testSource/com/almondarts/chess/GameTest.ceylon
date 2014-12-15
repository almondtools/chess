import ceylon.test { assertEquals, test }
import com.almondarts.chess { white }
import com.almondarts.chess.pieces { TestPiece }

shared class GameTest() {
	
	Game game = Game();
	
	test
	shared void freshHistory() {
		assertEquals(game.history.size, 0);
	}
	
	test
	shared void history() {
		game.apply(Move(TestPiece(white), location(a, 1), location(a, 2)));
		assertEquals(game.history.size, 1);
	}
	
	test
	shared void lastMove() {
		Piece piece = TestPiece(white);
		game.apply(Move(piece, location(a, 1), location(a, 2)));
		assertEquals(game.lastMove(), Move(piece, location(a, 1), location(a, 2)));
	}

}