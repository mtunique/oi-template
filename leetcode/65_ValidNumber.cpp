#include<sstream>
#include<string>
#include<iostream>
using std::string;
using std::istringstream;
class Solution {
public:
    bool isNumber(string s) {
        double a=17171;
        std::stringstream trimmer;
        trimmer << s;
        s.clear();
        trimmer >> s;
        if (s == "e") return 0;
        try {
            istringstream(s) >> a;
            std::cout << a;
        }
        catch( ... )
        {
          return 0;
        }
        return 1;
    }
};

int main() {
    Solution s;
    std::cout << s.isNumber("e");
}
