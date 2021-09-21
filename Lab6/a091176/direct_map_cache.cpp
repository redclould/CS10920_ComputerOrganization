#include <iostream>
#include <string>
#include <math.h>
#include <getopt.h>

using namespace std;

struct cache_content{
	bool v;
	unsigned int  tag;
//	unsigned int	data[16];    
};

const int K=1024;

void simulate(int cache_size, int block_size, int asso, string& test_file_name){
	FILE * fp=fopen(test_file_name.c_str(),"r");    //read file
	
	if(!fp) {
		cout << "Test file doesn't exist\n";
		return;
	}
	
	unsigned int tag,index,x;

	int offset_bit = (int) log2(block_size);
	int index_bit = (int) log2(cache_size/block_size);
	int line = cache_size>>(offset_bit);

	float hit_count = 0;
	float miss_count = 0;
	int num[1000000];
	int count = 0;

	cache_content *cache =new cache_content[line];
	// cout<<"cache line:"<<line<<endl;

	for(int j=0;j<line;j++)
		cache[j].v=false;
	
	while(fscanf(fp,"%x",&x)!=EOF){
		// cout<<hex<<x<<" ";
		
		index=(x>>offset_bit)&(line-asso);
		tag=x>>(index_bit+offset_bit);
		if(cache[index].v && cache[index].tag==tag){
			cache[index].v=true;    //hit
			hit_count++;
			num[count] = 1;
		}
		else{						
			cache[index].v=true;    //miss
			cache[index].tag=tag;
			miss_count++;
			num[count] = 0;
		}
		count++;
	}

	//TODO 
	cout << "Miss rate: "<< miss_count*100/(hit_count+miss_count)<<endl;
	cout << "Hits instructions: ";

	int num1, num2;
	for(int i=0; i<count; i++){
		if(num[i]) {
			cout << i+1;
			num1 = i;
			break;
		}
	}
	for(int i=num1+1; i<count; i++){
		if(num[i]) cout<< ", "<<dec<<i+1;
	}
	cout<<endl;

	cout << "Misses instructions: ";
	for(int i=0; i<count; i++){
		if(!num[i]) {
			cout << i+1;
			num2 = i;
			break;
		}
	}
	for(int i=num2+1; i<count-1; i++){
		if(!num[i]) cout<< ", "<<dec<<i+1;
	}
	cout<<endl;

	// cout<<count<<endl;

	fclose(fp);

	delete [] cache;
}
	
int main(int argc, char** argv){
	string test_file_name;
	int cache_size = 4;
	int block_size = 16;
	int associativity = 1;
	int current_option;
	while((current_option = getopt(argc, argv, "f:c:b:a:")) != EOF) {
        switch(current_option) {
            case 'f': {
               test_file_name = string(optarg);
               break;
            }
            case 'c': {
                cache_size = atoi(optarg); 
                break;
            }
            case 'b': {
                block_size = atoi(optarg);
                break;
            }
			case 'a': {
                associativity = atoi(optarg);
                break;
            }
        }
    }
	
	// default simulate 4KB direct map cache with 16B blocks
	simulate(cache_size*K, block_size, associativity, test_file_name);
}


