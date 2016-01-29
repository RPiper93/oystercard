class Station

attr_reader :name, :zone
STATION_LIST = [["Victoria", 1],["Westminster", 1],["Waterloo",2],["Walford", 3],["Camden Town", 4],["Richmansworth",5]]

def initialize(code)
  @name = STATION_LIST[code][0]
  @zone = STATION_LIST[code][1]
end


end
