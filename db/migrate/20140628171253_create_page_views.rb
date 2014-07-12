Sequel.migration do
  change do

    create_table :page_views do
      primary_key :id
      String :url
      String :referrer
      DateTime :created_at
      String :hash
      index [:url, :created_at]
    end

  end
end