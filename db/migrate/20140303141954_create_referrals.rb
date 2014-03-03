class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :site
      t.string :referrer
      t.string :category
      t.integer :global_rank
      t.decimal :share
      t.decimal :change
      t.date :date_from
      t.date :date_to
      t.timestamps
    end
  end
end
