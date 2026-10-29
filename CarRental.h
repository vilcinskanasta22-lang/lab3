#ifndef CAR_RENTAL_H
#define CAR_RENTAL_H

#include <iostream>
#include <string>
#include <fstream>

class Car {
private:
 
    std::string model_;
    std::string licensePlate_;
    double dailyRate_;
    bool isAvailable_;
    double damageFee_;
    int year_;
    std::string color_;
    double mileage_;

public:
  
    static int totalCarsCreated_;
    Car();
    Car(std::string model, std::string plate, double rate, bool available, double fee, int year, std::string color, double mileage);
    Car(const Car& other);
    Car(const std::string& modelRef, const double& rateRef);

    ~Car();

    std::string GetModel() const { return model_; }
    double GetDailyRate() const { return dailyRate_; }
    bool IsAvailable() const { return isAvailable_; }
    void SetAvailable(bool status) { isAvailable_ = status; }
    void DisplayInfo() const;
    void ApplyDiscount(double percent);
    void ApplyDiscount(double percent, double extraBonus); 
    void UpdateStatus(bool available);
    Car CopyCarState(const Car& otherCar); 
    double CalculateRentalPrice(int days) const;
    void SaveToFile(std::ofstream& outFile) const;
    void LoadFromFile(std::ifstream& inFile);
    static int GetTotalCarsCreated();
};

class RentalOrder {
private:
  
    std::string clientPassport_;
    int rentalDays_;
    double totalCost_;
    std::string orderStatus_; 
    std::string rejectionReason_;
    bool isCarDamaged_;
    double damageNoteFee_;
    Car rentedCar_;

public:
   
    RentalOrder();
    RentalOrder(std::string passport, int days, std::string status, std::string reason, bool damaged, double fee, const Car& car);
    RentalOrder(const RentalOrder& other);

    ~RentalOrder();

    void DisplayOrder() const;
    void ConfirmOrder();
    void RejectOrder(const std::string& reason);
    void ReportDamage(double feeAmount);
    RentalOrder ProcessOrderState(const RentalOrder& otherOrder); 
    void UpdateDays(int days);
    void UpdateDays(int days, double newRate);
    void SaveToFile(std::ofstream& outFile) const;
    void LoadFromFile(std::ifstream& inFile);
    double GetTotalCost() const { return totalCost_; }
    std::string GetStatus() const { return orderStatus_; }
};

void CalculateAndPrintOrderSummary(const RentalOrder& order);
RentalOrder CreateDefaultOrder(const Car& car);

#endif 
