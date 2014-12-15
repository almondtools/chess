shared class Move(piece, from, to, targetPiece = null) {
	
	shared Piece piece;
	shared Location from;
	shared Location to;
	shared Piece? targetPiece;

	shared Boolean capturing => targetPiece exists;
	shared Float distance => from.distanceTo(to);
	shared Color nextColor => piece.color.opponent;

	shared Integer rowDistance() {
		return from.rowDistanceTo(to);
	}

	shared Integer colDistance() {
		return from.colDistanceTo(to);
	}

	shared actual Integer hash {
		return piece.hash * 31 + from.hash * 17 + to.hash * 13 + (targetPiece?.hash else 0) * 7 ;
	}

	shared actual Boolean equals(Object that) {
		if (is Move that) {
			if (exists thisTarget = this.targetPiece) {
				if (exists thatTarget = that.targetPiece) {
					return this.piece == that.piece && this.from == that.from && this.to == that.to && thisTarget == thatTarget;
				} else {
					return false;
				}
			} else {
				if (exists thatTarget = that.targetPiece) {
					return false;
				} else {
					return true;
				}
			}
		} else {
			return false;
		}
	}
	
}