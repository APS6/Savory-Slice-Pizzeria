defmodule SavorySliceWeb.PizzaControllerTest do
  use SavorySliceWeb.ConnCase

  import SavorySlice.MenuFixtures

  @create_attrs %{description: "some description", title: "some title", imgUrl: "some imgUrl", full_price: "some full_price", price: "some price", veg: true}
  @update_attrs %{description: "some updated description", title: "some updated title", imgUrl: "some updated imgUrl", full_price: "some updated full_price", price: "some updated price", veg: false}
  @invalid_attrs %{description: nil, title: nil, imgUrl: nil, full_price: nil, price: nil, veg: nil}

  describe "index" do
    test "lists all pizzas", %{conn: conn} do
      conn = get(conn, ~p"/pizzas")
      assert html_response(conn, 200) =~ "Listing Pizzas"
    end
  end

  describe "new pizza" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/pizzas/new")
      assert html_response(conn, 200) =~ "New Pizza"
    end
  end

  describe "create pizza" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/pizzas", pizza: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/pizzas/#{id}"

      conn = get(conn, ~p"/pizzas/#{id}")
      assert html_response(conn, 200) =~ "Pizza #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/pizzas", pizza: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pizza"
    end
  end

  describe "edit pizza" do
    setup [:create_pizza]

    test "renders form for editing chosen pizza", %{conn: conn, pizza: pizza} do
      conn = get(conn, ~p"/pizzas/#{pizza}/edit")
      assert html_response(conn, 200) =~ "Edit Pizza"
    end
  end

  describe "update pizza" do
    setup [:create_pizza]

    test "redirects when data is valid", %{conn: conn, pizza: pizza} do
      conn = put(conn, ~p"/pizzas/#{pizza}", pizza: @update_attrs)
      assert redirected_to(conn) == ~p"/pizzas/#{pizza}"

      conn = get(conn, ~p"/pizzas/#{pizza}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, pizza: pizza} do
      conn = put(conn, ~p"/pizzas/#{pizza}", pizza: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pizza"
    end
  end

  describe "delete pizza" do
    setup [:create_pizza]

    test "deletes chosen pizza", %{conn: conn, pizza: pizza} do
      conn = delete(conn, ~p"/pizzas/#{pizza}")
      assert redirected_to(conn) == ~p"/pizzas"

      assert_error_sent 404, fn ->
        get(conn, ~p"/pizzas/#{pizza}")
      end
    end
  end

  defp create_pizza(_) do
    pizza = pizza_fixture()
    %{pizza: pizza}
  end
end
