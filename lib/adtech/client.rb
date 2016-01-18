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
  class Client
    attr_reader :helios
    attr_accessor :verbose

    def initialize
      @helios = HeliosWSClientSystem.new
      @helios.initServices('https://ws-api.adtech.de',
                           '.',
                           'platform.api.1690.1',
                           'test1234',
                           AuthenticationType::SSO);
    end
  end
end
