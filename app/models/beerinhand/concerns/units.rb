module Beerinhand
  module Concerns::Units
    extend ActiveSupport::Concern

    included do
      embeds_one :units, class_name: 'Unit', as: :unitable, cascade_callbacks: true

      after_initialize :build_units_if_nil

      def build_units_if_nil
        build_units if units.nil?
      end
    end
  end
end
