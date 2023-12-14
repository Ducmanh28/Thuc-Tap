#include <iostream>
#include <bitset>
#include <sstream>
#include <math.h>
using namespace std;

// Hàm chuyển đổi địa chỉ IP thành dạng nhị phân
string ipToBinary(const string& ip) {
    // Tạo một đối tượng stringstream từ chuỗi địa chỉ IP
    stringstream ss(ip);

    // Khai báo một chuỗi để lưu từng phần của địa chỉ IP
    string token;

    // Khai báo một chuỗi để lưu địa chỉ IP dạng nhị phân
    string binaryIp;

    // Vòng lặp đọc từng phần của địa chỉ IP
    while (getline(ss, token, '.')) {
        // Chuyển đổi từng phần từ dạng thập phân sang dạng nhị phân và thêm vào chuỗi binaryIp
        binaryIp += bitset<8>(stoi(token)).to_string();
    }

    // Trả về địa chỉ IP dạng nhị phân
    return binaryIp;
}


// Hàm chuyển đổi địa chỉ nhị phân thành dạng IP
string binaryToIp(const string& binaryIp) {
    // Khởi tạo một chuỗi để lưu địa chỉ IP dạng thập phân
    string ip;

    // Vòng lặp chạy qua từng phần của địa chỉ IP dạng nhị phân
    for (int i = 0; i < 32; i += 8) {
        // Chuyển đổi từng phần từ dạng nhị phân sang dạng thập phân và thêm vào chuỗi ip
        ip += to_string(bitset<8>(binaryIp.substr(i, 8)).to_ulong());

        // Thêm dấu chấm vào giữa các phần của địa chỉ IP
        if (i < 24) ip += ".";
    }

    // Trả về địa chỉ IP dạng thập phân
    return ip;
}


// Hàm tính toán và in ra các subnet
void calculateSubnets(const string& ip, int prefix, int borrowedBits) {
    string binaryIp = ipToBinary(ip);

    // Tính số lượng subnet bằng cách lấy 2 mũ borrowedBits
    int subnetCount = pow(2,borrowedBits);
    // In ra số Subnet đã tính được
    cout << "Subnets: " << subnetCount << endl;
    //Khởi tạo vòng lặp để tính toán và in ra các Subnet
    for (int i = 0; i < subnetCount; ++i) {
        // Tạo subnet nhị phân bằng cách nối phần tiền tố của địa chỉ IP với phần nhị phân của i
        string subnetBinary = binaryIp.substr(0, prefix);

        // Chuyển i sang dạng nhị phân và thêm vào subnetBinary
        for (int j = borrowedBits - 1; j >= 0; --j) {
            subnetBinary += ((i / (1 << j)) % 2) ? '1' : '0';
        }

        // Thêm các bit 0 vào cuối để đảm bảo độ dài là 32 bit
        subnetBinary += string(32 - subnetBinary.length(), '0');

        cout << "Subnet " << i + 1 << ": " << binaryToIp(subnetBinary) << "/" << prefix + borrowedBits << endl;
    }
}


int main() {
    string ip;
    int prefix, borrowedBits;
    cout << "IP: ";
    cin >> ip;
    cout << "prefix numbers: ";
    cin >> prefix;
    cout << "Numbers of bits: ";
    cin >> borrowedBits;
    string ips = ipToBinary(ip);
    cout<<ips<<endl;
    string ipss = binaryToIp(ips);
    cout<<ipss;
    calculateSubnets(ip, prefix, borrowedBits);
    system("pause");
    return 0;
}
/*
- for (int i = 0; i < subnetCount; ++i): Vòng lặp này chạy qua tất cả các subnet có thể có. Số lượng subnet được tính bằng cách lấy 2 mũ borrowedBits.

- string subnetBinary = binaryIp.substr(0, prefix);: Tạo chuỗi nhị phân cho subnet bằng cách lấy phần tiền tố của địa chỉ IP gốc.

- for (int j = borrowedBits - 1; j >= 0; --j): Vòng lặp này chuyển số nguyên i sang dạng nhị phân và thêm vào subnetBinary.

- subnetBinary += ((i / (1 << j)) % 2) ? '1' : '0';: Dòng này chuyển số nguyên i sang dạng nhị phân. Nếu bit thứ j của i là 1, 
thì thêm ‘1’ vào subnetBinary, ngược lại thêm ‘0’.

- subnetBinary += string(32 - subnetBinary.length(), '0');: Thêm các bit 0 vào cuối subnetBinary để đảm bảo rằng độ dài của nó là 32 bit.

- cout << "Subnet " << i + 1 << ": " << binaryToIp(subnetBinary) << "/" << prefix + borrowedBits << endl;: In ra subnet thứ i+1 và prefix của nó. 
Địa chỉ IP của subnet được chuyển từ dạng nhị phân sang dạng thập phân để dễ đọc hơn.
*/