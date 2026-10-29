
#include "CarRental.h"
#include <iostream>

int Car::totalCarsCreated_ = 0;

Car::Car() : model_("Unknown"), licensePlate_("AAA000"), dailyRate_(50.0), isAvailable_(true),
damageFee_(0.0), year_(2020), color_("White"), mileage_(10000.0) {
    totalCarsCreated_++;
}

Car::Car(std::string model, std::string plate, double rate, bool available, double fee, int year, std::string color, double mileage)
    : model_(model), licensePlate_(plate), dailyRate_(rate), isAvailable_(available),
    damageFee_(fee), year_(year), color_(color), mileage_(mileage) {
    totalCarsCreated_++;
}

Car::Car(const Car& other)
    : model_(other.model_), licensePlate_(other.licensePlate_), dailyRate_(other.dailyRate_),
    isAvailable_(other.isAvailable_), damageFee_(other.damageFee_), year_(other.year_),
    color_(other.color_), mileage_(other.mileage_) {
    totalCarsCreated_++;
}

Car::Car(const std::string& modelRef, const double& rateRef)
    : model_(modelRef), licensePlate_("TEMP00"), dailyRate_(rateRef), isAvailable_(true),
    damageFee_(0.0), year_(2022), color_("Black"), mileage_(0.0) {
    totalCarsCreated_++;
}

Car::~Car() {}

void Car::DisplayInfo() const {
    std::cout << "Car: " << model_ << " [" << licensePlate_ << "], Rate: $" << dailyRate_
        << "/day, Available: " << (isAvailable_ ? "Yes" : "No") << std::endl;
}

void Car::ApplyDiscount(double percent) {
    dailyRate_ -= (dailyRate_ * percent / 100.0);
}

void Car::ApplyDiscount(double percent, double extraBonus) {
    dailyRate_ -= (dailyRate_ * percent / 100.0) + extraBonus;
}

void Car::UpdateStatus(bool available) {
    isAvailable_ = available;
}

Car Car::CopyCarState(const Car& otherCar) {
    this->model_ = otherCar.model_;
    this->dailyRate_ = otherCar.dailyRate_;
    return *this;
}

double Car::CalculateRentalPrice(int days) const {
    return dailyRate_ * days;
}

void Car::SaveToFile(std::ofstream& outFile) const {
    if (outFile.is_open()) {
        outFile << model_ << " " << licensePlate_ << " " << dailyRate_ << " " << isAvailable_ << "\n";
    }
}

void Car::LoadFromFile(std::ifstream& inFile) {
    if (inFile.is_open()) {
        inFile >> model_ >> licensePlate_ >> dailyRate_ >> isAvailable_;
    }
}

int Car::GetTotalCarsCreated() {
    return totalCarsCreated_;
}

RentalOrder::RentalOrder()
    : clientPassport_("XX000000"), rentalDays_(1), totalCost_(50.0), orderStatus_("Pending"),
    rejectionReason_("None"), isCarDamaged_(false), damageNoteFee_(0.0), rentedCar_() {
}

RentalOrder::RentalOrder(std::string passport, int days, std::string status, std::string reason, bool damaged, double fee, const Car& car)
    : clientPassport_(passport), rentalDays_(days), orderStatus_(status), rejectionReason_(reason),
    isCarDamaged_(damaged), damageNoteFee_(fee), rentedCar_(car) {
    totalCost_ = rentedCar_.CalculateRentalPrice(rentalDays_);
}

RentalOrder::RentalOrder(const RentalOrder& other)
    : clientPassport_(other.clientPassport_), rentalDays_(other.rentalDays_), totalCost_(other.totalCost_),
    orderStatus_(other.orderStatus_), rejectionReason_(other.rejectionReason_),
    isCarDamaged_(other.isCarDamaged_), damageNoteFee_(other.damageNoteFee_), rentedCar_(other.rentedCar_) {
}

RentalOrder::~RentalOrder() {}

void RentalOrder::DisplayOrder() const {
    std::cout << "Order | Passport: " << clientPassport_ << " | Days: " << rentalDays_
        << " | Total: $" << totalCost_ << " | Status: " << orderStatus_ << std::endl;
    rentedCar_.DisplayInfo();
}

void RentalOrder::ConfirmOrder() {
    orderStatus_ = "Confirmed";
    rentedCar_.SetAvailable(false);
}

void RentalOrder::RejectOrder(const std::string& reason) {
    orderStatus_ = "Rejected";
    rejectionReason_ = reason;
    totalCost_ = 0.0;
}

void RentalOrder::ReportDamage(double feeAmount) {
    isCarDamaged_ = true;
    damageNoteFee_ = feeAmount;
    totalCost_ += feeAmount;
}

RentalOrder RentalOrder::ProcessOrderState(const RentalOrder& otherOrder) {
    this->orderStatus_ = otherOrder.orderStatus_;
    return *this;
}

void RentalOrder::UpdateDays(int days) {
    rentalDays_ = days;
    totalCost_ = rentedCar_.CalculateRentalPrice(rentalDays_);
}

void RentalOrder::UpdateDays(int days, double newRate) {
    rentalDays_ = days;
    rentedCar_.ApplyDiscount(newRate);
    totalCost_ = rentedCar_.CalculateRentalPrice(rentalDays_);
}

void RentalOrder::SaveToFile(std::ofstream& outFile) const {
    if (outFile.is_open()) {
        outFile << clientPassport_ << " " << rentalDays_ << " " << totalCost_ << " " << orderStatus_ << "\n";
    }
}

void RentalOrder::LoadFromFile(std::ifstream& inFile) {
    if (inFile.is_open()) {
        inFile >> clientPassport_ >> rentalDays_ >> totalCost_ >> orderStatus_;
    }
}

void CalculateAndPrintOrderSummary(const RentalOrder& order) {
    std::cout << "\n[External Function Calculation] Final Price with Tax (20%): $"
        << order.GetTotalCost() * 1.20 << std::endl;
}

RentalOrder CreateDefaultOrder(const Car& car) {
    RentalOrder newOrder("AB123456", 3, "Pending", "None", false, 0.0, car);
    return newOrder;
}

