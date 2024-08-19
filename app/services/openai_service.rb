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

  def get_advice(prompt)
    body = {
      model: "gpt-4",
      messages: [
        { role: "system", content: "You are a helpful assistant providing mental health advice." },
        { role: "user", content: prompt }
      ],
      max_tokens: 150,
      temperature: 0.7
    }

    # Directly use the full URI in the post request
    response = self.class.post(@base_uri, headers: @headers, body: body.to_json)

    puts "OpenAI API Response: #{response.body}"  # Debugging: Output the raw API response

    if response.success?
      advice = response.parsed_response["choices"].first["message"]["content"].strip
      puts "Parsed Advice: #{advice}"  # Debugging: Output the parsed advice
      advice
    else
      error_message = "Sorry, I couldn't generate advice at this time."
      puts "Error: #{response.body}"  # Debugging: Output the error message
      error_message
    end
  end
end
