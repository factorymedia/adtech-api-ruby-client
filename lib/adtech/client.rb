java_package 'de.adtech.helios'
import 'de.adtech.helios.ReportManagement.Report'
import 'de.adtech.helios.ReportManagement.ReportQueueEntry'
import 'de.adtech.helios.ReportManagement.ReportAccessSettings'
import 'de.adtech.helios.NetworkManagement.NetworkInfo'
import 'de.adtech.webservices.helios.client.HeliosWSClientSystem'
import 'de.adtech.webservices.helios.client.auth.AuthenticationType'
import 'de.adtech.webservices.helios.lowLevel.constants.IReportAccessSettings'
import 'de.adtech.webservices.helios.lowLevel.constants.IReportQueueEntry'
import 'de.adtech.webservices.helios.lowLevel.constants.IReport'

module ADTech
  EU_SERVER = 'https://ws-api.adtech.de'
  US_SERVER = 'https://ws-api.adtechus.com'

  class Client
    attr_reader :helios
    attr_accessor :verbose
    attr_accessor :region

    class << self
      attr_accessor :region
      attr_accessor :user
      attr_accessor :password
    end

    def initialize
      @helios = HeliosWSClientSystem.new
      @helios.initServices(api_server_url,
                           Dir::tmpdir(),
                           Client.user,
                           Client.password,
                           AuthenticationType::SSO);
    end
    
    private

    def api_server_url
      return EU_SERVER unless Client.region
      Client.region
    end
  end
end
