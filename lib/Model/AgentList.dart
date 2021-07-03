class AgentList {
  int _AgentId;
  String _AgentName;
  String _AgentCity;
  String _AgentAddress;
  String _AgentImage;

  AgentList(
    this._AgentId,
    this._AgentName,
    this._AgentCity,
    this._AgentAddress,
    this._AgentImage,
  );
  AgentList.onlybasic(this._AgentId, this._AgentName,);

  String get AgentImage => _AgentImage;

  set AgentImage(String value) {
    _AgentImage = value;
  }

  String get AgentAddress => _AgentAddress;

  set AgentAddress(String value) {
    _AgentAddress = value;
  }

  String get AgentCity => _AgentCity;

  set AgentCity(String value) {
    _AgentCity = value;
  }

  String get AgentName => _AgentName;

  set AgentName(String value) {
    _AgentName = value;
  }

  int get AgentId => _AgentId;

  set AgentId(int value) {
    _AgentId = value;
  }
}
