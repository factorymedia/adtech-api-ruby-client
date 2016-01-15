module ADTech
  module API
    class Report

      def client
        @client ||= ADTech::Client.new.helios
      end

      def get_report(report_type_id, start_date, end_date, entities)
        report = self.client.reportService.getReportById(report_type_id)

        puts "Your report (#{report_type_id}) is of entity type: #{report.getEntityType} "
             "and report category: #{report.getReportCategory()}"
      end
    end
  end
end
