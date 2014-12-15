import ceylon.math.float { sqrt }
import java.lang {Math {abs}}


shared class Location(col, row) satisfies Comparable<Location> {

	shared Integer col;
	shared Integer row;
	shared String id = computeId(col, row);
	shared Integer colIndex => col;
	shared Integer rowIndex => row - 1;
	shared Integer locationIndex => (row - 1) * 8 + col;
	shared actual String string => id;
	
	shared Location? relative(Integer colOffset, Integer rowOffset) {
		Integer newcol = col + colOffset;
		Integer newrow = row + rowOffset;
		if (newcol >= a && newcol <= h && newrow >= 1 && newrow <= 8) {
			return location(newcol, newrow);
		} else {
			return null;
		}
	}
	
	shared Integer colDistanceTo(Location to) {
		return abs(col - to.col);
	}
	
	shared Integer rowDistanceTo(Location to) {
		return abs(row - to.row);
	}
	
	shared Float distanceTo(Location to) {
		return sqrt(((col - to.col)*(col - to.col) + (row - to.row) * (row - to.row)).float);
	}

	shared actual Comparison compare(Location other) {
		return locationIndex <=> other.locationIndex;
	}

}

shared Integer a = 0;
shared Integer b = 1;
shared Integer c = 2;
shared Integer d = 3;
shared Integer e = 4;
shared Integer f = 5;
shared Integer g = 6;
shared Integer h = 7;

Location[][] initLocations() {
	Location field(Integer col, Integer row) => Location(col, row + 1);
	Location[] column(Integer col) => [for (row in 0..7) field(col, row)];
	Location[][] matrix => [for (col in a..h) column(col)];
	return matrix; 
}

Location[][] locations = initLocations();

String computeId(Integer col, Integer row) {
	return ('a'.integer + col).character.string + row.string;
}

shared Location location(Integer col, Integer row) {
	assert (exists columns = locations[col]);
	assert (exists field = columns[row - 1]);
	return field;
}

shared Location internal(Integer col, Integer row) {
	assert (exists columns = locations[col]);
	assert (exists field = columns[row]);
	return field;
}