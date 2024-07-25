defmodule SavorySlice.MenuTest do
  use SavorySlice.DataCase

  alias SavorySlice.Menu

  describe "pizzas" do
    alias SavorySlice.Menu.Pizza

    import SavorySlice.MenuFixtures

    @invalid_attrs %{description: nil, title: nil, imgUrl: nil, full_price: nil, price: nil, veg: nil}

    test "list_pizzas/0 returns all pizzas" do
      pizza = pizza_fixture()
      assert Menu.list_pizzas() == [pizza]
    end

    test "get_pizza!/1 returns the pizza with given id" do
      pizza = pizza_fixture()
      assert Menu.get_pizza!(pizza.id) == pizza
    end

    test "create_pizza/1 with valid data creates a pizza" do
      valid_attrs = %{description: "some description", title: "some title", imgUrl: "some imgUrl", full_price: "some full_price", price: "some price", veg: true}

      assert {:ok, %Pizza{} = pizza} = Menu.create_pizza(valid_attrs)
      assert pizza.description == "some description"
      assert pizza.title == "some title"
      assert pizza.imgUrl == "some imgUrl"
      assert pizza.full_price == "some full_price"
      assert pizza.price == "some price"
      assert pizza.veg == true
    end

    test "create_pizza/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_pizza(@invalid_attrs)
    end

    test "update_pizza/2 with valid data updates the pizza" do
      pizza = pizza_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title", imgUrl: "some updated imgUrl", full_price: "some updated full_price", price: "some updated price", veg: false}

      assert {:ok, %Pizza{} = pizza} = Menu.update_pizza(pizza, update_attrs)
      assert pizza.description == "some updated description"
      assert pizza.title == "some updated title"
      assert pizza.imgUrl == "some updated imgUrl"
      assert pizza.full_price == "some updated full_price"
      assert pizza.price == "some updated price"
      assert pizza.veg == false
    end

    test "update_pizza/2 with invalid data returns error changeset" do
      pizza = pizza_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_pizza(pizza, @invalid_attrs)
      assert pizza == Menu.get_pizza!(pizza.id)
    end

    test "delete_pizza/1 deletes the pizza" do
      pizza = pizza_fixture()
      assert {:ok, %Pizza{}} = Menu.delete_pizza(pizza)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_pizza!(pizza.id) end
    end

    test "change_pizza/1 returns a pizza changeset" do
      pizza = pizza_fixture()
      assert %Ecto.Changeset{} = Menu.change_pizza(pizza)
    end
  end

  describe "categories" do
    alias SavorySlice.Menu.Category

    import SavorySlice.MenuFixtures

    @invalid_attrs %{title: nil}

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Menu.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Menu.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Category{} = category} = Menu.create_category(valid_attrs)
      assert category.title == "some title"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Menu.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Category{} = category} = Menu.update_category(category, update_attrs)
      assert category.title == "some updated title"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Menu.update_category(category, @invalid_attrs)
      assert category == Menu.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Menu.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Menu.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Menu.change_category(category)
    end
  end
end
