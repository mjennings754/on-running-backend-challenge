class DealersController < ApplicationController
    require 'httparty'

    API_URL = "https://fakerapi.it/api/v1/companies?_seed1&_quantity=200"

    def index
        fetch_and_store_dealers unless Dealer.exists?

        dealers = Dealer.all
        render json: dealers: status: :ok
    end
    
    private

    def fetch_and_store_dealers
        response = HTTParty.get(API_URL)


        if response.success?
            dealers_data = response.parsed_repsonse

            Rails.logger.info("Fetched dealer info: #{dealers_data.inspect}")

            if dealers_data.is_a?(Array)
                dealers_data.each do |dealer_data|
                    Dealer.create(
                        name: dealer_data["name"],
                        phone: dealer_data["phone"],
                        street: dealer_data["addresses"][0]["street"],
                        city: dealer_data["addresses"][0]["city"],
                        zipcode: dealer_data["addresses"][0]["zipcode"],
                        country: dealer_data["addresses"][0]["country"],
                        latitude: dealer_data["addresses"][0]["latitude"],
                        longitude: dealer_data["addresses"][0]["longitude"],
                    )
                end
            elsif dealers_data.is_a?(Hash) && dealers_data["data"].is_a?(Array)
                dealers_data["data"].each do |dealer_data|
                    Dealer.create(
                        name: dealer_data["name"],
                        phone: dealer_data["phone"],
                        street: dealer_data["addresses"][0]["street"],
                        city: dealer_data["addresses"][0]["city"],
                        zipcode: dealer_data["addresses"][0]["zipcode"],
                        country: dealer_data["addresses"][0]["country"],
                        latitude: dealer_data["addresses"][0]["latitude"],
                        longitude: dealer_data["addresses"][0]["longitude"],  
                    )
                end
            else
                Rails.logger.error(dealers_data.inspect)
            end
        else
            Rails.logger.error(response.message)
        end
    end
end