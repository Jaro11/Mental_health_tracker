# app/services/external_api_analyzer.rb
class ExternalApiAnalyzer
  def self.analyze(journal_entry)
    response = Faraday.post('https://external.api/analyze') do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { text: journal_entry.content }.to_json
    end

    result = JSON.parse(response.body)
    # Process the result and store in the journal_entry, e.g., analysis_result
    journal_entry.update(analysis_result: result)
  end
end
