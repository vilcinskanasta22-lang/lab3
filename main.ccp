#include <iostream>
#include <fstream>
#include "CarRental.h"

int main() {
    std::cout << "=== Car Rental Management System ===" << std::endl;
    std::cout << "Total cars created at start: " << Car::GetTotalCarsCreated() << std::endl;

    Car staticCars[5] = {
        Car("Toyota Camry", "BC1111AA", 60.0, true, 0.0, 2021, "Silver", 15000),
        Car("BMW X5", "BC2222BB", 120.0, true, 0.0, 2023, "Black", 5000),
        Car("Audi A6", "BC3333CC", 100.0, true, 0.0, 2022, "White", 8000),
        Car("Honda Civic", "BC4444DD", 45.0, true, 0.0, 2019, "Blue", 30000),
        Car("Mercedes E-Class", "BC5555EE", 130.0, true, 0.0, 2023, "Grey", 2000)
    };

    Car* dynamicCars = new Car[5]{
        Car("Ford Mustang", "AA1001AA", 90.0, true, 0.0, 2021, "Red", 12000),
        Car("Nissan Leaf", "AA1002BB", 40.0, true, 0.0, 2020, "Green", 25000),
        Car("Hyundai Tucson", "AA1003CC", 55.0, true, 0.0, 2022, "Black", 10000),
        Car("Kia Sportage", "AA1004DD", 50.0, true, 0.0, 2021, "White", 18000),
        Car("Tesla Model 3", "AA1005EE", 110.0, true, 0.0, 2023, "Red", 4000)
    };

    std::cout << "\n--- Static Cars List ---" << std::endl;
    for (int i = 0; i < 5; ++i) {
        staticCars[i].DisplayInfo();
    }

    std::cout << "\n--- Interaction Scenario: Client rents a car ---" << std::endl;
    RentalOrder clientOrder("KB987654", 5, "Pending", "", false, 0.0, staticCars[1]);
    clientOrder.DisplayOrder();
    std::cout << "\nAdmin confirms the order..." << std::endl;
    clientOrder.ConfirmOrder();
    clientOrder.DisplayOrder();
    std::cout << "\nCar was damaged! Admin logs damage fee..." << std::endl;
    clientOrder.ReportDamage(150.0);
    clientOrder.DisplayOrder();
    CalculateAndPrintOrderSummary(clientOrder);
    RentalOrder defaultOrder = CreateDefaultOrder(staticCars[0]);
    std::cout << "\n--- Generated Default Order ---" << std::endl;
    defaultOrder.DisplayOrder();
    std::cout << "\n--- File I/O Operations ---" << std::endl;
    std::ofstream outFile("data.txt");
    staticCars[0].SaveToFile(outFile);
    clientOrder.SaveToFile(outFile);
    outFile.close();
    std::cout << "Data saved to data.txt successfully!" << std::endl;
    delete[] dynamicCars;

    std::cout << "\nTotal cars created at end: " << Car::GetTotalCarsCreated() << std::endl;
    return 0;
}
