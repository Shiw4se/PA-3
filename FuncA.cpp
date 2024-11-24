#include "FuncA.h"          // Підключення заголовочного файлу FuncA, що містить визначення класу FuncA
#include <cmath>           // Підключення математичної бібліотеки для математичних функцій
#include <complex>         // Підключення бібліотеки для роботи з комплексними числами
#include <chrono>
#include <complex>
#include <algorithm>
#include <cassert>
#include <string>
#include <iostream>

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

void FuncA::testServerSimulation() {
    FuncA func;
    int n = 10; // кількість елементів для обчислення
    std::complex<double> x(1.0, 0.5);

    std::vector<std::complex<double>> results;
    
    auto start_time = std::chrono::high_resolution_clock::now();

    // Генерація результатів
    for (int i = 0; i < 100000; ++i) {
        results.push_back(func.Calculate(n, x));
    }

    // Сортування
    for(int i=0; i<500; i++){
    		std::sort(results.begin(), results.end(), [](const auto &a, const auto &b) {
        	return std::abs(a) < std::abs(b);
    	});
    }
    auto end_time = std::chrono::high_resolution_clock::now();
    auto elapsed = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);

   // Виведення часу на консоль (імітація відповіді сервера)
    std::cout << "Elapsed time (ms): " << elapsed.count() << std::endl;

    // Перевірка часу виконання
    assert(elapsed.count() >= 5000 && elapsed.count() <= 20000 && "Test failed: Elapsed time is out of bounds!");
}



