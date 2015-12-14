#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>
#include <string>
#include <deque>


using namespace std;

void print_ans(vector<vector<string>*> list) {
    for (auto item : list) {
        for (auto word : *item) {
            cout<<word<<' ';
        }
        cout<<'\n';
    }
}

void debug(unordered_map<string, unordered_set<string>> &map) {
    for(auto item : map) {
        cout<<item.first<<":"<<endl;
        for(auto pattern : item.second) {
            cout<<pattern<<", ";
        }
        cout<<endl;
    }

}

class Solution {
public:
    vector<unordered_set<string>> status = vector<unordered_set<string>>();
    vector<deque<string>>  queues = vector<deque<string>>();
    vector<size_t> heads = vector<size_t>({0, 0});

    unordered_map<string, unordered_set<string>> pattern2word = unordered_map<string, unordered_set<string>>();
    unordered_map<string, unordered_set<string>> pre;
    vector<vector<string>*> result;

    unordered_set<string> word2pattern(string word) {
        unordered_set<string> rst;
        for (size_t i = 0; i < word.size(); ++i) {
            rst.insert(word.substr(0, i) + "*" + word.substr(i+1, word.size() - i - 1));
        }
        return rst;
    }

    void add_link(unordered_map<string, unordered_set<string>>& map, string k, string v) {
        if(map.count(k)) {
            map[k].insert(v);
        } else {
            map[k] = unordered_set<string>({v});
        }
    }

    vector<vector<string>> search(int dire) {
        vector<vector<string>> rst;

        deque<string> &q = this->queues[dire];
        size_t tmp_len = q.size();

        vector<string> tmp_list;

        while(this->heads[dire] < tmp_len) {
            string tmp_word = q[this->heads[dire]];
            ++this->heads[dire];

            if (tmp_word == "ian") {
                tmp_word = "ian";
            }

            for (auto pattern : this->word2pattern(tmp_word))
                if(!this->status[dire].count(pattern)) {
                    for (auto next_word : this->pattern2word[pattern]) {

                        if (!this->status[dire].count(next_word)) {

                            if (this->status[dire ^ 1].count(next_word)) {
                                if (dire) {
                                    rst.push_back(vector<string>{next_word, tmp_word});
                                } else {
                                    rst.push_back(vector<string>{tmp_word, next_word});
                                }
                            }

                            q.push_back(next_word);
                            tmp_list.push_back(next_word);

                            if (dire) {
                                add_link(this->pre, next_word, tmp_word);
                            } else {
                                add_link(this->pre, tmp_word, next_word);
                            }
                        }

                    }
                }
        }

        for(auto word : tmp_list) {
            this->status[dire].insert(word);
        }
        return rst;
    };

    void power(string word) {
        for (size_t i = 0; i < word.size(); ++i) {
            string pattern  = word.substr(0, i) + "*" + word.substr(i+1, word.size() - i - 1);
            if (!this->pattern2word.count(pattern)) {
                this->pattern2word[pattern] = unordered_set<string>({word});
            } else {
                this->pattern2word[pattern].insert(word);
            }
        }
    };


    vector<vector<string>*>* power_rst(string word) {
        vector<vector<string>*>* rst = new vector<vector<string>*>();

        for (auto next_word : this->pre[word])
        if(next_word.size()) {
            vector<vector<string>*>*  tmp = this->power_rst(next_word);
            for(auto item : *tmp) {
                rst->push_back(item);
            };
            delete tmp;
        }

        if(!this->pre[word].size()) {
            rst->push_back(new vector<string>());
        }
        for(auto item : *rst) {
            item->push_back(word);
        }
        return rst;
    };

    vector<vector<string>> findLadders(string beginWord, string endWord, unordered_set<string> &wordList) {
        this->queues.push_back(deque<string>());
        this->queues.push_back(deque<string>());
        this->queues[0].push_back(beginWord);
        this->queues[1].push_back(endWord);

        this->status.push_back(unordered_set<string>());
        this->status.push_back(unordered_set<string>());
        this->status[0].insert(beginWord);
        this->status[1].insert(endWord);

        this->power(beginWord);
        this->power(endWord);

        for (auto word : wordList) {
            this->power(word);
        }

        vector<string> pop_list;
        for (auto item: this->pattern2word ) {
            if( item.second.size() == 1 ) {
                pop_list.push_back(*item.second.begin());
            }
        }

        for (auto item : pop_list) {
            this->pattern2word.erase(item);
        }

        int flag = 0;
        for (size_t i = 0; i < wordList.size(); ++i) {
            vector<vector<string>> rst = this->search(flag);

            if (rst.size()) {
                this->result = *this->power_rst(beginWord);
                for(auto item : this->result) {
                    reverse(item->begin(), item->end());
                }
                print_ans(this->result);
                vector<vector<string>> rslt;
                for(auto item : this->result) {
                    if (*(item->end()-1) == endWord) {
                        rslt.push_back(*item);
                    }
                }

                return rslt;
            }
            flag ^= 1;
        }
        return vector<vector<string>>();
    };
};


int main()
{
    unordered_set<string> list = unordered_set<string>({"kid","tag","pup","ail","tun","woo","erg","luz","brr","gay","sip","kay","per","val","mes","ohs","now","boa","cet","pal","bar","die","war","hay","eco","pub","lob","rue","fry","lit","rex","jan","cot","bid","ali","pay","col","gum","ger","row","won","dan","rum","fad","tut","sag","yip","sui","ark","has","zip","fez","own","ump","dis","ads","max","jaw","out","btu","ana","gap","cry","led","abe","box","ore","pig","fie","toy","fat","cal","lie","noh","sew","ono","tam","flu","mgm","ply","awe","pry","tit","tie","yet","too","tax","jim","san","pan","map","ski","ova","wed","non","wac","nut","why","bye","lye","oct","old","fin","feb","chi","sap","owl","log","tod","dot","bow","fob","for","joe","ivy","fan","age","fax","hip","jib","mel","hus","sob","ifs","tab","ara","dab","jag","jar","arm","lot","tom","sax","tex","yum","pei","wen","wry","ire","irk","far","mew","wit","doe","gas","rte","ian","pot","ask","wag","hag","amy","nag","ron","soy","gin","don","tug","fay","vic","boo","nam","ave","buy","sop","but","orb","fen","paw","his","sub","bob","yea","oft","inn","rod","yam","pew","web","hod","hun","gyp","wei","wis","rob","gad","pie","mon","dog","bib","rub","ere","dig","era","cat","fox","bee","mod","day","apr","vie","nev","jam","pam","new","aye","ani","and","ibm","yap","can","pyx","tar","kin","fog","hum","pip","cup","dye","lyx","jog","nun","par","wan","fey","bus","oak","bad","ats","set","qom","vat","eat","pus","rev","axe","ion","six","ila","lao","mom","mas","pro","few","opt","poe","art","ash","oar","cap","lop","may","shy","rid","bat","sum","rim","fee","bmw","sky","maj","hue","thy","ava","rap","den","fla","auk","cox","ibo","hey","saw","vim","sec","ltd","you","its","tat","dew","eva","tog","ram","let","see","zit","maw","nix","ate","gig","rep","owe","ind","hog","eve","sam","zoo","any","dow","cod","bed","vet","ham","sis","hex","via","fir","nod","mao","aug","mum","hoe","bah","hal","keg","hew","zed","tow","gog","ass","dem","who","bet","gos","son","ear","spy","kit","boy","due","sen","oaf","mix","hep","fur","ada","bin","nil","mia","ewe","hit","fix","sad","rib","eye","hop","haw","wax","mid","tad","ken","wad","rye","pap","bog","gut","ito","woe","our","ado","sin","mad","ray","hon","roy","dip","hen","iva","lug","asp","hui","yak","bay","poi","yep","bun","try","lad","elm","nat","wyo","gym","dug","toe","dee","wig","sly","rip","geo","cog","pas","zen","odd","nan","lay","pod","fit","hem","joy","bum","rio","yon","dec","leg","put","sue","dim","pet","yaw","nub","bit","bur","sid","sun","oil","red","doc","moe","caw","eel","dix","cub","end","gem","off","yew","hug","pop","tub","sgt","lid","pun","ton","sol","din","yup","jab","pea","bug","gag","mil","jig","hub","low","did","tin","get","gte","sox","lei","mig","fig","lon","use","ban","flo","nov","jut","bag","mir","sty","lap","two","ins","con","ant","net","tux","ode","stu","mug","cad","nap","gun","fop","tot","sow","sal","sic","ted","wot","del","imp","cob","way","ann","tan","mci","job","wet","ism","err","him","all","pad","hah","hie","aim","ike","jed","ego","mac","baa","min","com","ill","was","cab","ago","ina","big","ilk","gal","tap","duh","ola","ran","lab","top","gob","hot","ora","tia","kip","han","met","hut","she","sac","fed","goo","tee","ell","not","act","gil","rut","ala","ape","rig","cid","god","duo","lin","aid","gel","awl","lag","elf","liz","ref","aha","fib","oho","tho","her","nor","ace","adz","fun","ned","coo","win","tao","coy","van","man","pit","guy","foe","hid","mai","sup","jay","hob","mow","jot","are","pol","arc","lax","aft","alb","len","air","pug","pox","vow","got","meg","zoe","amp","ale","bud","gee","pin","dun","pat","ten","mob"});

//    cout<<rst.size();

    for (auto item : Solution().findLadders("cet","ism", list)) {
        for (auto word : item) {
            cout<<word<<' ';
        }
        cout<<'\n';
    }
    return 0;
}


