class DealerSyncServices
    API_URL = "https://fakerapi.it/api/v1/companies?_seed=1&_quantity=200"

    def self.call
        response = Faraday.get(API_URL)
        body = JSON.parse(response.body)

        remote_ids = []

        body["data"].each do |company|
            dealer = map_company(company)
            remote_ids << dealer[:remote_id]

            Dealer.upsert(dealer, unique_by: :remote_id)
        end

        Dealer.where.not(remote_id: remote_ids).delete_all
    end

    def self.map_company(company)
        address = company["addresses"]&.first || {}

        {
            remote_id: company["id"],
            name: company["name"],
            phone: company["phone"],
            street: address["street"],
            city: address["city"],
            zipcode: address["zipcode"],
            country: address["country"],
            latitude: address["latitude"],
            longitude: address["longitude"],
            synced_at: Time.current
        }
    end
end