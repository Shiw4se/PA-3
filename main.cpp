#include <iostream>
#include "FuncA.h"
#include <complex>

int main() {
    FuncA func;  // Створюємо екземпляр класу FuncA
    std::complex<double> x(1.0, 1.0);  // Ініціалізація комплексного числа x з дійсною частиною 1.0 та уявною частиною 1.0
    int n;  // Змінна для кількості членів ряду

    std::cout << "Enter n:";  // Запит на введення кількості членів
    std::cin >> n;  // Зчитування значення n

    // Виклик методу Calculate класу FuncA і вивід результату
    std::cout << "Result: " << func.Calculate(n, x) << "\n";  
    return 0;  // Повертаємо 0, щоб вказати на успішне завершення програми
}

