defmodule DaeEcommerceBe.ProductsTest do
  use DaeEcommerceBe.DataCase

  alias DaeEcommerceBe.Products

  describe "products" do
    alias DaeEcommerceBe.Products.Product

    import DaeEcommerceBe.ProductsFixtures

    @invalid_attrs %{description: nil, title: nil, is_disabled: nil, current_price: nil, previous_price: nil, tags: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{description: "some description", title: "some title", is_disabled: true, current_price: 120.5, previous_price: 120.5, tags: ["option1", "option2"]}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.description == "some description"
      assert product.title == "some title"
      assert product.is_disabled == true
      assert product.current_price == 120.5
      assert product.previous_price == 120.5
      assert product.tags == ["option1", "option2"]
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", is_disabled: false, current_price: 456.7, previous_price: 456.7, tags: ["option1"]}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.description == "some updated description"
      assert product.title == "some updated title"
      assert product.is_disabled == false
      assert product.current_price == 456.7
      assert product.previous_price == 456.7
      assert product.tags == ["option1"]
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end
end
