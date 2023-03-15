use crms;
CREATE TABLE CarCategories (
    CarCategoryId INT PRIMARY KEY IDENTITY,
    CategoryName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(255),
    DailyRate DECIMAL(10, 2) NOT NULL,
    WeeklyRate DECIMAL(10, 2) NOT NULL,
    MonthlyRate DECIMAL(10, 2) NOT NULL
);
CREATE TABLE Locations (
    LocationId INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Latitude DECIMAL(9, 6),
    Longitude DECIMAL(9, 6)
);
CREATE TABLE CarVariants (
    CarVariantId INT PRIMARY KEY IDENTITY,
    CarCategoryId INT FOREIGN KEY REFERENCES CarCategories(CarCategoryId),
    VariantName NVARCHAR(255) NOT NULL -- Traslation
);
CREATE TABLE Cars (
    CarId INT PRIMARY KEY IDENTITY,
    CarVariantId INT FOREIGN KEY REFERENCES CarVariants(CarVariantId),
    LocationId INT FOREIGN KEY REFERENCES Locations(LocationId),
    Make NVARCHAR(255) NOT NULL,
    Model NVARCHAR(255) NOT NULL,
    Year INT NOT NULL,
    Color NVARCHAR(255) NOT NULL,
    LicensePlate NVARCHAR(255) UNIQUE NOT NULL,
    Mileage FLOAT NOT NULL,
    IsAvailable BIT NOT NULL,
    ImageUrl NVARCHAR(255)
);

CREATE TABLE Clients (
    ClientId INT PRIMARY KEY IDENTITY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(20),
    Address NVARCHAR(255)
);

CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(255) NOT NULL,
    LastName NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(255),
    DateOfBirth DATE,
    Address NVARCHAR(255),
    City NVARCHAR(255),
    State NVARCHAR(255),
    Country NVARCHAR(255),
    ZipCode NVARCHAR(50),
    RegistrationDate DATETIME NOT NULL
);
CREATE TABLE Bookings (
    BookingId INT PRIMARY KEY IDENTITY,
    ClientId INT FOREIGN KEY REFERENCES Clients(ClientId),
    CarId INT FOREIGN KEY REFERENCES Cars(CarId),
    StartDate DATETIME2 NOT NULL,
    EndDate DATETIME2 NOT NULL,
    PickupLocationId INT FOREIGN KEY REFERENCES Locations(LocationId),
    DropOffLocationId INT FOREIGN KEY REFERENCES Locations(LocationId),
    Status NVARCHAR(50) NOT NULL
);
CREATE TABLE Reservations (
    ReservationId INT PRIMARY KEY IDENTITY,
    UserId INT FOREIGN KEY REFERENCES Users(UserId),
    CarId INT FOREIGN KEY REFERENCES Cars(CarId),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    ReservationStatus NVARCHAR(255) NOT NULL
);
CREATE TABLE Payments (
    PaymentId INT PRIMARY KEY IDENTITY,
    ReservationId INT FOREIGN KEY REFERENCES Reservations(ReservationId),
    UserId INT FOREIGN KEY REFERENCES Users(UserId),
    PaymentAmount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATETIME NOT NULL,
    PaymentMethod NVARCHAR(255) NOT NULL,
    PaymentStatus NVARCHAR(255) NOT NULL
);
CREATE TABLE Maintenance (
    MaintenanceId INT PRIMARY KEY IDENTITY,
    CarId INT FOREIGN KEY REFERENCES Cars(CarId),
    MaintenanceType NVARCHAR(255) NOT NULL,
    Description NVARCHAR(255),
    DatePerformed DATETIME NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL
);
CREATE TABLE MaintenanceReceipts (
    ReceiptId INT PRIMARY KEY IDENTITY,
    MaintenanceId INT FOREIGN KEY REFERENCES Maintenance(MaintenanceId),
    ReceiptFileName NVARCHAR(255) NOT NULL,
    ReceiptContentType NVARCHAR(255) NOT NULL,
    ReceiptUrl NVARCHAR(255)
);
CREATE TABLE TelemetryData (
    TelemetryDataId INT PRIMARY KEY IDENTITY,
    CarId INT FOREIGN KEY REFERENCES Cars(CarId),
    Timestamp DATETIME NOT NULL,
    Latitude FLOAT NOT NULL,
    Longitude FLOAT NOT NULL,
    Speed FLOAT,
    EngineTemperature FLOAT,
    FuelLevel FLOAT,
    TirePressure FLOAT,
    BatteryVoltage FLOAT
);
CREATE TABLE TechnicalInspection (
    InspectionId INT PRIMARY KEY IDENTITY,
    CarId INT FOREIGN KEY REFERENCES Cars(CarId),
    InspectionDate DATETIME NOT NULL,
    Result NVARCHAR(255) NOT NULL,
    NextInspectionDate DATETIME,
    Notes NVARCHAR(255)
);
CREATE TABLE Insurance (
    InsuranceId INT PRIMARY KEY IDENTITY,
    CarId INT FOREIGN KEY REFERENCES Cars(CarId),
    PolicyNumber NVARCHAR(255) NOT NULL,
    Provider NVARCHAR(255) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    CoverageDetails NVARCHAR(255),
    RelatedDocuments NVARCHAR(255)
);
CREATE TABLE Contracts (
    ContractId INT PRIMARY KEY IDENTITY,
    ReservationId INT FOREIGN KEY REFERENCES Reservations(ReservationId),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    TermsAndConditions NVARCHAR(MAX),
    SignedContractDocument NVARCHAR(255)
);
CREATE TABLE Discounts (
    DiscountId INT PRIMARY KEY IDENTITY,
    DiscountName NVARCHAR(255) NOT NULL,
    Description NVARCHAR(255),
    DiscountType NVARCHAR(255) NOT NULL,
    -- e.g., Percentage or FixedAmount
    DiscountValue DECIMAL(10, 2) NOT NULL,
    MinimumRentalDuration INT,
    -- Optional: Minimum rental duration for the discount to apply
    MaximumRentalDuration INT,
    -- Optional: Maximum rental duration for the discount to apply
    ApplicableCarCategoryIds NVARCHAR(MAX) -- Optional: Comma-separated list of applicable CarCategoryIds
);
CREATE TABLE Translations (
    TranslationId INT PRIMARY KEY IDENTITY,
    LanguageCode NVARCHAR(10) NOT NULL,
    TableName NVARCHAR(255) NOT NULL,
    ColumnName NVARCHAR(255) NOT NULL,
    ForeignKeyId INT NOT NULL,
    TranslatedText NVARCHAR(MAX) NOT NULL
);
CREATE TABLE Logs (
    LogId INT PRIMARY KEY IDENTITY,
    Category NVARCHAR(255),
    LogLevel NVARCHAR(20),
    Message NVARCHAR(MAX),
    TimeStamp DATETIME2
);