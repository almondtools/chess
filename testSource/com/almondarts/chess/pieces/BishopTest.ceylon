import ceylon.test { assertEquals, test, assertTrue }
import com.almondarts.chess { Location, Game, Move, Board, white, location, black, a, b, c, d, e, f, g }
import com.almondarts.chess.pieces { TestPiece, King }

shared class BishopTest() {

	Game game = Game();
	Board board = game.board; 

	test
	shared void getName()  {
		assertEquals(game.bishop(white).name, "bishop");
	}
	test
	shared void testThatBishopCanMoveDiagonal() {
		Bishop bishop = game.bishop(white);
		List<Move> possibleMoves = bishop.possibleMoves(board, location(c, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == bishop));
		assertTrue(possibleMoves.every((Move move) => move.from == location(c, 4)));

		assertEquals(possibleMoves.size, 11);
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 2)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 3)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 1)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 5)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 7)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 8)));
	}

	
	test
	shared void testThatBishopCanStrikeDiagonal() {
		board.putPiece(TestPiece(black), location(b, 3));
		board.putPiece(TestPiece(black), location(a, 6));
		board.putPiece(TestPiece(black), location(e, 2));
		board.putPiece(TestPiece(black), location(g, 8));

		Bishop bishop = game.bishop(white);
		List<Move> possibleMoves = bishop.possibleMoves(board, location(c, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == bishop));
		assertTrue(possibleMoves.every((Move move) => move.from == location(c, 4)));
		
		assertEquals(possibleMoves.size, 9);
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 7) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(g, 8) && move.capturing));
	}

	
	test
	shared void testThatBishopCannotJumpOverOwnColor() {
		board.putPiece(TestPiece(white), location(d, 5));

		Bishop bishop = game.bishop(white);
		List<Move> possibleMoves = bishop.possibleMoves(board, location(c, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == bishop));
		assertTrue(possibleMoves.every((Move move) => move.from == location(c, 4)));
		
		assertEquals(possibleMoves.size, 7);

		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 1) && !move.capturing));
	}

	
	test
	shared void testThatBishopCannotJumpOverOpponentColor() {
		TestPiece pieceD5 = TestPiece(black);
		board.putPiece(pieceD5, location(d, 5));

		Bishop bishop = game.bishop(white);
		List<Move> possibleMoves = bishop.possibleMoves(board, location(c, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == bishop));
		assertTrue(possibleMoves.every((Move move) => move.from == location(c, 4)));
		
		assertEquals(possibleMoves.size, 8);
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(a, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 1) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(d, 5) && move.capturing));
	}

	test
	shared void testThatBishopCannotMoveFreelyIfKingIsInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(d, 2));
		object piece extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(d, 2))?.equals(king) else false) {
					return [Move(this, location(c, 2), location(d, 2), king)];
				} else {
					return [];
				}
			}
		}
		board.putPiece(piece, location(c, 2));

		Bishop bishop = game.bishop(white);
		List<Move> possibleMoves = bishop.legalMoves(board, location(c, 4));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatBishopCannotMoveFreelyIfKingGetsInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(d, 2));
		object piece extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(c, 4)) exists) {
					return [];
				} else {
					return [Move(this, location(c, 2), location(d, 2), king)];
				}
			}
		}
		board.putPiece(piece, location(c, 2));

		Bishop bishop = game.bishop(white);
		List<Move> possibleMoves = bishop.legalMoves(board, location(c, 4));

		assertEquals(possibleMoves.size, 0);
	}

}
