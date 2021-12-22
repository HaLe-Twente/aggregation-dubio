class Bdd
    attr_accessor :bdd_str

    def initialize(bdd_str)
        self.bdd_str = bdd_str
    end

    def has_var?(var)
        bdd_str.include?(var)
    end

    def has_rva(rva)
        bdd_str.include?(rva)
    end

    def ==(other)
        bdd_str == other.bdd_str
    end

    def prob(dictionary)
        # FIXME: get prob from dictionary
        return 0.5
    end
end
