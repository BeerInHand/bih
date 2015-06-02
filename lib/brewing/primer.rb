module Brewing
  class Primer

    PRIMER = {
      black_treacle:          0.330005,
      brown_sugar:            0.322141,
      belgian_candy_syrup:    0.45178,
      belgian_candy_sugar:    0.381074,
      corn_syrup:             0.416438,
      corn_sugar:             0.314278,
      demarara:               0.286,
      dme:                    0.418793,
      dextrose:               0.314278,
      honey:                  0.385006,
      invert_sugar_syrup:     0.314278,
      molasses:               0.400711,
      maple_syrup:            0.369279,
      rice_solids:            0.361438,
      sorghum_syrup:          0.416438,
      sucrose:                0.286,
      cane_sugar:             0.286,
      turbinado:              0.286
    }

    attr_accessor :type

    def self.is_valid_primer?(type)
      valid_types.include? type
    end

    def self.default_type
      :corn
    end

    def self.valid_types
      self::PRIMER.keys
    end

    def self.scrub_sugar(sugar)
      valid_types.detect { |s| s == sugar.downcase.to_sym } || default_type
    end

    def initialize(type)
      @type = self.class.scrub_sugar(type)
    end

    def factor
      PRIMER.fetch(type)
    end

  end
end

var sugar_data = [{
                    "title": "Corn Sugar",
                    "search_term": "corn+sugar",
                    "factor": 4,
                    "weightfactor": 1,
                    "volumedivide": 200,
                    "volumefactor": 1
                  }, {
                    "title": "Sucrose",
                    "search_term": "sucrose",
                    "factor": 4,
                    "weightfactor": 0.91,
                    "volumedivide": 200,
                    "volumefactor": 0.88
                  }, {
                    "title": "Turbinado",
                    "search_term": "turbinado",
                    "factor": 4,
                    "weightfactor": 0.91,
                    "volumedivide": 200,
                    "volumefactor": 0.88
                  }, {
                    "title": "Demarara",
                    "search_term": "demarara",
                    "factor": 4,
                    "weightfactor": 0.91,
                    "volumedivide": 200,
                    "volumefactor": 1
                  }, {
                    "title": "Dextrose",
                    "search_term": "dextrose",
                    "factor": 4,
                    "weightfactor": 1,
                    "volumedivide": 200,
                    "volumefactor": 1
                  }, {
                    "title": "Corn Syrup",
                    "search_term": "corn+syrup",
                    "factor": 5.3,
                    "weightfactor": 1,
                    "volumedivide": 325,
                    "volumefactor": 1
                  }, {
                    "title": "Brown Sugar",
                    "search_term": "Brown+Sugar",
                    "factor": 4.1,
                    "weightfactor": 1,
                    "volumedivide": 230,
                    "volumefactor": 1
                  }, {
                    "title": "Molasses",
                    "search_term": "Molasses",
                    "factor": 5.1,
                    "weightfactor": 1,
                    "volumedivide": 320,
                    "volumefactor": 1
                  }, {
                    "title": "Maple Syrup",
                    "search_term": "Maple+Syrup",
                    "factor": 4.7,
                    "weightfactor": 1,
                    "volumedivide": 320,
                    "volumefactor": 1
                  }, {
                    "title": "Sorghum Syrup",
                    "search_term": "Sorghum+Syrup",
                    "factor": 5.3,
                    "weightfactor": 1,
                    "volumedivide": 320,
                    "volumefactor": 1
                  }, {
                    "title": "Honey",
                    "search_term": "Honey",
                    "factor": 4.9,
                    "weightfactor": 1,
                    "volumedivide": 340,
                    "volumefactor": 1
                  }, {
                    "title": "DME - All Varieties",
                    "search_term": "DME",
                    "factor": 5.33,
                    "weightfactor": 1,
                    "volumedivide": 165,
                    "volumefactor": 1
                  }, {
                    "title": "DME - Laaglander",
                    "search_term": "DME",
                    "factor": 7.3,
                    "weightfactor": 1,
                    "volumedivide": 165,
                    "volumefactor": 1
                  }, {
                    "title": "Belgian Candy Syrup - All",
                    "search_term": "Belgian+Candy+Syrup",
                    "factor": 5.75,
                    "weightfactor": 1,
                    "volumedivide": 320,
                    "volumefactor": 1
                  }, {
                    "title": "Belgian Candy Sugar - All",
                    "search_term": "Belgian+Candy+Sugar",
                    "factor": 4.85,
                    "weightfactor": 1,
                    "volumedivide": 230,
                    "volumefactor": 1
                  }, {
                    "title": "Invert Sugar Syrup - All",
                    "search_term": "Invert+Sugar",
                    "factor": 4,
                    "weightfactor": 1,
                    "volumedivide": 320,
                    "volumefactor": 1
                  }, {
                    "title": "Black Treacle",
                    "search_term": "Black+Treacle",
                    "factor": 4.2,
                    "weightfactor": 1,
                    "volumedivide": 320,
                    "volumefactor": 1
                  }, {
                    "title": "Rice Solids",
                    "search_term": "Rice+Solids",
                    "factor": 4.6,
                    "weightfactor": 1,
                    "volumedivide": 220,
                    "volumefactor": 1
}];
