class PostToSlack
  include Interactor

  def call
    response = Faraday.post(
      ENV['WEBHOOK_URL'], 
      "{'channel': '#general', 'username': 'webhookbot', 'text': #{context.text}}",
      "Content-Type" => "application/json"
    )
  end
end
