RSpec.describe ADTech::API::Report do
  before do
    ADTech::Client.region = ADTech::EU_SERVER
    ADTech::Client.user = 'platform.api.1690.1'
    ADTech::Client.password = 'test1234'
    @report = ADTech::API::Report.new
  end

  context 'when invoking get_report url with missing parameters' do
    it 'raises ArgumentError if report type is missing' do
      start_date = Date.today - 1
      end_date = Date.today - 2
      testing_sites = [1185844]
      expect {
        @report.get_report_url(start_date, end_date, testing_sites)
      }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if start date is missing' do
      report_type_id = 1293
      testing_sites = [1185844]
      end_date = Date.today - 2
      expect {
        @report.get_report_url(report_type_id, end_date, testing_sites)
      }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if end date is missing' do
      report_type_id = 1293
      testing_sites = [1185844]
      start_date = Date.today - 1
      expect {
        @report.get_report_url(report_type_id, start_date, testing_sites)
      }.to raise_error(ArgumentError)
    end

    it 'raises ArgumentError if testing sites are missing' do
      report_type_id = 1293
      start_date = Date.today - 1
      end_date = Date.today - 2
      expect {
        @report.get_report_url(report_type_id, start_date, end_date)
      }.to raise_error(ArgumentError)
    end
  end

  context 'when invoking get_report url correctly' do
    before do
      @report_double = instance_double('report',
        :getEntityType => 'test',
        :getReportCategory => 'test'
        )
      @service_double = instance_double('report_service',
        :getReportById => @report_double,
        :requestReportByEntities => '',
        :requestReport => '',
        )
      allow(@report).to receive(:report_service) { @service_double }
      allow(@report).to receive(:report_download_url) { true }
    end

    it 'calls requestReportByEntities if entities are present' do
      report_type_id = 1293
      testing_sites = [1185844]
      reporting_day = Date.today - 1
      expect(@service_double).to receive(:requestReportByEntities)
      report_url = @report.get_report_url(report_type_id,
                                         reporting_day,
                                         reporting_day,
                                         testing_sites)
    end

    it 'calls requestReport if no entities are present' do
      report_type_id = 1293
      testing_sites = nil
      reporting_day = Date.today - 1
      expect(@service_double).to receive(:requestReport)
      report_url = @report.get_report_url(report_type_id,
                                         reporting_day,
                                         reporting_day,
                                         testing_sites)
    end
  end

  context 'when downloading url' do
    before do
      @report_entry = instance_double('id', :getId => 1)
    end

    it 'returns url once AdTech responds with finished state' do
      @entry_double = instance_double('entry',
       :getState => IReportQueueEntry::STATE_FINISHED,
       :getResultURL => 'http://test/report-url'
      )
      @service_double = instance_double('report_service',
        :getReportQueueEntryById => @entry_double
        )
      allow(@report).to receive(:report_service) { @service_double }
      result_url = @report.report_download_url(nil, nil, @report_entry)
      expect(result_url).to eq('http://test/report-url&format=')
    end

    it 'returns url once AdTech responds with finished state' do
      @entry_double = instance_double('entry',
       :getState => IReportQueueEntry::STATE_FAILED,
       :getResultURL => 'http://test/report-url'
      )
      @service_double = instance_double('report_service',
        :getReportQueueEntryById => @entry_double
        )
      allow(@report).to receive(:report_service) { @service_double }
      result_url = @report.report_download_url(nil, nil, @report_entry)
      expect(result_url).to eq('')
    end
  end
end