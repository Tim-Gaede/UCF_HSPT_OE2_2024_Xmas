#include <bits/stdc++.h>
using namespace std;

#define rep(i, a, b) for(int i = a; i < (b); i++)
#define all(x) begin(x), end(x)
#define sz(x) (int) (x).size()

const string filename = "xmas";

using ll = long long;
using vi = vector<int>;
using pii = pair<int, int>;
using vii = vector<pii>;

ll solve(vi data) {
    ll ans = 0;
    rep(i, 2, data[1]+2) {
        int forget = data[i];
        assert(forget);
        rep(j, 1, forget) {
            ans += j;
        }
        ans++;
    }
    rep(j, 1, data[0]+1)
        ans += j;
    return ans;
}

void makeFiles(vi data, int curFile) {
    string file = filename;
    if(curFile < 100) file += '0';
    if(curFile < 10) file += '0';
    file += to_string(curFile);

    ofstream in(file + ".in");
    ofstream out(file + ".out");

    in << data[0] << ' ' << data[1] << '\n';
    in << data[2];
    rep(i, 3, data[1]+2)
        in << ' ' << data[i];
    in << '\n';
    
    out << solve(data) << '\n';
}

int main() {
    int cnt = 1;

    vi sample1 = {12, 3, 4, 7, 9};
    makeFiles(sample1, cnt++);

    vi sample2 = {5, 1, 3};
    makeFiles(sample2, cnt++);

    vi minCase1 = {1, 1, 1};
    makeFiles(minCase1, cnt++);

    vi minCase2 = {2, 1, 1};
    makeFiles(minCase2, cnt++);

    // all forgotten cases
    vi ns = {2, 15, 50, 300, 5000, 10000};
    for(int n: ns) {
        vi data = {n, n};
        rep(i, 1, n+1)
            data.push_back(i);
        makeFiles(data, cnt++);
    }

    // random cases
    srand(time(0));

    // small random cases
    rep(i, 0, 5) {
        int n = rand() % 100 + 1, k = rand() % (n/2) + 1;
        vi data = {n, k};
        rep(j, 0, k) {
            int d = rand() % n + 1;
            if(count(data.begin() + 2, data.end(), d)) {
                j--;
                continue;
            }
            data.push_back(d);
        }
        sort(data.begin() + 2, data.end());
        makeFiles(data, cnt++);
    }

    // medium random cases
    rep(i, 0, 5) {
        int n = rand() % 501 + 500, k = rand() % (n/2) + 1;
        vi data = {n, k};
        rep(j, 0, k) {
            int d = rand() % n + 1;
            if(count(data.begin() + 2, data.end(), d)) {
                j--;
                continue;
            }
            data.push_back(d);
        }
        sort(data.begin() + 2, data.end());
        makeFiles(data, cnt++);
    }

    // large random cases
    rep(i, 0, 5) {
        int n = rand() % 5001 + 5000, k = rand() % (n/2) + 1;
        vi data = {n, k};
        rep(j, 0, k) {
            int d = rand() % n + 1;
            if(count(data.begin() + 2, data.end(), d)) {
                j--;
                continue;
            }
            data.push_back(d);
        }
        sort(data.begin() + 2, data.end());
        makeFiles(data, cnt++);
    }

    // max cases
    // small random cases
    rep(i, 0, 5) {
        int n = 10000, k = rand() % (n/2) + n/2;
        vi data = {n, k};
        rep(j, 0, k) {
            int d = rand() % n + 1;
            if(count(data.begin() + 2, data.end(), d)) {
                j--;
                continue;
            }
            data.push_back(d);
        }
        sort(data.begin() + 2, data.end());
        makeFiles(data, cnt++);
    }
}
