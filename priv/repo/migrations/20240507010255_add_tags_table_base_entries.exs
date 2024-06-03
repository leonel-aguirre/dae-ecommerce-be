defmodule DaeEcommerceBe.Repo.Migrations.AddTagsTableBaseEntries do
  use Ecto.Migration

  def up do
    execute """
    INSERT INTO tags (id, title, inserted_at, updated_at) VALUES
    (uuid_generate_v4(), 'Electronics', current_timestamp, current_timestamp),
    (uuid_generate_v4(), 'Clothing', current_timestamp, current_timestamp),
    (uuid_generate_v4(), 'Books & Audible', current_timestamp, current_timestamp),
    (uuid_generate_v4(), 'Toys & Games', current_timestamp, current_timestamp),
    (uuid_generate_v4(), 'Automotive', current_timestamp, current_timestamp),
    (uuid_generate_v4(), 'Pet Supplies', current_timestamp, current_timestamp);
    """
  end

  def down do
    execute "DELETE FROM tags;"
  end
end
