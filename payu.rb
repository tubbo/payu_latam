require "json/add/core"
require "uri"
require "net/https"

class Payu
    def initialize(api_key, api_login, test=false, lang="es")
        @api_key = api_key
        @api_login = api_login
        @test = test
        @lang = lang

        @api_uri = URI.parse("https://#{'stg.' if test}api.payulatam.com")
        @payments_api_url = "/payments-api/4.0/service.cgi"
        @reports_api_url = "/reports-api/4.0/service.cgi"
    end

    #Reports API methods
    def ping_reports
        https_post(@reports_api_url, "PING")
    end

    def order_detail(order_id)
        payload = { "details" => { "orderId" => order_id } }
        https_post(@reports_api_url, "ORDER_DETAIL", payload)
    end

    def order_detail_by_reference_code(reference_code)
        payload = { "details" => { "referenceCode" => reference_code } }
        https_post(@reports_api_url, "ORDER_DETAIL_BY_REFERENCE_CODE", payload)
    end

    def transaction_response_detail(transaction_id)
        payload = { "details" => { "transactionId" => transaction_id } }
        https_post(@reports_api_url, "TRANSACTION_RESPONSE_DETAIL", payload)
    end

    #Payments API methods
    def ping_payments
        https_post(@payments_api_url, "PING")
    end

    def get_payment_methods
        https_post(@payments_api_url, "GET_PAYMENT_METHODS")
    end

    def submit_transaction(payload)
        https_post(@payments_api_url, "SUBMIT_TRANSACTION", payload)
    end

    private

    def https_post(url, command, data={})
        http = Net::HTTP.new(@api_uri.host, @api_uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        data["merchant"] = {
            "apiKey" =>     @api_key,
            "apiLogin" =>   @api_login
        }

        data["command"] = command
        data["test"] = @test
        data["language"] = data["language"] || @lang

        headers = {
            "Accept" =>         "application/json",
            "Content-Type" =>   "application/json; charset=utf-8"
        }

        result = http.send_request("POST", url, data.to_json, headers)

        begin
            response = JSON.parse(result.body)
        rescue Exception => e
            response = result.body
        end

        return {
            "status" => result.code,
            "response" => response
        }
    end

end
