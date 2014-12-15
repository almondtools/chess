shared abstract class Color(ordinal) 
	of white | black {

	shared Integer ordinal;
	shared formal Integer direction;
	shared formal Integer startRow;
	shared formal Color opponent;
}

shared object white extends Color(0) {

	shared actual Integer direction = 1;
	shared actual Integer startRow = 1;
	shared actual Color opponent => black;

}

shared object black extends Color(1) {

	shared actual Integer direction = -1;
	shared actual Integer startRow = 8;
	shared actual Color opponent => white;

}