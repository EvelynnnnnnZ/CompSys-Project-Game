/********************************************************
 * file name   : problem2.c                             *
 * author      : Thomas Farmer
 * description : C program to call LC4-Assembly TRAP_PUTC
 *               the TRAP is called through the wrapper 
 *               lc4putc() (located in lc4_stdio.asm)   *
 ********************************************************
*
*/

int main() {

	char c = 10 ;		/* ASCII A = x41 in hex, #65 in dec. */
	char d = 11;
	char e = 12;
	char f = 13;

	lc4_draw_sprite (c, d, e, f) ;

	return (0) ;

}
