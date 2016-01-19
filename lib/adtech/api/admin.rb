module ADTech
  module API
    class Admin < Base
      def website_ids(size = 9999)
        websites(size).map { |website| website.getId }
      end

      def websites(size)
        website_service.getWebsiteList(0, size, nil, nil)
      end

      def advertiser_ids(size = 9999)
        advertisers(size).map { |advertiser| advertiser.getId }
      end

      def advertisers(size)
        customer_service.getAdvertiserList(0, size, nil, nil)
      end

      def customer_ids(size = 9999)
        customers(size).map { |customer| customer.getId }
      end

      def customers(size)
        customer_service.getCustomerList(0, size, nil, nil)
      end
    end
  end
end
