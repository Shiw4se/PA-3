#include "FuncA.h"          // Підключення заголовочного файлу FuncA, що містить визначення класу FuncA
#include <cmath>           // Підключення математичної бібліотеки для математичних функцій
#include <complex>         // Підключення бібліотеки для роботи з комплексними числами


// Конструктор класу FuncA
FuncA::FuncA() {
}

long long Factorial(int num){
	long long res=1;
	for(int i=2; i<=num;++i){
		res *=i;
	}
	return res;
}

std::complex<double> FuncA::Calculate(int n,std::complex<double> x){
	std::complex<double> sum=0;
	for(int i =0; i<n; ++i){
		sum +=pow(x,2 * i)/static_cast<double>(Factorial(2*i));
	}
	return sum ;
}

