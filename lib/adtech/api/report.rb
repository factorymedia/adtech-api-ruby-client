import 'java.util.Calendar'
import 'java.util.GregorianCalendar'

module ADTech
  module API
    class Report < Base
      def get_report_url(report_type_id, start_date, end_date, entities)
        report = report_service.getReportById(report_type_id)

        ADTech.logger.info "Your report (#{report_type_id}) is of entity type: \
#{report.getEntityType} and report category: #{report.getReportCategory}"

        start_cal = gregoian_calendar(start_date.year,
                                      start_date.month - 1,
                                      start_date.day,
                                      0, 0, 0)
        ADTech.logger.info "Report start date set to: #{start_cal.getTime}";

        end_cal = gregorian_calendar(end_date.year,
                                     end_date.month - 1,
                                     end_date.day,
                                     23, 59, 59)
        ADTech.logger.info "Report end date set to: #{end_cal.getTime}";

        entities = default_entities(report.getReportCategory) if !entities || entities.empty?

        if entities
          report_queue_entry = report_service.requestReportByEntities(
            report_type_id,
            start_cal.getTime,
            end_cal.getTime,
            report_entity(report.getEntityType),
            report_category(report.getReportCategory),
            entities
          )
        else
          report_queue_entry = report_service.requestReport(
            report_type_id,
            start_cal.getTime,
            end_cal.getTime
          )
        end

        report_download_url(System.getProperty('line.separator'),
                            'csv',
                            report_queue_entry)
      end

      def report_download_url(line_sep, extension, report_queue_entry)
        ADTech.logger.info 'Start polling for report...'
        report_url = ''

        while (true)
          report_queue_entry =
            report_service.getReportQueueEntryById(report_queue_entry.getId())

          status = ''
          case report_queue_entry.getState()
          when IReportQueueEntry::STATE_ENTERED
            status = 'ENTERED'
          when IReportQueueEntry::STATE_BUSY
            status = 'BUSY'
          when IReportQueueEntry::STATE_FINISHED
            status = 'FINISHED'
          when IReportQueueEntry::STATE_DELETED
            status = 'DELETED'
          when IReportQueueEntry::STATE_FAILED
            status = 'FAILED'
          end

          if report_queue_entry.getState() == IReportQueueEntry::STATE_DELETED ||
            report_queue_entry.getState() == IReportQueueEntry::STATE_FAILED
            ADTech.logger.error "Report state is: #{status}"
            ADTech.logger.info 'Exiting...'
            break
          elsif report_queue_entry.getState() == IReportQueueEntry::STATE_FINISHED
            ADTech.logger.debug "Report state: #{status}"
            report_url = "#{report_queue_entry.getResultURL()}&format=#{extension}"
            ADTech.logger.info "ResultURL: '#{report_url}'"
            break
          end

          # ADTech API sample code recommends this sleep never set below 10s
          sleep(10)
        end

        report_url
      end

      private

      def default_entities(category)
        entities = case category
        when 'website'
          Admin.new(client).website_ids
        when 'customer'
          Admin.new(client).customer_ids
        when 'advertiser'
          Admin.new(client).advertiser_ids
        end
      end

      def gregorian_calendar(year, month, day, hour, minute, second)
        cal = GregorianCalendar.getInstance()
        cal.set(Calendar::DAY_OF_MONTH, day)
		    cal.set(Calendar::MONTH, month)
		    cal.set(Calendar::YEAR, year)
		    cal.set(Calendar::HOUR, hour)
		    cal.set(Calendar::MINUTE, minute)
		    cal.set(Calendar::SECOND, second)
        cal
      end

      def report_entity(entity)
        case entity
        when 'advertiser'
          IReport::REPORT_ENTITY_TYPE_ADVERTISER
        when 'customer'
          IReport::REPORT_ENTITY_TYPE_CUSTOMER
        when 'campaign'
          IReport::REPORT_ENTITY_TYPE_CAMPAIGN
        when 'mastercampaign'
          IReport::REPORT_ENTITY_TYPE_MASTERCAMPAIGN
        when 'network'
          IReport::REPORT_ENTITY_TYPE_NETWORK
        when 'website'
          IReport::REPORT_ENTITY_TYPE_WEBSITE
        end

      end

      def report_category(category)
        case category
        when 'campaign'
          IReport::REPORT_CATEGORY_CAMPAIGN
        when 'website'
          IReport::REPORT_CATEGORY_WEBSITE
        when 'page'
          IReport::REPORT_CATEGORY_PAGE
        when 'placement'
          IReport::REPORT_CATEGORY_PLACEMENT
        when 'customer'
          IReport::REPORT_CATEGORY_CUSTOMER
        when 'advertiser'
          IReport::REPORT_CATEGORY_ADVERTISER
        when 'bannersize'
          IReport::REPORT_CATEGORY_BANNERSIZE
        end
      end
    end
  end
end
