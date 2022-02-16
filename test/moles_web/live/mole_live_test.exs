defmodule MolesWeb.MoleLiveTest do
  use MolesWeb.ConnCase

  import Phoenix.LiveViewTest
  import Moles.RoundsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_mole(_) do
    mole = mole_fixture()
    %{mole: mole}
  end

  describe "Index" do
    setup [:create_mole]

    test "lists all moles", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.mole_index_path(conn, :index))

      assert html =~ "Listing Moles"
    end

    test "saves new mole", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.mole_index_path(conn, :index))

      assert index_live |> element("a", "New Mole") |> render_click() =~
               "New Mole"

      assert_patch(index_live, Routes.mole_index_path(conn, :new))

      assert index_live
             |> form("#mole-form", mole: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mole-form", mole: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mole_index_path(conn, :index))

      assert html =~ "Mole created successfully"
    end

    test "updates mole in listing", %{conn: conn, mole: mole} do
      {:ok, index_live, _html} = live(conn, Routes.mole_index_path(conn, :index))

      assert index_live |> element("#mole-#{mole.id} a", "Edit") |> render_click() =~
               "Edit Mole"

      assert_patch(index_live, Routes.mole_index_path(conn, :edit, mole))

      assert index_live
             |> form("#mole-form", mole: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#mole-form", mole: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mole_index_path(conn, :index))

      assert html =~ "Mole updated successfully"
    end

    test "deletes mole in listing", %{conn: conn, mole: mole} do
      {:ok, index_live, _html} = live(conn, Routes.mole_index_path(conn, :index))

      assert index_live |> element("#mole-#{mole.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#mole-#{mole.id}")
    end
  end

  describe "Show" do
    setup [:create_mole]

    test "displays mole", %{conn: conn, mole: mole} do
      {:ok, _show_live, html} = live(conn, Routes.mole_show_path(conn, :show, mole))

      assert html =~ "Show Mole"
    end

    test "updates mole within modal", %{conn: conn, mole: mole} do
      {:ok, show_live, _html} = live(conn, Routes.mole_show_path(conn, :show, mole))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Mole"

      assert_patch(show_live, Routes.mole_show_path(conn, :edit, mole))

      assert show_live
             |> form("#mole-form", mole: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#mole-form", mole: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.mole_show_path(conn, :show, mole))

      assert html =~ "Mole updated successfully"
    end
  end
end
