defmodule SavorySlice.PizzaBasketTest do
  use SavorySlice.DataCase

  alias SavorySlice.PizzaBasket

  describe "baskets" do
    alias SavorySlice.PizzaBasket.Basket

    import SavorySlice.PizzaBasketFixtures

    @invalid_attrs %{user_id: nil}

    test "list_baskets/0 returns all baskets" do
      basket = basket_fixture()
      assert PizzaBasket.list_baskets() == [basket]
    end

    test "get_basket!/1 returns the basket with given id" do
      basket = basket_fixture()
      assert PizzaBasket.get_basket!(basket.id) == basket
    end

    test "create_basket/1 with valid data creates a basket" do
      valid_attrs = %{user_id: "some user_id"}

      assert {:ok, %Basket{} = basket} = PizzaBasket.create_basket(valid_attrs)
      assert basket.user_id == "some user_id"
    end

    test "create_basket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PizzaBasket.create_basket(@invalid_attrs)
    end

    test "update_basket/2 with valid data updates the basket" do
      basket = basket_fixture()
      update_attrs = %{user_id: "some updated user_id"}

      assert {:ok, %Basket{} = basket} = PizzaBasket.update_basket(basket, update_attrs)
      assert basket.user_id == "some updated user_id"
    end

    test "update_basket/2 with invalid data returns error changeset" do
      basket = basket_fixture()
      assert {:error, %Ecto.Changeset{}} = PizzaBasket.update_basket(basket, @invalid_attrs)
      assert basket == PizzaBasket.get_basket!(basket.id)
    end

    test "delete_basket/1 deletes the basket" do
      basket = basket_fixture()
      assert {:ok, %Basket{}} = PizzaBasket.delete_basket(basket)
      assert_raise Ecto.NoResultsError, fn -> PizzaBasket.get_basket!(basket.id) end
    end

    test "change_basket/1 returns a basket changeset" do
      basket = basket_fixture()
      assert %Ecto.Changeset{} = PizzaBasket.change_basket(basket)
    end
  end

  describe "basket_items" do
    alias SavorySlice.PizzaBasket.BasketItem

    import SavorySlice.PizzaBasketFixtures

    @invalid_attrs %{price_when_carted: nil, quantity: nil}

    test "list_basket_items/0 returns all basket_items" do
      basket_item = basket_item_fixture()
      assert PizzaBasket.list_basket_items() == [basket_item]
    end

    test "get_basket_item!/1 returns the basket_item with given id" do
      basket_item = basket_item_fixture()
      assert PizzaBasket.get_basket_item!(basket_item.id) == basket_item
    end

    test "create_basket_item/1 with valid data creates a basket_item" do
      valid_attrs = %{price_when_carted: "120.5", quantity: 42}

      assert {:ok, %BasketItem{} = basket_item} = PizzaBasket.create_basket_item(valid_attrs)
      assert basket_item.price_when_carted == Decimal.new("120.5")
      assert basket_item.quantity == 42
    end

    test "create_basket_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PizzaBasket.create_basket_item(@invalid_attrs)
    end

    test "update_basket_item/2 with valid data updates the basket_item" do
      basket_item = basket_item_fixture()
      update_attrs = %{price_when_carted: "456.7", quantity: 43}

      assert {:ok, %BasketItem{} = basket_item} = PizzaBasket.update_basket_item(basket_item, update_attrs)
      assert basket_item.price_when_carted == Decimal.new("456.7")
      assert basket_item.quantity == 43
    end

    test "update_basket_item/2 with invalid data returns error changeset" do
      basket_item = basket_item_fixture()
      assert {:error, %Ecto.Changeset{}} = PizzaBasket.update_basket_item(basket_item, @invalid_attrs)
      assert basket_item == PizzaBasket.get_basket_item!(basket_item.id)
    end

    test "delete_basket_item/1 deletes the basket_item" do
      basket_item = basket_item_fixture()
      assert {:ok, %BasketItem{}} = PizzaBasket.delete_basket_item(basket_item)
      assert_raise Ecto.NoResultsError, fn -> PizzaBasket.get_basket_item!(basket_item.id) end
    end

    test "change_basket_item/1 returns a basket_item changeset" do
      basket_item = basket_item_fixture()
      assert %Ecto.Changeset{} = PizzaBasket.change_basket_item(basket_item)
    end
  end
end
