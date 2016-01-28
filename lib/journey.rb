class Journey < Struct.new :entry_station, :exit_station, :history


def in_journey?
!!entry_station
end

def complete?
  !!exit_station

end

def history_log
  self.history = [self.entry_station, self.exit_station]

end

end
