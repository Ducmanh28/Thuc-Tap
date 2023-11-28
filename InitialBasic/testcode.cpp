#include<iostream>
using namespace std;

void Swap(int a, int b){
    int c = a;
    a = b;
    b = c;
    cout<<"a = "<<a<<" b = "<<b;
}
int main(){
    int a = 5;
    int b = 10;
    Swap(a,b);
}