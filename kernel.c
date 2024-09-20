void putc_to(unsigned int row, unsigned int col, const char c);

int main() {

	const char c = 'x';
	
	for(int x = 0; x < 500; ++x) {
		for(int y = 0; y < 500; ++y) {
			putc_to(x, y, c);	
		}
	}
}
