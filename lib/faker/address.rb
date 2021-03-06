module Faker
  class Address < Base
    flexible :address

    class << self
      def city
        parse('address.city')
      end

      def street_name
        parse('address.street_name')
      end

      def street_address(include_secondary = false)
        numerify(parse('address.street_address') + (include_secondary ? ' ' + secondary_address : ''))
      end

      def secondary_address
        numerify(fetch('address.secondary_address'))
      end

      def building_number
        bothify(fetch('address.building_number'))
      end

      def zip_code(state_abbreviation = '')
        return bothify(fetch('address.postcode')) if state_abbreviation === ''

        # provide a zip code that is valid for the state provided
        # see http://www.fincen.gov/forms/files/us_state_territory_zip_codes.pdf
        bothify(fetch('address.postcode_by_state.' + state_abbreviation))
      end

      def time_zone
        fetch('address.time_zone')
      end

      alias_method :zip, :zip_code
      alias_method :postcode, :zip_code

      def street_suffix; fetch('address.street_suffix'); end
      def city_suffix;   fetch('address.city_suffix');   end
      def city_prefix;   fetch('address.city_prefix');   end
      def state_abbr;    fetch('address.state_abbr');    end
      def state;         fetch('address.state');         end
      def country;       fetch('address.country');       end
      def country_code;  fetch('address.country_code');  end

      def latitude
        coord = ((rand * 180) - 90).to_f
        coord.round(12)
        coord.to_s
      end

      def longitude
        coord = ((rand * 360) - 180).to_f
        if coord > 100 || coord < 100
          coord.round(12)
        else
          coord.round(13)
        end
        coord.to_s        
      end

    end
  end
end
