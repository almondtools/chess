import ceylon.test { assertEquals, test, assertTrue }
import com.almondarts.chess { Location, Game, Move, Board, white, location, black, b, c, d, e, f }
import com.almondarts.chess.pieces { TestPiece, King }

shared class KnightTest() {

	Game game = Game();
	Board board = game.board; 

	test
	shared void getName()  {
		assertEquals(game.knight(white).name, "knight");
	}

	test
	shared void testThatKnightCanMoveLikeAKnight() {
		Knight knight = game.knight(white);
		List<Move> possibleMoves = knight.possibleMoves(board, location(d, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == knight));
		assertTrue(possibleMoves.every((Move move) => move.from == location(d, 4)));
		
		assertEquals(possibleMoves.size, 8);
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 6)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 5)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 3)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2)));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 2)));
	}
	
	test
	shared void testThatKnightCanStrikeLikeAKnight() {
		board.putPiece(TestPiece(black), location(b, 3));
		board.putPiece(TestPiece(black), location(e, 6));
		board.putPiece(TestPiece(black), location(f, 5));
		board.putPiece(TestPiece(black), location(c, 2));

		Knight knight = game.knight(white);
		List<Move> possibleMoves = knight.possibleMoves(board, location(d, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == knight));
		assertTrue(possibleMoves.every((Move move) => move.from == location(d, 4)));
		
		assertEquals(possibleMoves.size, 8);
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 6) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 6) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 5) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(f, 3) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(e, 2) && !move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(c, 2) && move.capturing));
	}

	
	test
	shared void testThatKnightCanJumpOverAnyColor() {
		board.putPiece(TestPiece(black), location(b, 3));
		board.putPiece(TestPiece(black), location(b, 5));
		board.putPiece(TestPiece(black), location(c, 3));
		board.putPiece(TestPiece(black), location(c, 4));
		board.putPiece(TestPiece(black), location(c, 5));
		board.putPiece(TestPiece(black), location(d, 3));
		board.putPiece(TestPiece(black), location(d, 5));

		Knight knight = game.knight(white);
		List<Move> possibleMoves = knight.possibleMoves(board, location(d, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece == knight));
		assertTrue(possibleMoves.every((Move move) => move.from == location(d, 4)));
		
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 3) && move.capturing));
		assertTrue(possibleMoves.any((Move move) => move.to == location(b, 5) && move.capturing));
	}

	test
	shared void testThatKnightCannotMoveFreelyIfKingIsInCheck() {
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

		Knight knight = game.knight(white);
		List<Move> possibleMoves = knight.legalMoves(board, location(c, 4));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatKnightCannotMoveFreelyIfKingGetsInCheck() {
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

		Knight knight = game.knight(white);
		List<Move> possibleMoves = knight.legalMoves(board, location(c, 4));

		assertEquals(possibleMoves.size, 0);
	}

}
