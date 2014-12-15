import ceylon.test { assertEquals, test, assertTrue }
import com.almondarts.chess { Location, Game, Move, Board, white, location, black, c, d, e, f, Piece }

shared class PawnTest() {

	Game game = Game();
	Board board = game.board; 

	test
	shared void getName()  {
		assertEquals(game.pawn(white).name, "pawn");
	}

	test
	shared void testThatWhitePawnCanAlwaysStepOneTowards8() {
		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 2));

		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && !move.capturing && move.from == location(e, 2) && move.to == location(e, 3)));
	}

	test
	shared void testThatBlackPawnCanAlwaysStepOneTowards1() {
		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 7));

		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && !move.capturing && move.from == location(e, 7) && move.to == location(e, 6)));
	}

	test
	shared void testThatWhitePawnCannotStepBack() {
		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 2));

		
		assertTrue(possibleMoves.every((Move move) => move.to != location(e, 1)));
	}

	test
	shared void testThatBlackPawnCannotMoveBack() {
		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 7));

		assertTrue(possibleMoves.every((Move move) => move.to != location(e, 8)));
	}
	
	test
	shared void testThatWhitePawnCanOnlyStrikeDiagonalOneForward() {
		board.putPiece(TestPiece(black), location(d, 1));
		board.putPiece(TestPiece(black), location(e, 1));
		board.putPiece(TestPiece(black), location(f, 1));
		board.putPiece(TestPiece(black), location(d, 2));
		board.putPiece(TestPiece(black), location(f, 2));
		board.putPiece(TestPiece(black), location(d, 3));
		board.putPiece(TestPiece(black), location(e, 3));
		board.putPiece(TestPiece(black), location(f, 3));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 2));

		assertEquals(possibleMoves.size, 2);
		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && move.capturing && move.from == location(e, 2) && move.to == location(d, 3)));
		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && move.capturing && move.from == location(e, 2) && move.to == location(f, 3)));
	}

	
	test
	shared void testThatBlackPawnCanOnlyStrikeDiagonalOneForward() {
		board.putPiece(TestPiece(white), location(d, 8));
		board.putPiece(TestPiece(white), location(e, 8));
		board.putPiece(TestPiece(white), location(f, 8));
		board.putPiece(TestPiece(white), location(d, 7));
		board.putPiece(TestPiece(white), location(f, 7));
		board.putPiece(TestPiece(white), location(d, 6));
		board.putPiece(TestPiece(white), location(e, 6));
		board.putPiece(TestPiece(white), location(f, 6));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 7));

		assertEquals(possibleMoves.size, 2);
		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && move.capturing && move.from == location(e, 7) && move.to == location(d, 6)));
		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && move.capturing && move.from == location(e, 7) && move.to == location(f, 6)));
	}

	test
	shared void testThatWhitePawnCanStartMovingTwoFields() {
		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 2));

		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && !move.capturing && move.from == location(e, 2) && move.to == location(e, 4)));
	}

	test
	shared void testThatWhitePawnCanStartMovingTwoFieldsButNotJump() {
		board.putPiece(TestPiece(black), location(e, 3));
		
		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 2));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatWhitePawnCannotMoveTwoFieldsInGame() {
		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(d, 3));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || move.capturing || move.from != location(d, 3) || move.to != location(d, 5)));
	}

	test
	shared void testThatBlackPawnCanStartMovingTwoFields() {
		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 7));

		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && !move.capturing && move.from == location(e, 7) && move.to == location(e, 5)));
	}

	test
	shared void testThatBlackPawnCanStartMovingTwoFieldsButNotJump() {
		board.putPiece(TestPiece(white), location(e, 6));
		
		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 7));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatBlackPawnCannotMoveTwoFieldsInGame() {
		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(c, 6));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || move.capturing || move.from != location(c, 6) || move.to != location(c, 4)));
	}

	test
	shared void testThatWhitePawnCanStrikeEnPassantOnFifthLineIfLastMoveWasBlackPawnTwoFields() {
		Pawn pawnD7 = game.pawn(black);
		game.apply(Move(pawnD7, location(d, 7), location(d, 5)));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 5));

		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && (move.targetPiece?.equals(pawnD7) else false) && move.from == location(e, 5) && move.to == location(d, 6)));
	}

	test
	shared void testThatBlackPawnCanStrikeEnPassantOnFifthLineIfLastMoveWasBlackPawnTwoFields() {
		Pawn pawnD2 = game.pawn(white);
		game.apply(Move(pawnD2, location(d, 2), location(d, 4)));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 4));

		assertTrue(possibleMoves.any((Move move) => move.piece == pawn && (move.targetPiece?.equals(pawnD2) else false) && move.from == location(e, 4) && move.to == location(d, 3)));
	}

	test
	shared void testThatWhitePawnCannotStrikeEnPassantOnFifthLineIfLastMoveWasBlackPawnOneField() {
		Pawn pawnD7 = game.pawn(black);
		game.apply(Move(pawnD7, location(d, 6), location(d, 5)));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 5));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnD7) else false) || move.from != location(e, 5) || move.to != location(d, 6)));
	}

	test
	shared void testThatBlackPawnCannotStrikeEnPassantOnFifthLineIfLastMoveWasBlackPawnOneField() {
		Pawn pawnD2 = game.pawn(white);
		game.apply(Move(pawnD2, location(d, 3), location(d, 4)));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnD2) else false) || move.from != location(e, 4) || move.to != location(d, 3)));
	}

	test
	shared void testThatWhitePawnCannotStrikeEnPassantForOtherPiecesThanPawns() {
		Piece testD7 = TestPiece(black);
		game.apply(Move(testD7, location(d, 7), location(d, 5)));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 5));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(testD7) else false)));
	}

	test
	shared void testThatWhitePawnCannotStrikeEnPassantWithoutHistory() {
		Pawn pawnD5 = game.pawn(black);
		board.putPiece(pawnD5, location(d, 5));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 5));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnD5) else false)));
	}

	test
	shared void testThatWhitePawnCannotStrikeEnPassantNonAdjacentPawns() {
		Pawn pawnC7 = game.pawn(black);
		game.apply(Move(pawnC7, location(c, 7), location(c, 5)));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 5));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnC7) else false)));
	}

	test
	shared void testThatWhitePawnCannotStrikeEnPassantOnArbitrary2FieldMove() {
		Pawn pawnD5 = game.pawn(black);
		game.apply(Move(pawnD5, location(d, 5), location(d, 3)));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 5));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnD5) else false)));
	}

	test
	shared void testThatBlackPawnCannotStrikeEnPassantForOtherPiecesThanPawns() {
		Piece testD2 = TestPiece(white);
		game.apply(Move(testD2, location(d, 2), location(d, 4)));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(testD2) else false)));
	}

	test
	shared void testThatBlackPawnCannotStrikeEnPassantWithoutHistory() {
		Pawn pawnD4 = game.pawn(white);
		board.putPiece(pawnD4, location(d, 4));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnD4) else false)));
	}

	test
	shared void testThatBlackPawnCannotStrikeEnPassantNonAdjacentPawns() {
		Pawn pawnC2 = game.pawn(white);
		game.apply(Move(pawnC2, location(c, 2), location(c, 4)));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnC2) else false)));
	}

	test
	shared void testThatBlackPawnCannotStrikeEnPassantOnArbitrary2FieldMove() {
		Pawn pawnD4 = game.pawn(white);
		game.apply(Move(pawnD4, location(d, 4), location(d, 6)));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(game.board, location(e, 4));

		assertTrue(possibleMoves.every((Move move) => move.piece != pawn || !(move.targetPiece?.equals(pawnD4) else false)));
	}

	test
	shared void testThatWhitePawnCannotMoveIfKingIsInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(e, 1));
		object piece extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(e,1))?.equals(king) else false) {
					return [Move(this, location(e, 2), location(e, 1), king)];
				} else {
					return [];
				}
			}
		}
		board.putPiece(piece, location(e, 2));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.legalMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatWhitePawnCannotMoveSettingKingInCheck() {
		King king = game.king(white);
		board.putPiece(king, location(e, 3));
		object piece extends TestPiece(black) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(loc)?.equals(king) else false) {
					if (exists locr = loc.relative(0, -1)) {
						if (board.getPiece(locr) exists) {
							return [];
						} else {
							return [Move(this, location(e, 5), location(e, 3), king)];
						}
					} else {
						return [];
					}
				} else {
					return [];
				}
			}
		}
		board.putPiece(piece, location(e, 5));

		Pawn pawn = game.pawn(white);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatBlackPawnCannotMoveIfKingIsInCheck() {
		King king = game.king(black);
		board.putPiece(king, location(e, 1));
		object piece extends TestPiece(white) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(location(e,1))?.equals(king) else false) {
					return [Move(this, location(e, 2), location(e, 1), king)];
				} else {
					return [];
				}
			}
		}
		board.putPiece(piece, location(e, 2));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.legalMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

	test
	shared void testThatBlackPawnCannotMoveSettingKingInCheck() {
		King king = game.king(black);
		board.putPiece(king, location(e, 3));
		object piece extends TestPiece(white) {
			shared actual List<Move> possibleMoves(Board board, Location loc) {
				if (board.getPiece(loc)?.equals(king) else false) {
					if (exists locr = loc.relative(0, -1)) {
						if (board.getPiece(locr) exists) {
							return [];
						} else {
							return [Move(this, location(e, 5), location(e, 3), king)];
						}
					} else {
						return [];
					}
				} else {
					return [];
				}
			}
		}
		board.putPiece(piece, location(e, 5));

		Pawn pawn = game.pawn(black);
		List<Move> possibleMoves = pawn.possibleMoves(board, location(e, 4));

		assertEquals(possibleMoves.size, 0);
	}

}
