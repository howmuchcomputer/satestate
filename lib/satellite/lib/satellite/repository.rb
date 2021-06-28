module Repository
  class InMemoryRepository < Array
    def average
      sum(0.0) / size
    end

    def last(count)
      self.class.new(super(count))
    end
  end
end