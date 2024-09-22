void putc_to(unsigned int row, unsigned int col, const char c);
void clear_src(unsigned int startRow, unsigned int startColumn, unsigned int endRow, unsigned int endColumn);
void box(unsigned int startRow, unsigned int startColumn, unsigned int endRow, unsigned int endColumn);
int term_txtheight();
int term_txtwidth();


int main() {
	unsigned int startRow = 0;
	unsigned int startColumn = 0;
	unsigned int endRow = 5;
	unsigned int endColumn = 5;
	clear_src(startRow, startColumn, endRow, endColumn);

	box(startRow, startColumn, endRow, endColumn);
}

void clear_src(unsigned int startRow, unsigned int startColumn, unsigned int endRow, unsigned int endColumn) {

	const char c = ' ';
	for(unsigned int x = startRow; x < endRow; ++x) {
		for(unsigned int y = startColumn; y < endColumn; ++y) {
			putc_to(x, y, c);
		}
	}
}
