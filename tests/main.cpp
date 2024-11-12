#include "../FuncA.h"
#include <iostream>
#include <complex>
#include <cmath>

// Функція для порівняння результатів
bool verifySum(int n, std::complex<double> x, double expected_result) {
    FuncA func;
    std::complex<double> result = func.Calculate(n, x);
    

    return std::abs(result.real() - expected_result) < 1;
}

int main() {
    // Вхідні параметри
    std::complex<double> x(1.0, 1.0);  // Комплексне число x = 1 + i
    int n = 3;  // Кількість членів ряду

    // Обчислюємо очікуваний результат вручну для реальної частини
    double expected_result = 1.0 + (pow(x.real(), 2) / 2) + (pow(x.real(), 4) / 24);

    // Звірка суми ряду з очікуваним результатом
    if (verifySum(n, x, expected_result)) {
        std::cout << "The series sum is correct!" << std::endl;
        return 0;  // Повертаємо 0, якщо сума вірна
    } else {
        std::cout << "The series sum is incorrect!" << std::endl;
        return 1;  // Повертаємо 1, якщо сума неправильна
    }
}

