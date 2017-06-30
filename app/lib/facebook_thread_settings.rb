class FacebookThreadSettings
  class FacebookThreadError < StandardError
  end

  def initialize(bot)
    @bot = bot
  end

  def domains
    domain_index["data"][0]["whitelisted_domains"]
  end

  def domain_index
    client.get({fields: 'whitelisted_domains'})
  end

  def add_domain(domain)
    domain_action('add', domain)
  end

  def remove_domain(domain)
    domain_action('remove', domain)
  end

  def domain_action(action, domain)
    log_results(client.post({setting_type: 'domain_whitelisting',
                 whitelisted_domains: [domain],
                 domain_action_type: action}))
  end

  def log_results(results)
    raise FacebookThreadError, results["result"] unless results.code == 200
    puts results["result"]
  end

  def client
    @client ||= FacebookClient.new(@bot, 'thread_settings')
  end
end
