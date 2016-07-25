require 'fuzy_iron/version'
require 'iron_mq'
require 'yaml'
require 'json'

module FuzyIron
  def self.configure
    @iron_config = YAML.load_file('config/iron.yml')
    abort("Did not find 'config'. Check 'read me'.") if @iron_config.nil?
  end

  def self.feed
    client = init_iron_client
    abort("Client is missing, run 'configure'.") unless client
    start_time = Time.now.utc

    qu = client.queue(iron_queue_name)

    payload_file = File.read('payload/payload.json', encoding: 'utf-8')
    payload_json = JSON.parse(payload_file, symbolize_names: true)

    message_count.times do |_i|
      response = qu.post(payload_json.to_json)
      abort("enqueue failed") unless response.code == 200
      puts "#{_i+1}: (id - #{response.raw["id"]})"
    end
    end_time = Time.now.utc
    puts "(duration: #{end_time - start_time})"
 end

  private

  def self.iron_queue_name
    @iron_config['queue_name']
  end

  def self.message_count
    YAML.load_file('config/config.yml')['message_count'] || 1
  end

  def self.init_iron_client
    IronMQ::Client.new(
      host: @iron_config[:host],
      token: @iron_config[:token],
      project_id: @iron_config[:project_id]
    )
  end
end
