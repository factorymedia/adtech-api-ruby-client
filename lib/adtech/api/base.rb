module ADTech
  module API
    class Base
      extend Forwardable

      def_delegators :client, :reportService
      def_delegators :client, :websiteService
      def_delegators :client, :customerService

      alias_method :report_service, :reportService
      alias_method :website_service, :websiteService
      alias_method :customer_service, :customerService

      def initialize(client = nil)
        @client = client if client
      end

      def client
        @client ||= ADTech::Client.new.helios
      end
    end
  end
end
