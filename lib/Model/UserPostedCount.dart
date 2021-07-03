class UserPostedCount {
  int _PropertyCount;
  int _FurnitureCount;
  int _ElectronicCount;
  int _ServiceCount;
  int _AdvertisementCount;
  int _LoanAgentCount;
  int _RentalAgentCount;

  int _ResidentalCount;
  int _CommericalCount;
  int _ProjectCount;
  int _ResidentalBuyCount;
  int _ResidentalRentCount;
  int _CommercialBuyCount;
  int _CommericalLeaseCount;
  int _ProjectResidentalCount;
  int _ProjectCommericalCount;


  UserPostedCount(this._PropertyCount, this._FurnitureCount,
      this._ElectronicCount, this._ServiceCount, this._AdvertisementCount, this._LoanAgentCount, this._RentalAgentCount);


  UserPostedCount.property(this._ResidentalCount, this._CommericalCount,
      this._ProjectCount, this._ResidentalBuyCount, this._ResidentalRentCount, this._CommercialBuyCount,
      this._CommericalLeaseCount, this._ProjectResidentalCount, this._ProjectCommericalCount);

  int get AdvertisementCount => _AdvertisementCount;

  set AdvertisementCount(int value) {
    _AdvertisementCount = value;
  }

  int get ServiceCount => _ServiceCount;

  set ServiceCount(int value) {
    _ServiceCount = value;
  }

  int get ElectronicCount => _ElectronicCount;

  set ElectronicCount(int value) {
    _ElectronicCount = value;
  }

  int get FurnitureCount => _FurnitureCount;

  set FurnitureCount(int value) {
    _FurnitureCount = value;
  }

  int get PropertyCount => _PropertyCount;

  set PropertyCount(int value) {
    _PropertyCount = value;
  }

  int get ProjectCommericalCount => _ProjectCommericalCount;

  set ProjectCommericalCount(int value) {
    _ProjectCommericalCount = value;
  }

  int get ProjectResidentalCount => _ProjectResidentalCount;

  set ProjectResidentalCount(int value) {
    _ProjectResidentalCount = value;
  }

  int get CommericalLeaseCount => _CommericalLeaseCount;

  set CommericalLeaseCount(int value) {
    _CommericalLeaseCount = value;
  }

  int get CommercialBuyCount => _CommercialBuyCount;

  set CommercialBuyCount(int value) {
    _CommercialBuyCount = value;
  }

  int get ResidentalRentCount => _ResidentalRentCount;

  set ResidentalRentCount(int value) {
    _ResidentalRentCount = value;
  }

  int get ResidentalBuyCount => _ResidentalBuyCount;

  set ResidentalBuyCount(int value) {
    _ResidentalBuyCount = value;
  }

  int get ProjectCount => _ProjectCount;

  set ProjectCount(int value) {
    _ProjectCount = value;
  }

  int get CommericalCount => _CommericalCount;

  set CommericalCount(int value) {
    _CommericalCount = value;
  }

  int get ResidentalCount => _ResidentalCount;

  set ResidentalCount(int value) {
    _ResidentalCount = value;
  }

  int get RentalAgentCount => _RentalAgentCount;

  set RentalAgentCount(int value) {
    _RentalAgentCount = value;
  }

  int get LoanAgentCount => _LoanAgentCount;

  set LoanAgentCount(int value) {
    _LoanAgentCount = value;
  }
}
