#include <iostream>
using namespace std;
int main(void) {
	int n = 0, m = 0;
	cin >> n >> m;
	char** A = new char* [n];
	for (int i = 0; i < n; i++) {
		A[i] = new char(n);
	}
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			cin >> A[i][j];
		}
	}
	int x = 0, y = 0;
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			if (A[i][j] == 'S') {
				x = j; y = i;
			}
		}
	}
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			if (A[i][j] == '.') {
				if (j < x && A[i][j + 1] != '#') {
					A[i][j] = 'R';
					continue;
				}
				if (j > x && A[i][j - 1] != '#') {
					A[i][j] = 'L';
					continue;
				}
				if ((A[i][j + 1] == '#' && A[i][j - 1] == '#' && A[i + 1][j] == '#') || (x == j && y < i)) {
					A[i][j] = 'U';
					continue;
				}
				if ((A[i][j + 1] == '#' && A[i][j - 1] == '#' && A[i - 1][j] == '#') || (x == j && y > i)) {
					A[i][j] = 'D';
					continue;
				}
			}
		}
	}
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < m; j++) {
			cout << A[i][j];
		}
		cout << endl;
	}
	return 0;
}