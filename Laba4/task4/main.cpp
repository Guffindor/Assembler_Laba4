#include <iostream>
extern "C" {
unsigned getCpuCores();
}
int main() {
std::cout << getCpuCores() <<'\n';
return 0;
}

