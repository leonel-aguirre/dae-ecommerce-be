defmodule DaeEcommerceBe.ProductRatingsTest do
  use DaeEcommerceBe.DataCase

  alias DaeEcommerceBe.ProductRatings

  describe "product_ratings" do
    alias DaeEcommerceBe.ProductRatings.ProductRating

    import DaeEcommerceBe.ProductRatingsFixtures

    @invalid_attrs %{rating: nil}

    test "list_product_ratings/0 returns all product_ratings" do
      product_rating = product_rating_fixture()
      assert ProductRatings.list_product_ratings() == [product_rating]
    end

    test "get_product_rating!/1 returns the product_rating with given id" do
      product_rating = product_rating_fixture()
      assert ProductRatings.get_product_rating!(product_rating.id) == product_rating
    end

    test "create_product_rating/1 with valid data creates a product_rating" do
      valid_attrs = %{rating: 120.5}

      assert {:ok, %ProductRating{} = product_rating} = ProductRatings.create_product_rating(valid_attrs)
      assert product_rating.rating == 120.5
    end

    test "create_product_rating/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductRatings.create_product_rating(@invalid_attrs)
    end

    test "update_product_rating/2 with valid data updates the product_rating" do
      product_rating = product_rating_fixture()
      update_attrs = %{rating: 456.7}

      assert {:ok, %ProductRating{} = product_rating} = ProductRatings.update_product_rating(product_rating, update_attrs)
      assert product_rating.rating == 456.7
    end

    test "update_product_rating/2 with invalid data returns error changeset" do
      product_rating = product_rating_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductRatings.update_product_rating(product_rating, @invalid_attrs)
      assert product_rating == ProductRatings.get_product_rating!(product_rating.id)
    end

    test "delete_product_rating/1 deletes the product_rating" do
      product_rating = product_rating_fixture()
      assert {:ok, %ProductRating{}} = ProductRatings.delete_product_rating(product_rating)
      assert_raise Ecto.NoResultsError, fn -> ProductRatings.get_product_rating!(product_rating.id) end
    end

    test "change_product_rating/1 returns a product_rating changeset" do
      product_rating = product_rating_fixture()
      assert %Ecto.Changeset{} = ProductRatings.change_product_rating(product_rating)
    end
  end
end
