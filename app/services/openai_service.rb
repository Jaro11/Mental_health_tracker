require 'httparty'

class OpenaiService
  include HTTParty

  def initialize
    @base_uri = 'https://api.openai.com/v1/chat/completions'
    @headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}"
    }
  end

  def get_advice(user_message)
    full_prompt = <<~PROMPT
      I am an AI assistant trained to provide mental health advice.
      The user has written the following message:
      "#{user_message.strip}"

      Please provide specific mental health advice and suggestions that may help the user.
    PROMPT

    body = {
      model: "gpt-4",
      messages: [
        { role: "system", content: "You are a helpful assistant providing mental health advice." },
        { role: "user", content: full_prompt }
      ],
      max_tokens: 150,
      temperature: 0.7
    }

    Rails.logger.debug "Full Prompt sent to OpenAI: #{full_prompt}"

    response = self.class.post(@base_uri, headers: @headers, body: body.to_json)

    Rails.logger.debug "OpenAI API Response: #{response.body}"

    if response.success?
      response.parsed_response["choices"].first["message"]["content"].strip
    else
      "Sorry, I couldn't generate advice at this time."
    end
  end

  def analyze_journal_entries(journal_entries)
    prompt = "Analyze my journal entries and provide trends on my mental health:\n\n"

    journal_entries.each do |entry|
      sanitized_content = entry.content.gsub(/[^0-9a-z ]/i, '') # Remove special characters
      prompt += "#{entry.created_at.strftime('%Y-%m-%d')}: #{sanitized_content}\n"
    end

    body = {
      model: "gpt-4",
      messages: [
        { role: "system", content: "You are an expert in analyzing mental health trends." },
        { role: "user", content: prompt }
      ],
      max_tokens: 300,
      temperature: 0.7
    }

    Rails.logger.debug "OpenAI API Request: #{body.to_json}"

    response = self.class.post(@base_uri, headers: @headers, body: body.to_json)

    Rails.logger.debug "OpenAI API Response: #{response.body}"

    if response.success?
      response.parsed_response["choices"].first["message"]["content"].strip
    else
      raise "OpenAI API Error: #{response.parsed_response['error']['message']}"
    end
  rescue => e
    Rails.logger.error "An error occurred while analyzing journal entries: #{e.message}"
    raise
  end
end
